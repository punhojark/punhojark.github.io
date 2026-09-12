require 'httparty'
require 'jekyll'
require 'nokogiri'
require 'time'
require 'uri'

# Keep short, plain-text previews here; the articles stay on Medium.
module MediumFeed
  def self.posts(xml, limit: 10)
    document = Nokogiri::XML(xml) { |config| config.strict.nonet }
    raise 'Unexpected feed format' unless document.at_xpath('/rss/channel')

    document.xpath('/rss/channel/item').filter_map do |item|
      title = item.at_xpath('title')&.text.to_s.strip
      url = URI.parse(item.at_xpath('link')&.text.to_s.strip)
      next unless url.scheme == 'https' && (url.host == 'medium.com' || url.host&.end_with?('.medium.com'))
      next if title.empty? || url.userinfo

      url.query = nil
      url.fragment = nil
      content = item.at_xpath('*[local-name()="encoded"]')&.text || item.at_xpath('description')&.text.to_s
      fragment = Nokogiri::HTML.fragment(content)
      fragment.css('script, style, figure, img').remove
      paragraphs = fragment.css('p').map { |paragraph| paragraph.text.strip }.reject(&:empty?)
      excerpt = (paragraphs.empty? ? fragment.text : paragraphs.join(' ')).gsub(/[[:space:]]+/, ' ').strip
      if excerpt.length > 220
        preview = excerpt[0, 217]
        boundary = preview.rindex(' ')
        preview = preview[0, boundary] if boundary && boundary > 150
        excerpt = "#{preview.rstrip}…"
      end

      {
        'title' => title,
        'url' => url.to_s,
        'date' => Time.parse(item.at_xpath('pubDate')&.text.to_s).utc.strftime('%Y-%m-%d'),
        'excerpt' => excerpt,
        'language' => title.match?(/[가-힣]/) ? 'ko' : 'en'
      }
    rescue ArgumentError, URI::InvalidURIError
      # One malformed entry should not hide the rest of the feed.
      next
    end.uniq { |post| post['url'] }.sort_by { |post| post['date'] }.reverse.first(limit)
  end

  class Generator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      config = site.config['medium_blog'] || {}
      return unless config['enabled']

      response = HTTParty.get(config.fetch('feed_url'), timeout: 10)
      raise "HTTP #{response.code}" unless response.code == 200
      raise 'Feed exceeds size limit' if response.body.bytesize > 2_000_000

      posts = MediumFeed.posts(response.body, limit: config.fetch('limit', 10).to_i.clamp(1, 20))
      raise 'Feed contains no usable posts' if posts.empty?

      # Medium's RSS feed only includes recent posts; retain our older entries.
      archived = site.data.dig('medium_posts', 'posts') || []
      combined = (posts + archived).uniq { |post| post['url'] }
      combined.sort_by! { |post| post['date'] }.reverse!
      site.data['medium_posts'] = { 'posts' => combined }
      Jekyll.logger.info 'Medium feed:', "Loaded #{posts.length} recent posts"
    rescue StandardError => error
      # The checked-in snapshot keeps the page useful during feed outages.
      Jekyll.logger.warn 'Medium feed:', "Using cached posts (#{error.message})"
    end
  end
end

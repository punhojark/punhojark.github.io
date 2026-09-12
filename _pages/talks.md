---
layout: page
title: Talks & presentations
nav_title: Talks
permalink: /talks/
description: Podcasts, workshop presentations, and posters.
nav: true
nav_order: 3
---

<div class="talk-list">
{% assign talks = site.data.talks | sort: 'date' | reverse %}
{% for talk in talks %}
  <article class="talk-entry">
    <div class="publication-meta">
      <span class="venue-label">{{ talk.venue }}</span>
      <span class="presentation-label">{{ talk.format }}</span>
    </div>
    <h2><a href="{{ talk.url }}">{{ talk.title }}</a></h2>
    <p class="talk-authors">{{ talk.authors }}</p>
    <p class="talk-details"><time datetime="{{ talk.date | date: '%Y-%m-%d' }}">{{ talk.date | date: '%B %-d, %Y' }}</time>{% if talk.location %} · {{ talk.location }}{% endif %}</p>
    {% if talk.summary %}<p class="post-excerpt">{{ talk.summary }}</p>{% endif %}
    <div class="talk-links">
    {% if talk.links %}
      {% for link in talk.links %}<a class="text-link" href="{{ link.url }}">{{ link.label }}</a>{% endfor %}
    {% else %}
      <a class="text-link" href="{{ talk.event_url }}">Workshop details</a>
    {% endif %}
    </div>
  </article>
{% endfor %}
</div>
<p class="contribution-note">* Equal contribution.</p>

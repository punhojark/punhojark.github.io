---
layout: page
title: Writing
permalink: /blog/
description: Essays in English and Korean.
nav: true
nav_order: 4
---

<div class="blog-intro">
  <nav class="blog-section-nav" aria-label="Blog topics">
  {% for section in site.data.blog_sections %}
    <a href="#{{ section.id }}">{{ section.title | escape }}</a>
  {% endfor %}
  </nav>
</div>
<div class="medium-post-list">
{% assign writing = site.data.medium_posts.posts | concat: site.data.external_writing | sort: 'date' | reverse %}
{% for section in site.data.blog_sections %}
<section class="writing-section" id="{{ section.id }}" aria-labelledby="{{ section.id }}-title">
  <h2 id="{{ section.id }}-title">{{ section.title | escape }}</h2>
{% for post in writing %}
  {% if post.section == section.id %}
  <article class="medium-post"{% if post.language %} lang="{{ post.language }}"{% endif %}>
    <time class="post-date" lang="en" datetime="{{ post.date }}">{{ post.date | date: '%b %Y' }}</time>
    <div>
      <h3><a href="{{ post.url | escape }}">{{ post.title | escape }}</a></h3>
      {% if post.byline %}<p class="post-byline" lang="en">{{ post.byline | escape }}</p>{% endif %}
    </div>
  </article>
  {% endif %}
{% endfor %}
</section>
{% endfor %}
</div>

<a class="text-link" href="{{ site.medium_blog.profile_url }}">More on Medium</a>

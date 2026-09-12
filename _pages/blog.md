---
layout: page
title: Blog
permalink: /blog/
description: Writing on AI, research, technology, and everyday questions.
nav: true
nav_order: 4
---

<div class="blog-intro">
  <p>Essays and technical writing in English and Korean, including my Medium posts and articles co-written with collaborators.</p>
  <a href="{{ site.medium_blog.profile_url }}">All writing on Medium <span aria-hidden="true">→</span></a>
  <nav class="blog-section-nav" aria-label="Blog topics">
  {% for section in site.data.blog_sections %}
    <a href="#{{ section.id }}">{{ section.title | escape }} <span aria-hidden="true">↓</span></a>
  {% endfor %}
  </nav>
</div>
<div class="medium-post-list">
{% assign writing = site.data.medium_posts.posts | concat: site.data.external_writing | sort: 'date' | reverse %}
{% for section in site.data.blog_sections %}
<section class="writing-section" id="{{ section.id }}" aria-labelledby="{{ section.id }}-title">
  <h2 id="{{ section.id }}-title">{{ section.title | escape }}</h2>
  <p class="writing-section-description">{{ section.description | escape }}</p>
{% for post in writing %}
  {% if post.section == section.id %}
  <article class="medium-post"{% if post.language %} lang="{{ post.language }}"{% endif %}>
    <p class="post-date" lang="en"><time datetime="{{ post.date }}">{{ post.date | date: '%B %-d, %Y' }}</time> · {{ post.source | default: 'Medium' | escape }}</p>
    <h3><a href="{{ post.url | escape }}">{{ post.title | escape }}</a></h3>
    {% if post.byline %}<p class="post-byline" lang="en">{{ post.byline | escape }}</p>{% endif %}
    <p class="post-excerpt">{{ post.excerpt | escape }}</p>
    <a class="text-link" lang="en" href="{{ post.url | escape }}">{{ post.link_label | default: 'Read on Medium' | escape }} <span aria-hidden="true">→</span></a>
  </article>
  {% endif %}
{% endfor %}
</section>
{% endfor %}
</div>

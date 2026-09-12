---
layout: page
title: Blog
permalink: /blog/
description: Writing on AI, research, technology, and everyday questions.
nav: true
nav_order: 4
---

<div class="blog-intro">
  <p>I write on Medium in English and Korean. Browse recent posts and earlier writing below.</p>
  <a href="{{ site.medium_blog.profile_url }}">All writing on Medium <span aria-hidden="true">→</span></a>
</div>
<div class="medium-post-list">
{% for post in site.data.medium_posts.posts %}
  <article class="medium-post"{% if post.language %} lang="{{ post.language }}"{% endif %}>
    <p class="post-date" lang="en"><time datetime="{{ post.date }}">{{ post.date | date: '%B %-d, %Y' }}</time></p>
    <h2><a href="{{ post.url | escape }}">{{ post.title | escape }}</a></h2>
    <p class="post-excerpt">{{ post.excerpt | escape }}</p>
    <a class="text-link" lang="en" href="{{ post.url | escape }}">Read on Medium <span aria-hidden="true">→</span></a>
  </article>
{% endfor %}
</div>

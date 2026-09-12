---
layout: page
title: Talks & presentations
nav_title: Talks
permalink: /talks/
description: Workshop presentations and posters.
nav: true
nav_order: 3
---

<div class="talk-list">
{% for talk in site.data.talks %}
  <article class="talk-entry">
    <div class="publication-meta">
      <span class="venue-label">{{ talk.venue }}</span>
      <span class="presentation-label">{{ talk.format }}</span>
    </div>
    <h2><a href="{{ talk.url }}">{{ talk.title }}</a></h2>
    <p class="talk-authors">{{ talk.authors }}</p>
    <p class="talk-details"><time datetime="{{ talk.date | date: '%Y-%m-%d' }}">{{ talk.date | date: '%B %d, %Y' }}</time> · {{ talk.location }}</p>
    <a class="text-link" href="{{ talk.event_url }}">Workshop details</a>
  </article>
{% endfor %}
</div>
<p class="contribution-note">* Equal contribution.</p>

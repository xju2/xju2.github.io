---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

{% if page.author and site.data.authors[page.author] %}
  {% assign author = site.data.authors[page.author] %}{% else %}{% assign author = site.author %}
{% endif %} 


Only publications with my direct contributions are listed.
You can also find my articles on <a href="{{author.googlescholar}}">my Google Scholar profile</a>.


<ol>{% for post in site.publications reversed %}
  {% include archive-single-pub.html %}
{% endfor %}</ol>

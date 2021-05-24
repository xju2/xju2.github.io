---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

Only publications with my direct contributions are listed
{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}
<ol>{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}</ol>

# Maintained theme integration (Stage 5)

The site now uses minimal-mistakes-jekyll 4.28.1 through its supported gem
integration. GitHub Pages is built with Actions, so the github-pages 232
dependency set can remain while a custom theme is installed. No Pages setting
or production domain change is required.

## Ownership

The gem supplies the standard layouts, navigation, author profile, accessibility
skip links, Sass, and JavaScript plugins. The old vendored Sass tree, generic
layouts/includes, old plugins and unused Font Awesome JavaScript are removed.

Local code retains the academic archive includes, student tables, legacy
base_path/group-by-array/read-time/toc helpers, analytics, favicons, math loader,
and footer sitemap link. The academic layout wraps the upstream single layout
with publication/teaching metadata and citations. The talk layout wraps academic;
it uses the actual talk date and accepts the existing type field as well as
talk_type. The upstream single layout supplies direct-link buttons.

Google Scholar and ORCID use the theme's author-profile-custom-links hook.
The avatar path now includes /images, as required by modern Minimal Mistakes.
The default theme skin is used; typography, spacing, navigation and sidebar
presentation consequently change. Content and collection permalinks are retained.
Student tables scroll within their container on small screens.

## Runtime and upgrades

The upstream 4.28.1 bundle embeds jQuery 3.6.0. footer_scripts instead loads the
existing jQuery 3.7.1 followed by the pinned theme's unbundled plugins.
assets/js/site.js is an unchanged copy of upstream assets/js/_main.js under a
public filename (Jekyll skips underscore-prefixed static assets). Its MIT license
is preserved in LICENSE.minimal-mistakes.

When updating the theme pin, copy its initializer again and review the plugin
list in _config.yml and Makefile. Do not restore the upstream bundle alongside
these scripts. The upstream head template uses a floating Font Awesome CDN
version; icon delivery remains an external dependency. MathJax remains 4.1.3.

## Validation and review

PR CI builds the pull request and its base commit, compares every generated HTML
route and PDF download, and checks that CNAME and the standalone talk map are
unchanged. Existing smoke checks still run independently.

Chromium checks desktop and mobile layouts, navigation and author menus,
MathJax rendering, BibTeX expansion, student row numbering, profile images, and
local HTTP errors. Screenshots are uploaded as browser-results for visual review.
The browser build uses a localhost URL; the production artifact retains the
normal site configuration. External links are not a blocking crawl.

Review the screenshots before merging, especially the publications, talks and
students pages. CI behavior checks do not establish pixel-level visual parity.
Rollback is a revert of this PR; no content/data migration is involved.

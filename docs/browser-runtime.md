# Browser runtime dependencies

The pinned Minimal Mistakes 4.28.1 gem supplies the theme's JavaScript plugins.
footer_scripts in _config.yml loads jQuery 3.7.1, throttle/debounce, FitVids,
greedy navigation, Magnific Popup, smooth-scroll, Gumshoe and assets/js/site.js
in dependency order. site.js is the upstream initializer copied to a public
filename. The theme's combined bundle is deliberately not loaded because it
contains older jQuery 3.6.0. Sticky sidebars now use the theme's CSS.

_includes/mathjax_support is included once from head/custom.html. It retains
MathJax 4.1.3, dollar and backslash-parenthesis inline delimiters, escaped dollar
signs, and automatic equation numbering.

make smoke-runtime verifies script references and the single math loader.
PR CI additionally runs scripts/browser-check.py in Chromium at desktop and
mobile widths. See theme-migration.md for ownership, review and upgrade steps.

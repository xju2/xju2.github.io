# Browser runtime dependencies

The site intentionally keeps its existing Minimal Mistakes-era layouts and
styles while using a small, explicit browser runtime.

## JavaScript loading

`_includes/scripts.html` loads these scripts in dependency order:

1. vendored jQuery 3.7.1;
2. the existing FitVids, greedy-navigation, Magnific Popup, smooth-scroll, and
   Stickyfill compatibility plugins;
3. the site's `assets/js/_main.js` initialization.

The scripts are served directly instead of being copied into a generated bundle.
This removes the obsolete Node 0.10, UglifyJS 2, and npm-run-all 1 build
metadata. It also makes the deployed dependency order reviewable without
changing the theme's behavior.

The compatibility plugins remain pinned to the vendored theme. They should be
removed or replaced together with the future theme migration, rather than
upgraded independently.

## Mathematics

`_includes/mathjax_support` contains the sole MathJax configuration and loader.
It pins MathJax 4.1.3 and preserves:

- dollar-delimited and `\\(...\\)` inline mathematics;
- escaped dollar signs;
- automatic equation numbering.

The previous layout loaded both MathJax 2.7.2 and 2.7.4 asynchronously. The
single v4 loader removes that race and the legacy `MathJax.Hub` API.

## Validation

`make check` verifies that the built home page:

- loads jQuery 3.7.1 and all compatibility scripts;
- contains no jQuery 1.12.4 reference;
- loads MathJax 4.1.3 exactly once;
- contains no legacy `MathJax.Hub.Config` call.

These checks complement, but do not replace, manual browser verification of
navigation, the author menu, image lightboxes, embedded video sizing, smooth
scrolling, the sticky sidebar, and mathematical rendering.

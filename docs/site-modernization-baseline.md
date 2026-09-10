# Site modernization baseline

Recorded on 2026-09-10 from commit `66946539a9054ee6a8c7021cce4ffd587290444b`.

This document defines the compatibility boundary for the first stage of the
ml4phys.com modernization. It records the existing site rather than proposing
content or visual changes.

## Production and publishing

- Public URL: <https://www.ml4phys.com/>
- Repository: `xju2/xju2.github.io`
- Default branch: `master`
- Custom domain: `www.ml4phys.com`, stored in `CNAME`
- Publishing currently uses GitHub Pages' existing repository configuration.
- This stage adds validation only. It does not add a deployment workflow or
  change the repository's Pages publishing source.

## Current build stack

- Jekyll is supplied by the `github-pages` meta-gem.
- The repository vendors a Minimal Mistakes 3.4.2-era theme implementation.
- Theme layouts, includes, Sass, and browser assets are stored in the repository.
- The JavaScript build metadata references jQuery 1.12.4 and UglifyJS 2.
- MathJax 2.7.4 is loaded by `_includes/head/custom.html`.
- The Python `cvmgr` utility and its `uv.lock` are separate from the Jekyll
  site build.
- The Makefile's default target builds the LaTeX CV and is preserved.

## Site-specific behavior to preserve

The following are local features, not disposable template examples:

- The `students` collection and `_pages/students.html`
- `_includes/archive-single-student.html`
- Publication and talk archive includes
- The custom `talk` layout
- Publication, talk, teaching, student, and portfolio collections
- Redirects declared in page front matter
- Google Analytics configuration
- MathJax rendering
- The talk map and downloadable PDFs
- The custom domain

## Required public routes

The automated smoke test verifies the generated files for these routes:

- `/`
- `/projects/`
- `/publications/`
- `/talks/`
- `/students/`
- `/sitemap.xml`

Future theme work must additionally preserve existing collection permalinks and
front-matter redirects.

## Known modernization risks

- The full theme is vendored, so a direct upstream merge would mix template
  changes with local overrides.
- Student tables and archive markup depend on custom includes.
- Theme JavaScript and markup must be upgraded together.
- A Jekyll major-version change may alter Liquid, Sass, and plugin behavior.
- External academic and conference links may reject automated link checkers;
  they should not become blocking checks without a reviewed baseline.

## First-stage quality gate

A change passes this stage when a clean checkout can:

1. install the pinned GitHub Pages dependency set;
2. build with strict front-matter validation;
3. generate the required routes, stylesheet, JavaScript, sitemap, and CNAME;
4. leave production deployment configuration unchanged.

## Deferred work

The following remain intentionally outside the first pull request:

- Theme replacement or visual redesign
- jQuery, MathJax, Sass, or layout migration
- Content and navigation edits
- GitHub Pages deployment cutover
- Blocking external-link or accessibility gates
- Dependency automation

Rollback is a normal revert of this pull request; no production publishing
setting is changed.

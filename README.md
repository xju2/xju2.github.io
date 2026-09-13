# ml4phys.com

Source for Xiangyang Ju's personal research website at
<https://www.ml4phys.com/>.

## Website development

The Jekyll environment tracks the dependency set supported by GitHub Pages.

Prerequisites:

- Ruby 3.3.4
- Bundler
- GNU Make

Install dependencies and validate the complete site:

```bash
make install
make check
```

Build without running smoke tests:

```bash
make site
```

Run the development server with live reload and development configuration:

```bash
make serve
```

The generated site is written to `_site/`. The smoke test verifies the main
public routes, compiled assets, sitemap, custom domain, and successful Liquid
rendering. See
[`docs/site-modernization-baseline.md`](docs/site-modernization-baseline.md)
for the compatibility boundary and deferred modernization work. Browser-side
libraries and the remaining theme compatibility layer are documented in
[`docs/browser-runtime.md`](docs/browser-runtime.md).

## Publishing

Pull requests are built and smoke-tested without deployment. Production builds
from `master` use the explicit GitHub Pages workflow described in
[`docs/pages-deployment.md`](docs/pages-deployment.md).

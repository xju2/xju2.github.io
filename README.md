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
for the compatibility boundary and deferred modernization work.

## CV PDF

The Makefile's default target continues to build `tex_files/main.tex`:

```bash
make
```

A LaTeX installation containing `pdflatex` is required for that target.

## Publication metadata tooling

The Python package in `src/cvmgr` manages publication and CV metadata. Its
environment is defined by `pyproject.toml` and `uv.lock`; it is independent
of the Jekyll website build.

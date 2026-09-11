# Directory containing the LaTeX sources
TEX_DIR := tex_files
TEX_SOURCES := $(wildcard $(TEX_DIR)/*.tex)

# CV build configuration
BUILD_DIR := build
MAIN := main
TARGET := $(BUILD_DIR)/$(MAIN).pdf

# Website build configuration
BUNDLE ?= bundle
JEKYLL := $(BUNDLE) exec jekyll
SITE_DIR ?= _site
PRIMARY_PAGES := \
	$(SITE_DIR)/index.html \
	$(SITE_DIR)/projects/index.html \
	$(SITE_DIR)/publications/index.html \
	$(SITE_DIR)/talks/index.html \
	$(SITE_DIR)/students/index.html
JS_ASSETS := \
	$(SITE_DIR)/assets/js/vendor/jquery/jquery-3.7.1.min.js \
	$(SITE_DIR)/assets/js/plugins/jquery.fitvids.js \
	$(SITE_DIR)/assets/js/plugins/jquery.greedy-navigation.js \
	$(SITE_DIR)/assets/js/plugins/jquery.magnific-popup.js \
	$(SITE_DIR)/assets/js/plugins/jquery.smooth-scroll.min.js \
	$(SITE_DIR)/assets/js/plugins/stickyfill.min.js \
	$(SITE_DIR)/assets/js/_main.js

.PHONY: all clean install site serve check smoke smoke-routes smoke-assets smoke-domain smoke-liquid smoke-runtime

# Preserve the repository's existing default: build the CV PDF.
all: $(TARGET)

install:
	$(BUNDLE) install

site:
	JEKYLL_ENV=production $(JEKYLL) build --strict_front_matter --destination $(SITE_DIR)

serve:
	$(JEKYLL) serve --livereload --config _config.yml,_config.dev.yml

smoke-routes:
	test -s $(SITE_DIR)/index.html
	test -s $(SITE_DIR)/projects/index.html
	test -s $(SITE_DIR)/publications/index.html
	test -s $(SITE_DIR)/talks/index.html
	test -s $(SITE_DIR)/students/index.html

smoke-assets:
	test -s $(SITE_DIR)/sitemap.xml
	test -s $(SITE_DIR)/CNAME
	test -s $(SITE_DIR)/assets/css/main.css
	for asset in $(JS_ASSETS); do test -s "$$asset"; done

smoke-domain:
	test "$$(tr -d '\r\n' < $(SITE_DIR)/CNAME)" = "www.ml4phys.com"

smoke-liquid:
	! grep -F '{% include' $(PRIMARY_PAGES)
	! grep -F '{{ site.' $(PRIMARY_PAGES)
	! grep -F '{{ page.' $(PRIMARY_PAGES)

smoke-runtime:
	grep -Fq '/assets/js/vendor/jquery/jquery-3.7.1.min.js' $(SITE_DIR)/index.html
	! grep -Fq 'jquery-1.12.4' $(SITE_DIR)/index.html
	test "$$(grep -o 'mathjax@4.1.3/tex-mml-chtml.js' $(SITE_DIR)/index.html | wc -l)" -eq 1
	! grep -Fq 'MathJax.Hub.Config' $(SITE_DIR)/index.html

smoke: smoke-routes smoke-assets smoke-domain smoke-liquid smoke-runtime
	@echo "Site smoke checks passed."

check: site smoke

$(BUILD_DIR):
	mkdir -p $@

$(TARGET): $(TEX_SOURCES) | $(BUILD_DIR)
	cd $(TEX_DIR) && \
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$(BUILD_DIR) $(MAIN).tex && \
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$(BUILD_DIR) $(MAIN).tex
	cp $(BUILD_DIR)/$(MAIN).pdf $(TEX_DIR)/

clean:
	rm -rf $(BUILD_DIR) $(SITE_DIR)

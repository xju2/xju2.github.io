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

.PHONY: all clean install site serve check smoke smoke-routes smoke-assets smoke-domain smoke-liquid

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
	test -s $(SITE_DIR)/assets/js/main.min.js

smoke-domain:
	test "$$(tr -d '\r\n' < $(SITE_DIR)/CNAME)" = "www.ml4phys.com"

smoke-liquid:
	! grep -F '{% include' $(PRIMARY_PAGES)
	! grep -F '{{ site.' $(PRIMARY_PAGES)
	! grep -F '{{ page.' $(PRIMARY_PAGES)

smoke: smoke-routes smoke-assets smoke-domain smoke-liquid
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

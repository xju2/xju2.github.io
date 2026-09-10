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

.PHONY: all clean install site serve check

# Preserve the repository's existing default: build the CV PDF.
all: $(TARGET)

install:
	$(BUNDLE) install

site:
	JEKYLL_ENV=production $(JEKYLL) build --strict_front_matter --destination $(SITE_DIR)

serve:
	$(JEKYLL) serve --livereload --config _config.yml,_config.dev.yml

check: site
	ruby scripts/check_site.rb $(SITE_DIR)

$(BUILD_DIR):
	mkdir -p $@

$(TARGET): $(TEX_SOURCES) | $(BUILD_DIR)
	cd $(TEX_DIR) && \
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$(BUILD_DIR) $(MAIN).tex && \
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$(BUILD_DIR) $(MAIN).tex
	cp $(BUILD_DIR)/$(MAIN).pdf $(TEX_DIR)/

clean:
	rm -rf $(BUILD_DIR) $(SITE_DIR)

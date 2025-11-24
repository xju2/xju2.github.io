# Directory containing the LaTeX sources
TEX_DIR := tex_files
TEX_SOURCES := $(wildcard $(TEX_DIR)/*.tex)

# Build configuration
BUILD_DIR := build
MAIN := main
TARGET := $(BUILD_DIR)/$(MAIN).pdf

.PHONY: all clean

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $@

$(TARGET): $(TEX_SOURCES) | $(BUILD_DIR)
	cd $(TEX_DIR) && \
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$(BUILD_DIR) $(MAIN).tex && \
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$(BUILD_DIR) $(MAIN).tex
	cp $(BUILD_DIR)/$(MAIN).pdf $(TEX_DIR)/

clean:
	rm -rf $(BUILD_DIR)

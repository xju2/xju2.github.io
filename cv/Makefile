# CV build: `make` here or `make -C cv` from the repo root
OUT ?= ../build

.PHONY: all clean

all:
	latexmk -pdf -interaction=nonstopmode -outdir=$(OUT) main.tex

clean:
	latexmk -C -outdir=$(OUT) main.tex

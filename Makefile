FILES = iswartcl iswstud iswbook iswdctrt

.PHONY: all
all: dist $(FILES)

dist: clean
	mkdir dist/

.PHONY: iswartcl
iswartcl: iswartcl-cls iswartcl-tex iswartcl-rc bbl

.PHONY: iswstud
iswstud: iswstud-cls iswstud-tex iswstud-rc bbl

.PHONY: iswbook
iswbook: iswbook-cls iswbook-tex iswbook-rc bbl

.PHONY: iswdctrt
iswdctrt: iswdctrt-cls iswdctrt-tex iswdctrt-rc bbl

%-cls: src/%.cls src/%/* src/common/*
	python build.py --dest=dist/ -- $<

%-tex: src/%.tex
	python build.py --dest=dist/ -- $<

%-rc: src/%.latexmkrc
	cp src/$*.latexmkrc dist/$*.latexmkrc

.PHONY: bbl
bbl: bbx bib

bbx: src/iswbib.bbx
	cp src/iswbib.bbx dist/iswbib.bbx

bib: src/bibliography.bib
	cp src/bibliography.bib dist/bibliography.bib

.PHONY: clean
clean:
	rm -rf dist/*

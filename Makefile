FILES = iswartcl iswstud iswbook iswdctrt

.PHONY: all
all: dist list-of-packages $(FILES) images

dist: clean
	mkdir dist/

.PHONY: list-of-packages
list-of-packages: src/*.cls
	python list_packages.py --output packages.md src/iswartcl.cls src/iswstud.cls src/iswdctrt.cls src/iswbook.cls

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

images: src/images*
	rsync -a --exclude="*-converted-to*" src/images dist/

.PHONY: bbl
bbl: bbx bib

bbx: src/iswbib.bbx
	cp src/iswbib.bbx dist/iswbib.bbx

bib: src/bibliography.bib
	cp src/bibliography.bib dist/bibliography.bib

.PHONY: clean
clean:
	rm -rf dist/

FILES = iswartcl iswstud iswbook iswdctrt
BUILD_DIR = dist

.PHONY: all
all: build list-of-packages $(FILES) images

build: clean
	mkdir $(BUILD_DIR)

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
	python build.py --dest=$(BUILD_DIR)/ -- $<

%-tex: src/%.tex
	python build.py --dest=$(BUILD_DIR)/ -- $<

%-rc: src/%.latexmkrc
	cp src/$*.latexmkrc $(BUILD_DIR)/$*.latexmkrc

images: src/images*
	rsync -a --exclude="*-converted-to*" src/images $(BUILD_DIR)/

.PHONY: bbl
bbl: bbx bib

bbx: src/iswbib.bbx
	cp src/iswbib.bbx $(BUILD_DIR)/iswbib.bbx

bib: src/bibliography.bib
	cp src/bibliography.bib $(BUILD_DIR)/bibliography.bib

.PHONY: clean
clean:
	[ -d "$(BUILD_DIR)/" ] && rm -rf $(BUILD_DIR)/ || [ ! -d "$(BUILD_DIR)/" ]

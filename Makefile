PY = python3
FILES = iswartcl iswstud iswbook iswdctrt
BUILD_DIR = dist

.PHONY: all
all: packages macros build $(FILES) images

# build directory
build:
	[ -d "$(BUILD_DIR)/" ] || mkdir $(BUILD_DIR)

# create list of packages
packages: src/*.cls
	$(PY) output-packages.py --output packages.md -- $?

# create list of macros
macros: src/*.cls
	cp src/iswmacros.tex $(BUILD_DIR)/iswmacros.tex
	$(PY) output-macros.py --output dist/macros.tex -- $?
	cd dist && latexmk -quiet iswmacros.tex && latexmk -quiet -c iswmacros.tex


# Building of all necessary classes
# build iswartcl cls, tex, rc, etc
.PHONY: iswartcl
iswartcl: iswartcl-cls iswartcl-tex iswartcl-rc bbl packages macros

# build iswstud cls, tex, rc, etc
.PHONY: iswstud
iswstud: iswstud-cls iswstud-tex iswstud-rc bbl packages macros

# build iswbook cls, tex, rc, etc
.PHONY: iswbook
iswbook: iswbook-cls iswbook-tex iswbook-rc bbl packages macros

# build iswdctrt cls, tex, rc, etc
.PHONY: iswdctrt
iswdctrt: iswdctrt-cls iswdctrt-tex iswdctrt-rc bbl packages macros


# implicit target for making `*.cls` files
%-cls: src/%.cls src/%/* src/common/*
	$(PY) build.py --dest=$(BUILD_DIR)/ -- $<

# implicit target for making `*.tex` files
%-tex: src/%.tex
	$(PY) build.py --dest=$(BUILD_DIR)/ -- $<

# implicit target for making `*.rc` files
%-rc: src/%.latexmkrc
	cp src/$*.latexmkrc $(BUILD_DIR)/$*.latexmkrc


# copy the iswmacros file
iswmacros: src/iswmacros.tex
	cp src/iswmacros.tex $(BUILD_DIR)/iswmacros.tex

# implicit target for making the images
images: src/images*
	rsync -a --exclude="*-converted-to*" src/images $(BUILD_DIR)/


# make all bibliography related things
.PHONY: bbl
bbl: bbx bib

# copy the BBX file to build
bbx: src/iswbib.bbx
	cp src/iswbib.bbx $(BUILD_DIR)/iswbib.bbx

# Copy the BIB file to build
bib: src/bibliography.bib
	cp src/bibliography.bib $(BUILD_DIR)/bibliography.bib


#macros: iswbook src/iswmacros.tex
#    cp src/iswmacros.tex $(BUILD_DIR)/iswmacros.tex


# Semantic Versioning
# patch version bump for the given file(s)
patch: src/*.cls
	$(PY) semver.py patch $?

# minor version bump for the given file(s)
minor: src/*.cls
	$(PY) semver.py minor $?

# major version bump for the given file(s)
major: src/*.cls
	$(PY) semver.py major $?


# cleanup
.PHONY: clean
clean:
	[ -d "$(BUILD_DIR)/" ] && rm -rf $(BUILD_DIR)/ && mkdir $(BUILD_DIR)/ || [ ! -d "$(BUILD_DIR)/" ]

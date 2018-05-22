PY = python3
FILES = iswartcl iswstud iswbook iswdctrt
BUILD_DIR = dist
SRC_DIR = src

.PHONY: all
all: build $(FILES) images packages macros

# build directory
build:
	[ -d "$(BUILD_DIR)/" ] || mkdir $(BUILD_DIR)

# create list of packages
packages: $(SRC_DIR)/*.cls
	$(PY) output-packages.py --output packages.md -- $?

# create list of macros
macros: iswmacros
	$(PY) output-macros.py --output $(BUILD_DIR)/macros.tex -- $(SRC_DIR)/*.cls
	latexmk -norc -quiet -c -cd -r $(BUILD_DIR)/iswbook.latexmkrc $(BUILD_DIR)/iswmacros.tex
	latexmk -norc -quiet    -cd -r $(BUILD_DIR)/iswbook.latexmkrc $(BUILD_DIR)/iswmacros.tex
	latexmk -norc -quiet -c -cd -r $(BUILD_DIR)/iswbook.latexmkrc $(BUILD_DIR)/iswmacros.tex


# Building of all necessary classes
# build iswartcl cls, tex, rc, etc
.PHONY: iswartcl
iswartcl: iswartcl-cls iswartcl-tex iswartcl-rc bbl

# build iswstud cls, tex, rc, etc
.PHONY: iswstud
iswstud: iswstud-cls iswstud-tex iswstud-rc bbl

# build iswbook cls, tex, rc, etc
.PHONY: iswbook
iswbook: iswbook-cls iswbook-tex iswbook-rc bbl

# build iswdctrt cls, tex, rc, etc
.PHONY: iswdctrt
iswdctrt: iswdctrt-cls iswdctrt-tex iswdctrt-rc bbl


# implicit target for making `*.cls` files
%-cls: $(SRC_DIR)/%.cls $(SRC_DIR)/%/* $(SRC_DIR)/common/*
	$(PY) build.py --dest=$(BUILD_DIR)/ -- $<

# implicit target for making `*.tex` filesx
%-tex: $(SRC_DIR)/%.tex
	$(PY) build.py --dest=$(BUILD_DIR)/ -- $<

# implicit target for making `*.rc` files
%-rc: $(SRC_DIR)/%.latexmkrc
	cp $(SRC_DIR)/$*.latexmkrc $(BUILD_DIR)/$*.latexmkrc


# copy all files needed for `iswmacros`
iswmacros: iswbook $(SRC_DIR)/iswmacros.tex
	cp $(SRC_DIR)/iswmacros.tex $(BUILD_DIR)/iswmacros.tex

# implicit target for making the images
images: $(SRC_DIR)/images*
	rsync -a --exclude="*-converted-to*" $(SRC_DIR)/images $(BUILD_DIR)/


# make all bibliography related things
.PHONY: bbl
bbl: bbx bib

# copy the BBX file to build
bbx: $(SRC_DIR)/iswbib.bbx
	cp $(SRC_DIR)/iswbib.bbx $(BUILD_DIR)/iswbib.bbx

# Copy the BIB file to build
bib: $(SRC_DIR)/bibliography.bib
	cp $(SRC_DIR)/bibliography.bib $(BUILD_DIR)/bibliography.bib


# Semantic Versioning
# patch version bump for the given file(s)
patch: $(SRC_DIR)/*.cls
	$(PY) semver.py patch $?

# minor version bump for the given file(s)
minor: $(SRC_DIR)/*.cls
	$(PY) semver.py minor $?

# major version bump for the given file(s)
major: $(SRC_DIR)/*.cls
	$(PY) semver.py major $?


# cleanup
.PHONY: clean
clean:
	[ -d "$(BUILD_DIR)/" ] && rm -rf $(BUILD_DIR)/ && mkdir $(BUILD_DIR)/ || [ ! -d "$(BUILD_DIR)/" ]

SHELL = /bin/bash

DISTDIR = dist/
INSTALLDIR = $(shell kpsewhich --var-value TEXMFHOME)/tex/latex/ustutt/
SOURCES = $(shell find ./ -type f -name "ustutt*.dtx")
ADDL_INCLUDES = references.bib
DICTIONARIES = ustutt-English.dict ustutt-German.dict
DOCS = $(SOURCES:dtx=pdf)

.PHONY: all
all: ins docs

.PHONY: ins
ins: ustutt.ins $(SOURCES)
	pdflatex ustutt.ins

.PHONY: docs
docs: $(DOCS)

%.pdf: %.dtx
	pdflatex --shell-escape $^
	makeindex -s gind.ist $*.idx
	makeindex -s gglo.ist -o $*.gls $*.glo
	pdflatex --shell-escape $^

.PHONY: clean
clean:
	[ `ls -1 *.cls 2>/dev/null | wc -l` == 0 ] || rm *.cls
	[ `ls -1 *.sty 2>/dev/null | wc -l` == 0 ] || rm *.sty
	[ `ls -1 *.dict 2>/dev/null | wc -l` == 0 ] || rm *.dict
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || latexmk -c -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || latexmk -c -silent *.tex

.PHONY: distclean
distclean: clean
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || latexmk -C -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || latexmk -C -silent *.tex
	[ ! -d $(DISTDIR) ] || rm -r $(DISTDIR)

.PHONY: release
release:#release_bachelor release_master release_doctorate
	mkdir -p $(DISTDIR)/release/examples
	cp *.cls $(DISTDIR)release/
	cp *.sty $(DISTDIR)release/
	cp *.tex $(DISTDIR)release/
	cp $(ADDL_INCLUDES) $(DISTDIR)release/
	cp $(DICTIONARIES) $(DISTDIR)release/
	cp -r images $(DISTDIR)release/

.PHONY: install
install: ins
	mkdir -p $(INSTALLDIR)
	cp *.cls $(INSTALLDIR)
	cp *.dict $(INSTALLDIR)
	cp $(DICTIONARIES) $(INSTALLDIR)

.PHONY: uninstall
uninstall: distclean
	rm -rf $(INSTALLDIR)

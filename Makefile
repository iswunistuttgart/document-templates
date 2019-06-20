SHELL = /bin/bash

DISTDIR = dist/
INSTALLDIR = $(shell kpsewhich --var-value TEXMFHOME)/tex/latex/ustutt/
SOURCES = ustutt.dtx demos.dtx \
	ustuttcolors.dtx ustutttext.dtx ustuttmechanics.dtx ustuttstatistics.dtx ustuttsystemdynamics.dtx \
	localization.dtx
DEMOS = ustuttbachelor_de.tex ustuttbachelor_en.tex \
	ustuttmaster_de.tex ustuttmaster_en.tex \
	ustuttdoctorate_de.tex ustuttdoctorate_en.tex
ADDL_INCLUDES = references.bib ustuttgloss.sty acronyms.tex symbols.tex notation.tex tikzlibraryustutt.code.tex ustutt-English.dict ustutt-German.dict

SOURCE_PDFS = $(SOURCES:dtx=pdf)
DEMO_PDFS = $(DEMOS:tex=pdf)

.PHONY: all
all: ins docs $(SOURCE_PDFS)

.PHONY: ins
ins: ustutt.ins $(SOURCES)
	pdflatex ustutt.ins

.PHONY: docs
docs: $(SOURCE_PDFS)

.PHONY: demos
demos: $(DEMO_PDFS)

$(DEMO_PDFS): $(DEMOS)
	latexmk $(@F:pdf=tex)

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
	rm -f $(DEMOS) $(DEMO_PDFS) *.tex

.PHONY: distclean
distclean: clean
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || latexmk -C -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || latexmk -C -silent *.tex
	[ ! -d $(DISTDIR) ] || rm -r $(DISTDIR)

.PHONY: release
release: release_bachelor release_master release_doctorate
	mkdir -p $(DISTDIR)/release/examples
	cp *.cls $(DISTDIR)release/
	cp $(ADDL_INCLUDES) $(DISTDIR)release/
	cp *.sty $(DISTDIR)release/
	cp -r images $(DISTDIR)release/
	cp $(DEMOS) $(DISTDIR)/release/examples
	cp $(DEMO_PDFS) $(DISTDIR)/release/examples
	cp $(ADDL_INCLUDES) $(DISTDIR)/release/examples

release_%: demos
	mkdir -p $(DISTDIR)/$*/
	cp .latexmkrc $(DISTDIR)/$*/
	cp ustuttthesis.cls ustuttthesis.tex $(DISTDIR)/$*/
	cp -r images $(DISTDIR)/$*/
	cp $(ADDL_INCLUDES) $(DISTDIR)/$*/
	cp ustutt$*_{en,de}.{pdf,tex} $(DISTDIR)/$*/

.PHONY: install
install: ins
	mkdir -p $(INSTALLDIR)
	cp *.cls $(INSTALLDIR)
	cp *.dict $(INSTALLDIR)
	cp $(ADDL_INCLUDES) $(INSTALLDIR)

.PHONY: uninstall
uninstall: distclean
	rm -rf $(INSTALLDIR)

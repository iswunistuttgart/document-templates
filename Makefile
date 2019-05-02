SHELL = /bin/bash

DISTDIR = dist/
INSTALLDIR = $(shell kpsewhich --var-value TEXMFHOME)/tex/latex/ustutt/
SOURCES = ustutt.dtx demos.dtx \
	ustuttmath.dtx ustutttext.dtx ustuttmechanics.dtx ustuttstatistics.dtx ustuttsystemdynamics.dtx \
	localization.dtx
DEMOS = ustuttbachelor_de.tex ustuttbachelor_en.tex \
	ustuttmaster_de.tex ustuttmaster_en.tex \
	ustuttdoctorate_de.tex ustuttdoctorate_en.tex
ADDL_INCLUDES = acronyms.tex symbols.tex notation.tex

SOURCE_PDFS = $(SOURCES:dtx=pdf)
DEMO_PDFS = $(DEMOS:tex=pdf)

.PHONY: all
all: ins $(SOURCE_PDFS)

.PHONY: ins
ins: ustutt.ins $(SOURCES)
	pdflatex ustutt.ins

.PHONY: demos
demos: $(DEMO_PDFS)

$(DEMO_PDFS): $(DEMOS)
	latexmk $(@F:pdf=tex)

%.pdf: %.dtx
	pdflatex $^
	makeindex -s gind.ist $*.idx
	makeindex -s gglo.ist -o $*.gls $*.glo
	pdflatex $^

.PHONY: clean
clean:
	[ `ls -1 *.cls 2>/dev/null | wc -l` == 0 ] || rm *.cls
	[ `ls -1 *.sty 2>/dev/null | wc -l` == 0 ] || rm *.sty
	[ `ls -1 *.dict 2>/dev/null | wc -l` == 0 ] || rm *.dict
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || latexmk -c -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || latexmk -c -silent *.tex
	rm -f $(DEMOS)

.PHONY: distclean
distclean: clean
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || latexmk -C -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || latexmk -C -silent *.tex
	[ ! -d $(DISTDIR) ] || rm -r $(DISTDIR)

.PHONY: install
install: ins
	mkdir -p $(INSTALLDIR)
	cp *.cls $(INSTALLDIR)
	cp *.dict $(INSTALLDIR)
	cp *.sty $(INSTALLDIR)

.PHONY: package
package: all demos
	mkdir -p $(DISTDIR)/examples
	cp *.cls $(DISTDIR)
	cp *.dict $(DISTDIR)
	cp *.sty $(DISTDIR)
	cp $(DEMOS) $(DISTDIR)/examples
	cp $(DEMO_PDFS) $(DISTDIR)/examples
	cp $(ADDL_INCLUDES) $(DISTDIR)/examples

.PHONY: uninstall
uninstall: distclean
	rm -rf $(INSTALLDIR)

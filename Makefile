SHELL = /bin/bash

INSTALLDIR = $(shell kpsewhich --var-value TEXMFHOME)/tex/latex/ustutt/
SOURCES = ustutt.dtx demos.dtx \
	ustuttmath.dtx ustutttext.dtx ustuttmechanics.dtx ustuttstatistics.dtx ustuttsystemdynamics.dtx
DEMOS = ustuttbachelor_de.tex ustuttbachelor_en.tex \
	ustuttmaster_de.tex ustuttmaster_en.tex \
	ustuttdoctorate_de.tex ustuttdoctorate_en.tex
SOURCE_PDFS = $(SOURCES:dtx=pdf)
DEMO_PDFS = $(DEMOS:tex=pdf)

.PHONY: all
all: ins $(SOURCE_PDFS) $(DEMO_PDFS)

.PHONY: ins
ins: ustutt.ins $(SOURCES)
	pdflatex ustutt.ins

%.pdf: %.dtx
	latexmk $^
	makeindex -s gind.ist $*.idx
	makeindex -s gglo.ist -o $*.gls $*.glo
	latexmk $^

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

.PHONY: install
install: ins
	mkdir -p $(INSTALLDIR)
	cp *.cls $(INSTALLDIR)
	cp *.dict $(INSTALLDIR)
	cp *.sty $(INSTALLDIR)

.PHONY: uninstall
uninstall: distclean
	rm -rf $(INSTALLDIR)

SHELL = /bin/bash

INSTALLDIR = $(shell kpsewhich --var-value TEXMFHOME)/tex/latex/ustutt/
SOURCES = ustutt.dtx ustuttartcl.dtx ustuttbook.dtx ustuttthesis.dtx ustuttmath.dtx ustutttext.dtx ustuttmechanics.dtx ustuttstatistics.dtx ustuttsystemdynamics.dtx
PDFS = $(SOURCES:dtx=pdf)

.PHONY: all
all: ins $(PDFS)

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
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || latexmk -CA -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || latexmk -CA -silent *.tex

.PHONY: distclean
distclean: clean
	[ `ls -1 *.cls 2>/dev/null | wc -l` == 0 ] || rm *.cls
	[ `ls -1 *.sty 2>/dev/null | wc -l` == 0 ] || rm *.sty
	[ `ls -1 *.dict 2>/dev/null | wc -l` == 0 ] || rm *.dict

.PHONY: install
install: cls
	mkdir -p $(INSTALLDIR)
	cp *.cls $(INSTALLDIR)
	cp *.dict $(INSTALLDIR)
	cp *.sty $(INSTALLDIR)

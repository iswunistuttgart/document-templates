SHELL = /bin/bash

DISTDIR = dist/
INSTALLDIR = $(shell kpsewhich --var-value TEXMFHOME)/tex/latex/ustutt/
SOURCES = $(shell find ./ -type f -name "ustutt*.dtx")
DICTIONARIES = ustutt-English.dict ustutt-German.dict
ADDL_INCLUDES = references.bib images $(DICTIONARIES) tikzlibraryustutt.code.tex acronyms.tex symbols.tex notation.tex
DOCS = $(SOURCES:dtx=pdf)

LATEX = pdflatex --shell-escape
MAKEINDEX = makeindex -s
LATEXMK = latexmk

.PHONY: all
all: ins docs dist

.PHONY: ins
ins: ustutt.ins $(SOURCES)
	$(LATEX) ustutt.ins

.PHONY: docs
docs: $(DOCS)

# any PDF file depends on its base documented TeX file
%.pdf: %.dtx
	$(LATEX) $^
	$(MAKEINDEX) gind.ist $*.idx
	$(MAKEINDEX) gglo.ist -o $*.gls $*.glo
	$(LATEX) $^

# class files depend on the insaller
%.cls: ins

# .PHONY:
# dist:
# 	mkdir -p $(DISTDIR)

# combination of everything that needs to be done for distributing
dist: ins dist_bachelor dist_master dist_doctorate dist_book dist_article

# dist class for theses
dist_%: ustuttthesis.cls
	# create the directory
	mkdir -p $(DISTDIR)/$*
	# copy class file over
	cp ustuttthesis.cls $(DISTDIR)/$*/
	# copy all style files over
	cp *.sty $(DISTDIR)/$*/
	# copy source files over
	cp $*_*.tex $(DISTDIR)/$*/
	# copy additional includes over
	cp -r $(ADDL_INCLUDES) $(DISTDIR)/$*/
	# compile the latex source files in the dist directory
	$(LATEXMK) -cd $(DISTDIR)/$*/$*_*.tex
	# and remove auxiliary files from the dist directory
	$(LATEXMK) -c -cd $(DISTDIR)/$*/$*_*.tex

# dist class for articles
dist_article: ustuttartcl.cls
	# create the directory
	mkdir -p $(DISTDIR)/article
	# copy class file over
	cp ustuttartcl.cls $(DISTDIR)/article/
	# copy all style files over
	cp *.sty $(DISTDIR)/article/
	# copy source files over
	cp article_*.tex $(DISTDIR)/article/
	# copy additional includes over
	cp -r $(ADDL_INCLUDES) $(DISTDIR)/article/
	# compile the latex source files in the dist directory
	$(LATEXMK) -cd $(DISTDIR)/article/article_*.tex
	# and remove auxiliary files from the dist directory
	$(LATEXMK) -c -cd $(DISTDIR)/article/article_*.tex

# dist class for books
dist_book: ustuttbook.cls
	# create the directory
	mkdir -p $(DISTDIR)/book
	# copy class file over
	cp ustuttbook.cls $(DISTDIR)/book/
	# copy all style files over
	cp *.sty $(DISTDIR)/book/
	# copy source files over
	cp book_*.tex $(DISTDIR)/book/
	# copy additional includes over
	cp -r $(ADDL_INCLUDES) $(DISTDIR)/book/
	# compile the latex source files in the dist directory
	$(LATEXMK) -cd $(DISTDIR)/book/book_*.tex
	# and remove auxiliary files from the dist directory
	$(LATEXMK) -c -cd $(DISTDIR)/book/book_*.tex

# clean directory from all dirt
.PHONY: clean
clean:
	[ `ls -1 *.cls 2>/dev/null | wc -l` == 0 ] || rm *.cls
	[ `ls -1 *.sty 2>/dev/null | wc -l` == 0 ] || rm *.sty
	[ `ls -1 *.dict 2>/dev/null | wc -l` == 0 ] || rm *.dict
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || $(LATEXMK) -c -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || $(LATEXMK) -c -silent *.tex

# reseat directory to its original, distributed state
.PHONY: distclean
distclean: clean
	[ `ls -1 *.dtx 2>/dev/null | wc -l` == 0 ] || $(LATEXMK) -C -silent *.dtx
	[ `ls -1 *.tex 2>/dev/null | wc -l` == 0 ] || $(LATEXMK) -C -silent *.tex
	[ ! -d $(DISTDIR) ] || rm -r $(DISTDIR)

# copy compiled files over to user's texmf home
.PHONY: install
install: ins
	mkdir -p $(INSTALLDIR)
	cp *.cls $(INSTALLDIR)
	cp *.sty $(INSTALLDIR)
	cp *.dict $(INSTALLDIR)
	cp $(DICTIONARIES) $(INSTALLDIR)

# uninstall from user's texmf home
.PHONY: uninstall
uninstall: distclean
	rm -rf $(INSTALLDIR)

% Definition of class version and last release date
\def\fileversion{1.0.0-dev}
\def\filedate{2017/01/08}

% Definition of the actual class interface
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iswartcl}[\filedate\space Version \fileversion\space by Philipp Tempel <philipp.tempel@isw.uni-stuttgart.de>]

% Typeout a notice
\typeout{}
\typeout{ISW - Institute for Control Engineering of Machine Tools}
\typeout{      and Manufacturing Units, University Stuttgart}
\typeout{      Document class for doctoral theses}
\typeout{      Version \fileversion\space(\filedate) }
\typeout{}

%  The package is a toolbox of programming facilities geared primarily towards LaTeX class and package authors. It provides LaTeX frontends to some of the new primitives provided by e-TeX as well as some generic tools which are not strictly related to e-TeX but match the profile of this package. Note that the initial versions of this package were released under the name elatex.
% The package provides functions that seem to offer alternative ways of implementing some LaTeX kernel commands; nevertheless, the package will not modify any part of the LaTeX kernel. 
\RequirePackage{etoolbox}

% The package defines commands that switch according to the prevailing 'draft' or 'final' options; each command takes two arguments, the first for the 'true', the second for the 'false' case. Commands are:
%   \ifdraft determines whether we're operating in draft ('true') or final mode;
%   \ifoptiondraft determines whether a 'draft' option has been given; and
%   \ifoptionfinal determines whether a 'final' option has been given.
\RequirePackage{ifdraft}

% This package offers support for package authors who want to use options in key-value format for their package options.
% The package is part of the oberdiek bundle.
\RequirePackage{kvoptions}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CRUCIAL COMMANDS                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deprecate commands
\DeclareRobustCommand{\deprecate}[2]{%
  % #1 is the deprecated command
  % #2 is the new command to use
  % Issue a message at first usage
  \PackageWarning{iswartcl}{%
    Deprecated command \@backslashchar#1;\MessageBreak%
    \protect#2\space should be used instead\MessageBreak%
  }%
  % globally redefine "\#1" to "\deprecate@#1"
  \global\expandafter\let\csname#1\expandafter\endcsname%
                         \csname deprecated@#1\endcsname%
  % issue the old command
  \csname#1\endcsname%
}

\newcommand{\@deprecate}[2]{%
  \expandafter\let\csname deprecated@#1\expandafter\endcsname\csname#1\endcsname%
  \@namedef{#1}{\deprecate{#1}{#2}}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Class Configuration                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Configure the kvoptions-package
\SetupKeyvalOptions{%
  family=ISW,%
  prefix=Document,%
}

% Declare debug options
\DeclareBoolOption{debug}

% Declare print and online style (complementary)
\DeclareBoolOption{print}
\DeclareComplementaryOption{online}{print}

% Declare the document type
\def\DocumentType{regular}
\DeclareOption{regular}{\def\DocumentType{regular}}
\DeclareOption{exam}{\def\DocumentType{exam}}
\DeclareOption{exercise}{\def\DocumentType{exercise}}
\DeclareOption{offprint}{\def\DocumentType{offprint}}
\DeclareOption{report}{\def\DocumentType{report}}

\DeclareBoolOption[false]{twoside}
\DeclareComplementaryOption{oneside}{twoside}

% Allow user to choose language
\def\DocumentLang{ngerman}
\DeclareOption{ngerman}{\def\DocumentLang{ngerman}}
\DeclareOption{german}{\def\DocumentLang{ngerman}}
\DeclareOption{english}{\def\DocumentLang{english}}

% Default options
\ExecuteOptions{ngerman, draft, paper=a4paper, oneside, cleardoublepage=empty, open=right}

% Pass any other options not known to the scrbook package
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% Process options passed to the class
\ProcessKeyvalOptions{ISW}

\ifDocumenttwoside%
  \PassOptionsToClass{twoside}{scrartcl}%
\else%
  \PassOptionsToClass{oneside}{scrartcl}%
\fi%

% Process options (finally)
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Defaults for packages used                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Amsmath
\PassOptionsToPackage{
  centertags,% (default) center tags vertically
%  tbtags,% 'Top-or-bottom tags': For a split equation, place equation numbers level with the last (resp. first) line, if numbers are on the right (resp. left).
  sumlimits,% (default) Place the subscripts and superscripts of summation symbols above and below
%  nosumlimits,% Always place the subscripts and superscripts of summation-type symbols to the side, even in displayed equations.
  intlimits,% Like sumlimits, but for integral symbols.
%  nointlimits,% (default) Opposite of intlimits.
  namelimits,% (default) Like sumlimits, but for certain 'operator names' such as det, inf, lim, max, min, that traditionally have subscripts placed underneath when they occur in a displayed equation.
%  nonamelimits,% Opposite of namelimits.
%  leqno,% Place equation numbers on the left.
  reqno,% Place equation numbers on the right.
  fleqn,% Position equations at a fixed indent from the left margin rather than centered in the text column.
}{amsmath}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Appendix
\PassOptionsToPackage{%
  toc,%
  page,%
}{appendix}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Babel
\PassOptionsToPackage{%
  english,%
  german,%
  ngerman,%
}{babel}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Babelbib
\PassOptionsToPackage{%
  fixlanguage,%
}{babelbib}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cleveref
\PassOptionsToPackage{
  capitalise,%
}{cleveref}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eurosym
\PassOptionsToPackage{%
  gen,%
}{eurosym}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Footmisc
\PassOptionsToPackage{%
  hang,%
  multiple,%
}{footmisc}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geometry
\PassOptionsToPackage{%
%  paper=a4paper,%
  top=3cm,%
  bottom=4cm,%
  outer=4cm,%
  inner=2cm,%
  heightrounded,%
  marginparwidth=2.5cm,%
  marginparsep=0.5cm,%
  footnotesep=2\baselineskip,%
}{geometry}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glossaries
\PassOptionsToPackage{%
  acronym,%
  toc,%
  xindy,%
  nomain,%
}{glossaries}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphicx
\PassOptionsToPackage{
  final,%
}{graphicx}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hyperref
% Configuration of hyperref
\PassOptionsToPackage{%
%  anchorcolor=MainColor,% set color of anchors 
  backref=false,% do bibliographical back references
  baseurl={http://www.isw.uni-stuttgart.de/},% set base URL for document
  bookmarks=true,% make bookmarks
  bookmarksnumbered=true,% put section numbers in bookmarks
  bookmarksopen=false,% open up bookmark tree
  bookmarksopenlevel=1,% level to which bookmarks are open
  bookmarkstype=toc,% to specity which 'toc' file to mimic
  breaklinks=true,% allow links to break ove rlines
  CJKbookmarks=false,% to produce CJK bookmarks
%  citebordercolor=SecondaryColor,% color of border around citation links
%  citecolor=PrimaryColor,% color of citation links
  colorlinks=true,% color links
  debug=false,% provide details of anchors defined; same as verbose
  destlabel=false,% destinations are named by the fist \label after the anchor creation
%  draft=false,% do not do any hyperlinking
%  filebordercolor=SecondaryColor,%  color of border aroundfile links
%  filecolor=PrimaryColor,% color of file links
%  final=true,% all hypertext options are turned on
  frenchlinks=false,% use small caps instead of color for links
  hyperfigures=false,% make figures hyper links
  hyperfootnotes=true,% set up hyperlinked footnotes
  hyperindex=true,% set up hyperlinked indices
  hypertexnames=true,% use guessable names for links
  implicit=true,% redefine LaTeX internals
%  linkbordercolor=SecondaryColor,% color of border aroudn links
%  linkcolor=PrimaryColor,% color of links
  linktocpage=false,% mage page number, not text, be link on TOC, LOF, and LOT
  linktoc=all,% Color all links in TOC
%  menubordercolor=SecondaryColor,% color of border around menu links
%  menucolor=PrimaryColor,% color for menu links
%  nativepdf=false,% an alias for dvips
  naturalnames=false,% use LaTeX-computed names for links
  nesting=false,% allow nesting of links
  pageanchor=true,% put an anchor on every page
  pagebackref=false,% backreference by page number
  pdfborder={0, 0, 1},% width of PDF link border
  pdfcenterwindow=false,% position the document window in the center of the screen
%  pdfdirection={},% direction setting
  pdfdisplaydoctitle=true,% display document title instead of file name in title bar
%  pdfduplex={},% paper handling option for print dialog
  pdffitwindow=false,% resize document window to fit document size
%  pdfhighlight=/I,% se highlighting of PDF loinks
%  pdfinfo={},% alternative way of setting document information
%  pdfkeywords={},% text for PDF Keywords field (set later on in MakeAtL)
%  pdflang=\relax,% PDF langauge identifier (RFC 3066)
  pdfpagemode=UseOutlines,% set default mode of PDF display
  pdfstartpage=1,% page at which PDF document opens
  pdfstartview=Fit,% starting view of PDF document
  raiselinks=false,% raise up links (for HyperTeX backend)
%  runbordercolor=SecondaryColor,% color of border around 'run' links
%  runcolor=PrimarColor,% color of 'run' links
  setpagesize=true,% set page size by special driver commands
  unicode=false,% Unicode encoded pdf strings
%  urlbordercolor=SecondaryColor,% color of border around URL links
%  urlcolor=PrimaryColor,% color of URL links
  verbose=false,% be chatty
}{hyperref}

\ifDocumenttwoside
  \PassOptionsToPackage{%
    pdfpagelayout=TwoColumnRight,% set layout of PDF pages
  }{hyperref}%
\else
  \PassOptionsToPackage{%
    pdfpagelayout=OneColumn,% set layout of PDF pages
  }{hyperref}%
\fi

% Depending on online we will define options to hyperref
\ifDocumentprint
  
\else
  \PassOptionsToPackage{%
    hidelinks=true,%
  }{hyperref}%
\fi%

\ifdraft{ % Draft case
  \PassOptionsToPackage{%
    final=false,%
    draft=true,%
  }{hyperref}%
}{ % Final case
  \PassOptionsToPackage{%
    draft=false,%
    final=true,%
  }{hyperref}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Isodate
\PassOptionsToPackage{%
  english,%
  german,%
  ngerman,%
}{isodate}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Listings
\ifdraft{ % Draft case
  \PassOptionsToPackage{
    draft,%
  }{listings}%
}{ % Final case
  \PassOptionsToPackage{
    final,%
  }{listings}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% natbib
\PassOptionsToPackage{
  square,%
  comma,%
  sort&compress,%
  numbers,%
}{natbib}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nth
\PassOptionsToPackage{%
  super,%
}{nth}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% showkeys
\PassOptionsToPackage{
  % to stop the redefinition of \ref and \pageref, and related commands from the varioref package
  notref,%
  % to stop the redefinition of \cite and related commands from the harvard and natbib packages.
  notcite,%
}{showkeys}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIUnitX
\PassOptionsToPackage{
  per-mode=symbol,%
  binary-units=true,%
}{siunitx}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% scrlayer-scrpage
\PassOptionsToPackage{
  automark,% 
  headsepline=0.2pt,%
  headtopline=0pt,%
  footsepline=0.2pt,%
  draft=false,% To remove rulers inserted by the package
}{scrlayer-scrpage}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Todnotes
\PassOptionsToPackage{
  obeyFinal,%
  colorinlistoftodos,%
  textsize=footnotesize,%
}{todonotes}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Url
\PassOptionsToPackage{
  obeyspaces,%
  hyphens,%
  spaces%
}{url}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xcolor
\PassOptionsToPackage{
  usenames,% 
  dvipsnames,% 
  svgnames,% 
  table,% 
  hyperref,% 
}{xcolor}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% scrartcl
\PassOptionsToClass{
%  abstract=on, %
  chapterprefix=false, %
  parskip=half-, % half a line vertical space between paragraphs; there must be at least 1 em free space in the last line of a paragraph
%  fontsize=14pt,
  open=right,
  toc=bibliography, % The bibliography will be represented by an entry at the table of contents, but will not be numbered.
  toc=listof, % The lists of floating environments i.e., the list of figures and the list of tables, will be represented by entries at the table of contents, but will not be numbered.
  version=last, %
}{scrartcl}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Necessary Packages                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass{scrartcl}

% The package is part of the Koma-Script bundle, that provides an end user interface above scrlayer, to define and manage page styles, controlling page headers and footers. The end user interface is as much compatible to that of the earlier scrpage2 package, that users should easily be able to switch from the older package to the new, more powerful, one.
\RequirePackage{scrlayer-scrpage}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Debug Packages                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debug options
\ifDocumentdebug
  \usepackage{showframe}
% Non-debug options
\else
    
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load All Other Packages                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the language class
\RequirePackage{babel}

% This package provides expandable checks for the current language based on macro \languagename or hyphenation patterns.
% The package is part of the oberdiek bundle.
\RequirePackage{iflang}

% The xspace package provides a single command that looks at what comes after it in the command stream, and decides whether to insert a space to replace one "eaten" by the TeX command decoder. The decision is based on what came after any space, not on whether there was a space (which is unknowable): so if the next thing proves to be punctuation, the chances are there was no space, but if it's a letter, there's probably a need for space. This technique is not perfect, but works in a large proportion of cases.
% The package is part of the latex-tools bundle in the LaTeX required distribution. 
\RequirePackage{xspace}

% Fontspec is a package for X3LaTeX and LuaLaTeX. It provides an automatic and unified interface to feature-rich AAT and OpenType fonts through the NFSS in LaTeX running on X3TeX or LuaTeX engines.
% The package requires the l3kernel and xparse bundles from the LaTeX 3 development team. 
\RequirePackage{fontspec}

% The package supports the Text Companion fonts, which provide many text symbols (such as baht, bullet, copyright, musicalnote, onequarter, section, and yen), in the TS1 encoding.
% Note that the package has been adopted as part of the LaTeX distribution; the reference here is to the original package, which is now little used (if at all). 
\RequirePackage{textcomp}

% Tune the output format of dates according to language. This package provides ten output formats of the commands \today, \printdate, \printdate-TeX, and \daterange (partly language dependent). Formats available are: ISO (yyyy-mm-dd), numeric (e.g.,dd.\,mm.~yyyy), short (e.g.,dd.\,mm.\,yy), TeX (yyyy/mm/dd), original (e.g., dd. mmm yyyy), short original (e.g., dd. mmm yy), as well as numerical formats with Roman numerals for the month. The commands \printdate and \printdate-TeX print any date. The command \daterange prints a date range and leaves out unnecessary year or month entries. This package supports German (old and new rules), Austrian, US English, British English, French, Danish, Swedish, and Norwegian.
\RequirePackage{isodate}

% Latin modern font package
\RequirePackage{lmodern}

% The package provides the principal packages in the AMS-LaTeX distribution. It adapts for use in LaTeX most of the mathematical features found in AMS-TeX; it is highly recommended as an adjunct to serious mathematical typesetting in LaTeX. 
\RequirePackage{amsmath}

% Additional math symbolys for a list see http://milde.users.sourceforge.net/LUCR/Math/mathpackages/amssymb-symbols.pdf
\RequirePackage{amssymb}

% Additional math symbols
\RequirePackage{dsfont}

% Adds infix expressions to perform arithmetic on the arguments of the LaTeX commands \setcounter, \addtocounter, \setlength, and \addtolength. Since many packages start their arithmetic by storing an argument in a register, the package has wide applicability.
% This package is part of the latex-tools bundle in the LaTeX required distribution. 
\RequirePackage{calc}

% Improves the interface for defining floating objects such as figures and tables. Introduces the boxed float, the ruled float and the plaintop float. You can define your own floats and improve the behaviour of the old ones. The package also provides the H float modifier option of the obsolete here package. You can select this as automatic default with \floatplacement{figure}{H}.
\RequirePackage{float}

% Provides support for setting the spacing between lines in a document. Package options include singlespacing, onehalfspacing, and doublespacing. Alternatively the spacing can be changed as required with the \singlespacing, \onehalfspacing, and \doublespacing commands. Other size spacings also available. 
\RequirePackage{setspace}

% The package provides an easy and flexible user interface to customize page layout, implementing auto-centering and auto-balancing mechanisms so that the users have only to give the least description for the page layout. For example, if you want to set each margin 2cm without header space, what you need is just \usepackage[margin=2cm,nohead]{geometry}.
% The package knows about all the standard paper sizes, so that the user need not know what the nominal 'real' dimensions of the paper are, just its standard name (such as a4, letter, etc.).
% An important feature is the package's ability to communicate the paper size it's set up to the output (whether via DVI \specials or via direct interaction with pdf(La)TeX). 
\RequirePackage{geometry}

% This package was developed as a general solution to the problem of including graphics in LaTeX 2.09; as such there are obsolete copies to be found on the web (though no longer on the archive). These old versions should not be used with current LaTeX.
% The current 'preferred' solution is the LaTeX graphicx package, but the graphics bundle does contain a version of epsfig for use with current LaTeX. 
\RequirePackage{epsfig}

% The package builds upon the graphics package, providing a key-value interface for optional arguments to the \includegraphics command. This interface provides facilities that go far beyond what the graphics package offers on its own.
% For extended documentation, see epslatex.
% The package is part of the latex-graphics bundle, which is one of the collections in the LaTeX 'required' set of packages. 
\RequirePackage{graphicx}
\graphicspath{{figures/}{images/}}

%
\RequirePackage{tikz}
% PGFPlots draws high-quality function plots in normal or logarithmic scaling with a user-friendly interface directly in TeX. The user supplies axis labels, legend entries and the plot coordinates for one or more plots and PGFPlots applies axis scaling, computes any logarithms and axis ticks and draws the plots, supporting line plots, scatter plots, piecewise constant plots, bar plots, area plots, mesh-- and surface plots and some more.
% Pgfplots is based on PGF/TikZ (PGF); it runs equally for LaTeX/TeX/ConTeXt. 
\RequirePackage{pgfplots}
% The package provides straightforward ways to define three-dimensional coordinate frames through which to plot in TikZ. The user can specify the orientation of the main coordinate frame, and use standard TikZ commands and coordinates to render their tikzfigure. A secondary coordinate frame is provided to allow rotations and translations with respect to the main coordinate frame. In addition, the package can also handle plotting user-specified functions in spherical polar coordinates, where both the radius and fill color can be expressed as parametric functions of polar angles. 
\RequirePackage{tikz-3dplot}
\RequirePackage{tikzscale}
\pgfplotsset{compat=newest}


% The package has a lot of flexibility, including an option for specifying an entry at the "natural" width of its text.
% The package is distributed with the bigdelim and bigstrut packages, which can be used to advantage with \multirow cells.
\RequirePackage{multirow}

% The package starts from the basic facilities of the color package, and provides easy driver-independent access to several kinds of color tints, shades, tones, and mixes of arbitrary colors. It allows a user to select a document-wide target color model and offers complete tools for conversion between eight color models. Additionally, there is a command for alternating row colors plus repeated non-aligned material (like horizontal lines) in tables. Colors can be mixed like \color{red!30!green!40!blue}.
\RequirePackage{xcolor}
% Defines the 16 colors from Ethan Schoonover's Solarized palette
\RequirePackage{xcolor-solarized}

% The bm package defines a command \bm which makes its argument bold. The argument may be any maths object from a single symbol to an expression. This is closely related to the specification of the \boldsymbol command in AMS-LaTeX, but \bm is rather more careful in the way it does things.
\RequirePackage{bm}

% The package is intended for setting rich text into titling capitals (in which the first character of words are capitalized). It automatically accounts for diacritical marks (like umlauts), national symbols (like "ae"), punctuation, and font changing commands that alter the appearance or size of the text. It allows a list of predesignated words to be protected as lower-cased, and also allows for titling exceptions of various sorts.
\RequirePackage{titlecaps}
\Addlcwords{the,a,an,and,but,for,or,nor,to,with,without}

% The titling package provides control over the typesetting of the \maketitle command and \thanks commands, and makes the \title, \author and \date information permanently available. Multiple titles are allowed in a single document. New titling elements can be added and a titlepage title can be centered on a physical page. 
\RequirePackage{titling}

% Intermix single and multiple columns. Multicol defines a multicols environment which typesets text in multiple columns (up to a maximum of 10), and (by default) balances the end of each column at the end of the environment. The package enables you to switch between any (permitted) number of columns at will: there is no imposed "clear page" operation, as there is in unadorned LaTeX at a switch between \onecolumn and \twocolumn sections. The multicolumn environment can also be used inside a box, thus allowing multicolumned insets in text. Multicol patches the output routine, and may clash with other packages that do the same (e.g., longtable); furthermore, there is no provision for single column floats inside a multicolumn environment, so figures and tables must be coded in-line (using, for example, the H modifier of the float package). The package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{multicol}

%% Longtable allows you to write tables that continue to the next page. You can write captions within the table (typically at the start of the table), and headers and trailers for pages of table. Longtable arranges that the columns on successive pages have the same widths. This last contrasts with the superficially similar supertabular package.
%% Longtable (unlike supertabular) modifies the output routine, and consequently won't work in a multicolumn environment (or in other circumstances where the output routine has been critically altered); it also fails in twocolumn pages.
%% This package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{longtable}

% The package allows rows and columns to be coloured, and even individual cells.
\RequirePackage{colortbl}

% The package provides an environment, tabu, which will make any sort of tabular (that doesn't need to split across pages), and an environment longtabu which provides the facilities of tabu in a modified longtable environment. (Note that this latter offers an enhancement of ltxtable.)
% The package requires the array package, and needs e-TeX to run (since array.sty is present in every conforming distribution of LaTeX, and since every publicly available LaTeX format is built using e-TeX, the requirements are provided by default on any reasonable system). The package also requires xcolor for coloured rules in tables, and colortbl for coloured cells. The longtabu environment further requires that longtable be loaded. The package itself does not load any of these packages for the user.
% The tabu environment may be used in place of tabular, tabular* and tabularx environments, as well as the array environment in maths mode. It overloads tabularx's X-column specification, allowing a width specification, alignment (l, r, c and j) and column type indication (p, m and b).
% \begin{tabu} to <dimen> specifies a target width, and \begin{tabu} spread <dimen> enlarges the environment's "natural" width.
\RequirePackage{tabu}

% The package enhances the quality of tables in LaTeX, providing extra commands as well as behind-the-scenes optimisation. Guidelines are given as to what constitutes a good table in this context. From version 1.61, the package offers longtable compatibility.
\RequirePackage{booktabs}

% The package defines new commands \Centering, \RaggedLeft, and \RaggedRight and new environments Center, FlushLeft, and FlushRight, which set ragged text and are easily configurable to allow hyphenation (the corresponding commands in LaTeX, all of whose names are lower-case, prevent hyphenation altogether).
\RequirePackage{ragged2e}

% Typeset in-line fractions in a "nice" way. The package typesets fractions "nicely" - in the form 'a/b' (i.e., staggered with a slash between them, rather than directly one over the other). The package is distributed as part of a bundle including the units package. Nicefrac's facilities are provided, in a cleaner way, by the (experimental) xfrac package, but see also the faktor package for quotient spaces and the like.
\RequirePackage{nicefrac}

% fouridx - Left sub- and superscripts in maths mode
% The package enables left subscripts and superscripts in maths mode. The sub- and superscripts are raised for optimum fitting to the symbol indexed, in such a way that left and right sub- and superscripts are set on the same level, as appropriate.
% The package provides an alternative to the use of the \sideset command in the amsmath package.
\RequirePackage{fouridx}

% Place lines through maths formulae. A package to draw diagonal lines ("cancelling" a term) and arrows with limits (cancelling a term "to a value") through parts of maths formulae.
\RequirePackage{cancel}

% A comprehensive (SI) units package. Typesetting values with units requires care to ensure that the combined mathematical meaning of the value plus unit combination is clear. In particular, the SI units system lays down a consistent set of units with rules on how they are to be used. However, different countries and publishers have differing conventions on the exact appearance of numbers (and units). A number of LaTeX packages have been developed to provide consistent application of the various rules: SIunits, sistyle, unitsdef and units are the leading examples. The numprint package provides a large number of number-related functions, while dcolumn and rccol provide tools for typesetting tabular numbers. The siunitx package takes the best from the existing packages, and adds new features and a consistent interface. A number of new ideas have been incorporated, to fill gaps in the existing provision. The package also provides backward-compatibility with SIunits, sistyle, unitsdef and units. The aim is to have one package to handle all of the possible unit-related needs of LaTeX users. The package relies on LaTeX 3 support from the l3kernel and l3packages bundles.
\RequirePackage{siunitx}

% This package provides the command \marginnote that may be used instead of \marginpar at almost every place where \marginpar cannot be used, e.g., inside floats, footnotes, or in frames made with the framed package.
\RequirePackage{marginnote}

% A collection of ways to change the typesetting of footnotes. The package provides means of changing the layout of the footnotes themselves (including setting them in 'paragraphs' - the para option), a way to number footnotes per page (the perpage option), to make footnotes disappear in a 'moving' argument (stable option) and to deal with multiple references to footnotes from the same place (multiple option). The package also has a range of techniques for labelling footnotes with symbols rather than numbers.
% Some of the functions of the package are overlap with the functionality of other packages. The para option is also provided by the manyfoot and bigfoot packages, though those are both also portmanteau packages. (Don't be seduced by fnpara, whose implementation is improved by the present package.) The perpage option is also offered by footnpag and by the rather more general-purpose perpage
\RequirePackage{footmisc}

% Enumerate and itemize within paragraphs. Provides enumerate and itemize environments that can be used within paragraphs to format the items either as running text or as separate paragraphs with a preceding number or symbol. Also provides compacted versions of enumerate and itemize.
\RequirePackage{paralist}

% Set the font size relative to the current font size. The basic command of the package is \relsize, whose argument is a number of \magsteps to change size; from this are defined commands \larger, \smaller, \textlarger, etc.
\RequirePackage{relsize}

% The caption package provides many ways to customise the captions in floating environments like figure and table, and cooperates with many other packages. Facilities include rotating captions, sideways captions, continued captions (for tables or figures that come in several parts). A list of compatibility notes, for other packages, is provided in the documentation. The package also provides the "caption outside float" facility, in the same way that simpler packages like capt-of do. The package supersedes caption2.
\RequirePackage{caption}
% The package provides a means of using facilities analagous to those of the caption package, when writing captions for subfigures and the like.
% The package is distributed with caption.
\RequirePackage{subcaption}

% The appendix package provides various ways of formatting the titles of appendices. Also (sub)appendices environments are provided that can be used, for example, for per chapter/section appendices. The word 'Appendix' or similar can be prepended to the appendix number for article class documents. The word 'Appendices' or similar can be added to the table of contents before the appendices are listed. The word 'Appendices' or similar can be typeset as a \part-like heading (page) in the body. An appendices environment is provided which can be used instead of the \appendix command.
\RequirePackage{appendix}

% The package lets the user mark things to do later, in a simple and visually appealing way. The package takes several options to enable customization/finetuning of the visual appearance.
\RequirePackage{todonotes}

% An extended version of TeX, from the NTS project An extended version of TeX (which is capable of running as if it were TeX unmodified). E-TeX has been specified by the LaTeX team as the engine for the development of LaTeX 2e, in the immediate future; as a result, LaTeX programmers may (in all current TeX distributions) assume e-TeX functionality. Development versions of e-TeX are to be found in the TeX live source repository.
\RequirePackage{etex}

% Extended UTF-8 input encoding support for LaTeX. The bundle provides the ucs package, and utf8x.def, together with a large number of support files. The utf8x.def definition file for use with inputenc covers a wider range of Unicode characters than does utf8.def in the LaTeX distribution. The package provides facilities for efficient use of its large sets of Unicode characters. Glyph production may be controlled by various options, which permits use of non-ASCII characters when coding mathematical formulae. Note that the bundle previously had an alias "unicode"; that alias has now been withdrawn, and no package of that name now exists.
\RequirePackage{ucs}

% Reference last page for Page N of M type footers. Reference the number of pages in your LaTeX document through the introduction of a new label which can be referenced like \pageref{LastPage} to give a reference to the last page of a document. It is particularly useful in the page footer that says: Page N of M.
\RequirePackage{lastpage}

% Mathtools provides a series of packages designed to enhance the appearance of documents containing a lot of mathematics. The main backbone is amsmath, so those unfamiliar with this required part of the LaTeX system will probably not find the packages very useful.
% Mathtools provides many useful tools for mathematical typesetting. It is based on amsmath and fixes various deficiencies of amsmath and standard LaTeX. It provides:
% * Extensible symbols, such as brackets, arrows, harpoons, etc.;
% * Various symbols such as \coloneqq (:=);
% * Easy creation of new tag forms;
% * Showing equation numbers only for referenced equations;
% * Extensible arrows, harpoons and hookarrows;
% * Starred versions of the amsmath matrix environments for specifying the column alignment;
% * More building blocks: multlined, cases-like environments, new gathered environments;
% * Maths versions of \makebox, \llap, \rlap etc.;
% * Cramped math styles; and more...
\RequirePackage{mathtools}

% EMPHasizing EQuations. The empheq package is part of the mathtools bundle. The package provides a visual markup extension to amsmath. The user-friendly interface allows the user to put a set of equations inside a box thus enhancing the \boxed feature of amsmath. As a side effect it's also possible to add material on both sides of the equations thus providing (and surpassing) the functionality of the cases package. Users of ntheorem will probably want to have a look at it as well, since the problem with end-of-theorem marks in gather and other environments can be circumvented using empheq.
\RequirePackage{empheq}

% A package built on the standard LaTeX graphics package to perform all the different sorts of rotation one might like, including complete figures and tables with their captions.% 
% If you want continuous text (i.e., more than one page) set in landscape mode, use the lscape package instead. The rotating packages only deals in rotated boxes (or floats, which are % themselves boxes), and boxes always stay on one page.
% If you need to use the facilities of the float in the same document, load rotating.sty via rotfloat, which smooths the path between the rotating and float packages.
\RequirePackage{rotating}

% Control layout of itemize, enumerate, description. This package provides user control over the layout of the three basic list environments: enumerate, itemize and description. It supersedes both enumerate and mdwlist (providing well-structured replacements for all their funtionality), and in addition provides functions to compute the layout of labels, and to 'clone' the standard environments, to create new environments with counters of their own.
\RequirePackage{enumitem}

% Typesetting theorems (AMS style). The package facilitates the kind of theorem setup typically needed in American Mathematical Society publications. The package offers the theorem setup of the AMS document classes (amsart, amsbook, etc.) encapsulated in LaTeX package form so that it can be used with other document classes. Amsthm is part of the (required) AMS-LaTeX distribution, so should be present in any LaTeX distribution.
\RequirePackage{amsthm}

% A simple type of box for LaTeX. This small package provides a convenient input syntax for boxes that don't break their text over lines automatically, but do allow manual line breaks. The boxes shrink to the natural width of the longest line they contain
\RequirePackage{minibox}

% Generate English ordinal numbers. The command \nth{<number>} generates English ordinal numbers of the form 1st, 2nd, 3rd, 4th, etc. LaTeX package options may specify that the ordinal mark be superscripted, and that negative numbers may be treated; Plain TeX users have no access to package options, so need to redefine macros for these changes.
\RequirePackage{nth}

% Show label, ref, cite and bib keys. The showkeys package modifies the \label, \ref, \pageref, \cite and \bibitem commands so that the 'internal' key is printed, without affecting the appearance of the rest of the text, so far as is possible (the keys typically appear in the margin). The package is part of the tools bundle in the LaTeX required distribution.
\ifdraft{\RequirePackage{showkeys}}{}

% Expand acronyms at least once. This package ensures that all acronyms used in the text are spelled out in full at least once. It also provides an environment to build a list of acronyms used. The package is compatible with pdf bookmarks. The package requires the suffix package, which in turn requires that it runs under e-TeX.
\RequirePackage{acronym}

% Defines commands \counterwithin (which sets up a counter to be reset when another is incremented) and \counterwithout (which unsets such a relationship).
\RequirePackage{chngcntr}

% LaTeX's built-in two-column code finishes off a document exactly where the text stops; this will typically leave an isolated left-hand column, or a right-hand column shorter than the left-hand one. This package modifies the LaTeX output routine to make the two columns as nearly of the same length as possible.
% Only used with two-column layout (or, in general, multicols)
\RequirePackage{flushend}

% The bundle provides a package that implements both author-year and numbered references, as well as much detailed of support for other bibliography use. Also Provided are versions of the standard BibTeX styles that are compatible with natbib-plainnat, unsrtnat, abbrnat. The bibliography styles produced by custom-bib are designed from the start to be compatible with natbib.
\RequirePackage{natbib}
\bibliographystyle{babunsrt}

% This package enables to generate multilingual bibliographies in cooperation with babel. Two approaches are possible: Each citation may be written in another language, or the whole bibliography can be typeset in a language chosen by the user. In addition, the package supports commands to change the typography of the bibliographies.
\usepackage{babelbib}

% The dcolumn package makes use of the array package to define a "D" column format for use in tabular environments.
% This package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{dcolumn}

% The European currency symbol for the Euro implemented in METAFONT, using the official European Commission dimensions, and providing several shapes (normal, slanted, bold, outline). The package also includes a LaTeX package which defines the macro, pre-compiled tfm files, and documentation.
\RequirePackage{eurosym}

% The command \url is a form of verbatim command that allows linebreaks at certain characters or combinations of characters, accepts reconfiguration, and can usually be used in the argument to another command. (The \urldef command provides robust commands that serve in cases when \url doesn't work in an argument.) The command is intended for email addresses, hypertext links, directories/paths, etc., which normally have no spaces, so by default the package ignores spaces in its argument. However, a package option "allows spaces", which is useful for operating systems where spaces are a common part of file names.
\RequirePackage{url}

% The hyperref package is used to handle cross-referencing commands in LaTeX to produce hypertext links in the document. The package provides backends for the \special set defined for HyperTeX DVI processors; for embedded pdfmark commands for processing by Acrobat Distiller (dvips and Y&Y's dvipsone); for Y&Y's dviwindo; for PDF control within pdfTeX and dvipdfm; for TeX4ht; and for VTeX's pdf and HTML backends.
% The package is distributed with the backref and nameref packages, which make use of the facilities of hyperref.
% The package depends on the author's kvoptions, ltxcmdsand refcount packages.
\RequirePackage{hyperref}

% This package provides a command much like hyperref's \url that typesets a URL using a typewriter-like font. However, if the dvips driver is being used, the original \url doesn't allow line breaks in the middle of the created link: the link comes in one atomic piece. This package allows such line breaks in the generated links. 
% \RequirePackage{breakurl}

% Intelligent cross-referencing. The package enhances LaTeX's cross-referencing features, allowing the format of references to be determined automatically according to the type of reference. The formats used may be customised in the preamble of a document; babel support is available (though the choice of languages remains limited: currently Danish, Dutch, English, French, German, Italian, Norwegian, Russian, Spanish and Ukranian). The package also offers a means of referencing a list of references, each formatted according to its type. In such lists, it can collapse sequences of numerically-consecutive labels to a reference range.
\RequirePackage{cleveref}

% Create glossaries and lists of acronyms. The glossaries package supports acronyms and multiple glossaries, and has provision for operation in several languages (using the facilities of either babel or polyglossia). New entries are defined to have a name and description (and optionally an associated symbol). Support for multiple languages is offered, and plural forms of terms may be specified. An additional package, glossaries-accsupp, can make use of the accsupp package mechanisms for accessibility support for PDF files containing glossaries. The user may define new glossary styles, and preambles and postambles can be specified. There is provision for loading a database of terms, but only terms used in the text will be added to the relevant glossary. The package uses an indexing program to provide the actual glossary; either makeindex or xindy may serve this purpose, and a Perl script is provided to serve as interface. The package distribution also provides the mfirstuc package, for changing the first letter of a word to upper case. The package supersedes the author's glossary package (which is now obsolete), and a conversion tool is provided.
\RequirePackage{glossaries}



% Some packages from other authors may have problems with KOMA-Script. In my opinion some packages could be im- proved. With some packages this makes only sense, if KOMA- Script was used. With some other packages the package author has another opinion. Sometimes proposals was never answered. Package scrhack contains all those improvement proposals for other packages. This means, scrhack redefines macros of pack- ages from other authors! The redefinitions are only activated, if those packages were loaded. Users may prevent scrhack from redefining macros of individual packages.
\RequirePackage{scrhack}

\usetikzlibrary{angles}
\usetikzlibrary{arrows}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{backgrounds}
\usetikzlibrary{calc}
\usetikzlibrary{decorations}
\usetikzlibrary{decorations.text}
\usetikzlibrary{fit}
\usetikzlibrary{intersections}
\usetikzlibrary{pgfplots.groupplots}
\usetikzlibrary{plotmarks}
\usetikzlibrary{positioning}
\usetikzlibrary{quotes}
\usetikzlibrary{shadows}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONFIGURE PACKAGES                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define colors                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main colors
%\definecolor{MainColor}{HTML}{323232}
\definecolor{MainColor}{RGB}{62,68,76}
%\definecolor{MainColor}{cmyk}{50,35,25,70}
%\definecolor{PrimaryColor}{HTML}{004191}
\definecolor{PrimaryColor}{RGB}{0,81,158}
%\definecolor{PrimaryColor}{cmyk}{100,70,0,0}
%\definecolor{SecondaryColor}{HTML}{00BEFF}
\definecolor{SecondaryColor}{RGB}{0,190,255}
%\definecolor{SecondaryColor}{cmyk}{70,0,0,0}
\definecolor{TertiaryColor}{RGB}{231, 81, 18}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shades of main colors
\colorlet{MainColorVeryVeryLight}{MainColor!40}
\colorlet{MainColorVeryLight}{MainColor!60}
\colorlet{MainColorLight}{MainColor!80}
\colorlet{MainColorDark}{MainColor!120}
\colorlet{MainColorVeryDark}{MainColor!140}
\colorlet{MainColorVeryVeryDark}{MainColor!160}

\colorlet{PrimaryColorVeryVeryLight}{PrimaryColor!40}
\colorlet{PrimaryColorVeryLight}{PrimaryColor!60}
\colorlet{PrimaryColorLight}{PrimaryColor!80}
\colorlet{PrimaryColorDark}{PrimaryColor!120}
\colorlet{PrimaryColorVeryDark}{PrimaryColor!140}
\colorlet{PrimaryColorVeryVeryDark}{PrimaryColor!160}

\colorlet{SecondaryColorVeryVeryLight}{SecondaryColor!40}
\colorlet{SecondaryColorVeryLight}{SecondaryColor!60}
\colorlet{SecondaryColorLight}{SecondaryColor!80}
\colorlet{SecondaryColorDark}{SecondaryColor!120}
\colorlet{SecondaryColorVeryDark}{SecondaryColor!140}
\colorlet{SecondaryColorVeryVeryDark}{SecondaryColor!160}

\colorlet{TertiaryColorVeryVeryLight}{TertiaryColor!40}
\colorlet{TertiaryColorVeryLight}{TertiaryColor!60}
\colorlet{TertiaryColorLight}{TertiaryColor!80}
\colorlet{TertiaryColorDark}{TertiaryColor!120}
\colorlet{TertiaryColorVeryDark}{TertiaryColor!140}
\colorlet{TertiaryColorVeryVeryDark}{TertiaryColor!160}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make hyperref use these colors
\hypersetup{%
  % set color of anchors 
  anchorcolor=MainColor,%
  % color of border around citation links
  citebordercolor=SecondaryColor,%
  % color of citation links
  citecolor=PrimaryColor,%
  %  color of border aroundfile links
  filebordercolor=SecondaryColor,%
  % color of file links
  filecolor=PrimaryColor,%
  % color of border aroudn links
  linkbordercolor=SecondaryColor,%
  % color of links
  linkcolor=PrimaryColor,%
  % color of border around menu links
  menubordercolor=SecondaryColor,%
  % color for menu links
  menucolor=PrimaryColor,%
  % color of border around 'run' links
  runbordercolor=SecondaryColor,%
  % color of 'run' links
  runcolor=PrimarColor,%
  % color of border around URL links
  urlbordercolor=SecondaryColor,%
  % color of URL links
  urlcolor=PrimaryColor,%
}%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors for tables
% \arrayrulecolor cannot be set in the preamble but in the document itself. That's why we are, further down, "extending" the mainmatter command to set the arrayrulecolor to PrimaryColor
\colorlet{ArrayRuleColor}{PrimaryColor}
\colorlet{TableHeader}{PrimaryColor}
\colorlet{TableRowEven}{MainColorVeryVeryLight}
\colorlet{TableRowOdd}{MainColorVeryLight}
\colorlet{TableCellHighlight}{SecondaryColorVeryLight}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define environments                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chapter intro environment
\newenvironment{intro}{%4
  \hfill
  \begin{minipage}{0.9\linewidth}%
    \null\hfill\tikz[baseline=(current bounding box.center)] \draw[color=PrimaryColor, line width=0.75pt] (0,0) -- (0.8\linewidth,0);%
    \begin{spacing}{1.15}%
      \setlength{\parskip}{0pt}
      \setlength{\parindent}{15pt}
      \slshape%
}{%
      \normalfont%
    \end{spacing}%
    \tikz \draw[color=PrimaryColor, line width=0.75pt] (0,0.5\baselineskip) -- (0.8\linewidth,0.5\baselineskip);\hfill%
  \end{minipage}%
  \vspace*{\baselineskip}
}%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abstract
\renewenvironment{abstract}{%
  \thispagestyle{plain}%
  \section*{\abstractname}%
  \addcontentsline{toc}{section}{\abstractname}%
  \begin{spacing}{1.175}%
}{%
  \end{spacing}%
  \vfill%
  \ifdefempty{\@keywords}{}{%
    \let\oldAnd\and%
    \renewcommand{\and}{\unskip,\xspace}%
    \textbf{\color{PrimaryColor}\DocumentLocaleKeywords:}~\@keywords%
    \renewcommand{\and}{\oldAnd}%
  }%
  \cleardoublepage%
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define commands                                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE: In the following, command arguments are specified as follows
% * Required arguments (given in {} curly brackets) are listed with numeric labels e.g., 1) for the first required argument
% * Optional arguments (given in [] square bracktes) are listed with lowercase alpha label e.g., a) for the first optional argument.

% Name of the university
\newcommand{\university}[1]{\gdef\@university{#1}}
\newcommand{\@university}{No \texttt{\textbackslash university} given\@latex@warning@no@line{No \noexpand\university given}}

% Long name of the department
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\@department}{No \texttt{\textbackslash department} given\@latex@warning@no@line{No \noexpand\department given}}

% Short name of the department
\newcommand{\departmentshort}[1]{\gdef\@departmentshort{#1}}
\gdef\@departmentshort{}

% Address of the department
\newcommand{\departmentaddress}[1]{\gdef\@departmentAddress{#1}}
\newcommand{\@departmentAddress}{\@latex@warning@no@line{No \noexpand\departmentaddress given}}

% Name of the faculty
\newcommand{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand{\@faculty}{\@latex@warning@no@line{No \noexpand\faculty given}}

% List of keywords
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\@keywords}{\@latex@warning@no@line{No \noexpand\keywords given}}

% Path to the university logo can be redefined using e.g., \renewcommand{\universitylogo}{logos/utrecht}
\newcommand{\universitylogo}{logo/university}

% Path to the department logo
\newcommand{\departmentlogo}{logo/department}

% Path to the partner's logo
\newcommand{\partnerlogo}{}

% Short name of author(s)
\newcommand{\shortauthor}[1]{\gdef\@shortauthor{#1}}
\gdef\@shortauthor{}

% Running author
\newcommand{\runauthor}{%
  \let\oldAnd\and%
  \renewcommand{\and}{\unskip,\xspace}%
  \@shortauthor%
  \renewcommand{\and}{\oldAnd}%
}

% Short name of title
\newcommand{\shorttitle}[1]{\gdef\@shorttitle{#1}}
\gdef\@shorttitle{}

% Running title
\newcommand{\runtitle}{%
  \@shorttitle%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TYPESETTING COMMANDS                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\DeclarationOfAuthorship}{Declaration of Authorship undefined for current language\cleardoublepage}

% Input content from the content/ folder
\newcommand{\content}[1]{%
  \input{content/#1}
}

% Input content from the demo/ folder
\newcommand{\demo}[1]{%
  \input{demo/#1}
}

% Use for bi-lingual documents
\NewDocumentCommand{\trans}{m m}{%
  \IfLanguageName{english}{#1}{\IfLanguageName{ngerman}{#2}{#1}}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Provide commands for easier (and more beautiful table creation)

% Set the correct order of colors for tables with a head
\newcommand{\tablecolorwithhead}{\rowcolors{1}{TableRowEven}{TableRowOdd}}
% Set the correct order of colors for tables without a head
\newcommand{\tablecolorwithouthead}{\rowcolors{1}{TableRowOdd}{TableRowEven}}
% Sets the table head row color
\newcommand{\tableheadcolor}{\rowcolor{TableHeader}}
% Command to apply styles for a table head column
\newcommand{\thead}[1]{{\color{White}{\bfseries{#1}}}}
% Command to open a table header
\newcommand{\theadbegin}{\toprule\tableheadcolor}
% And command to close a table header
\newcommand{\theadend}{\midrule}

% Colored rule command: \crule{Width}{Height} for a "MainColor" colored rule, or \crule[Color]{Width}{Height} for a "Color" colored rule
\newcommand\crule[3][PrimaryColor]{\textcolor{#1}{\rule{#2}{#3}}}

% Execute command if file #1 is newer than #2
% 1) Path to "new" file
% 2) Path to file to check timestamp against
% 3) command to execute
\newcommand{\executeiffilenewer}[3]{%
  \ifnum\pdfstrcmp{\pdffilemoddate{#1}}%
  {\pdffilemoddate{#2}}>0%
  {\immediate\write18{#3}}\fi%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MATH COMMANDS                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Matrix
% @see http://tex.stackexchange.com/questions/199789/which-bold-style-is-recommended-for-matrix-notation
% Undergraduate algebra version
%\newcommand{\matr}[1]{\mathbf{#1}}
% Pure math version
%\newcommand{\matr}[1]{#1}
% ISO complying version
\DeclareDocumentCommand{\matr}{m}{%
  \bm{#1}%
}

% Vector
\DeclareDocumentCommand{\vect}{m}{%
%  \vec{#1}%
  \bm{#1}%
}

% Absolute value
% \abs{x} renders |x|
\DeclareDocumentCommand{\abs}{m}{%
  \vert {#1} \vert%
}

% Norm
% \norm{a_i} renders || a_i ||_2 
% \norm[1]{a_i} renders || a_i ||_1
\DeclareDocumentCommand{\norm}{o m}{%
  \IfNoValueTF{#1}{%
    \left\Vert {#2} \right\Vert
  }{%
    \left\Vert {#2} \right\Vert_{\smaller[2]{#1}}
  }
}

% Power
% \pow{x} renders x^2
% \pow[3]{x} renders x^3
\DeclareDocumentCommand{\pow}{O{2} m}{%
  {#2}^{#1}%
}

% Skew-symmetric matrix
% \skewm{x} renders x with a tilde on it
\DeclareDocumentCommand{\skewm}{m}{%
  \left[ #1 \right]_{\times}
}

% Diagonal
% \diag renders diag for a matrix as diagonal of the elements
\DeclareMathOperator{\diag}{diag}


% @see http://tex.stackexchange.com/questions/135944/commath-and-ifinner
% Differential operator (upface d)
\DeclareMathOperator{\dif}{d \!}
% Derivative operator (upface D)
\DeclareMathOperator{\Dif}{D \!}

% Command for partial derivatives. The first argument denotes the function and the second argument denotes the variable with respect to which the derivative is taken. The optional argument denotes the order of differentiation. The style (text style/display style) is determined automatically
\providecommand{\pd}[3][]{%
  \frac{\partial{^{#1}}#2}{\partial{#3^{#1}}}%
}

% \tpd[2]{f}{k} denotes the second partial derivative of f with respect to k
% The first letter t means "text style"
\providecommand{\tpd}[3][]{\mathinner{%
  \tfrac{\partial{^{#1}}#2}{\partial{#3^{#1}}}%
}}%
% \dpd[2]{f}{k} denotes the second partial derivative of f with respect to k
% The first letter d means "display style"
\providecommand{\dpd}[3][]{\mathinner{%
  \dfrac{\partial{^{#1}}#2}{\partial{#3^{#1}}}%
}}%

% mixed derivative - analogous to the partial derivative command
% \md{f}{5}{x}{2}{y}{3}
\providecommand{\md}[6]{%
  \frac{\partial{^{#2}}#1}{\partial{#3^{#4}}\partial{#5^{#6}}}%
}%

% \tpd[2]{f}{k} denotes the second partial derivative of f with respect to k
% The first letter t means "text style"
\providecommand{\tmd}[6]{\mathinner{%
  \tfrac{\partial{^{#2}}#1}{\partial{#3^{#4}}\partial{#5^{#6}}}%
}}%
% \dpd[2]{f}{k} denotes the second partial derivative of f with respect to k
% The first letter d means "display style"
\providecommand{\dmd}[6]{\mathinner{%
  \dfrac{\partial{^{#2}}#1}{\partial{#3^{#4}}\partial{#5^{#6}}}%
}}%

% ordinary derivative - analogous to the partial derivative command
\providecommand{\od}[3][]{%
  \frac{\dif{^{#1}}#2}{\dif{#3^{#1}}}%
}%

\providecommand{\tod}[3][]{\mathinner{%
  \tfrac{\dif{^{#1}}#2}{\dif{#3^{#1}}}%
}}%
\providecommand{\dod}[3][]{\mathinner{%
  \dfrac{\dif{^{#1}}#2}{\dif{#3^{#1}}}%
}}%


% Totial differential
\newcommand{\td}[1]{\dif{#1}}

% Real value
\renewcommand{\Re}{\operatorname{Re}}

% Imaginary value
\renewcommand{\Im}{\operatorname{Im}}

% Transpose items
% \transp{A} renders A^T
\DeclareDocumentCommand{\transp}{m}{%
%  {#1}^{\intercal}%
%  {#1}^{\mkern-1.5mu\intercal}%
  {#1}^{\mkern-5mu\mathsf{T}}%
}

% Conjugate complex
\DeclareDocumentCommand{\conj}{o m}{%
  {#2}^{\overline{#1}}
}

% Hermitian conjugate of matrix
\DeclareDocumentCommand{\hermconj}{m m}{%
  {#1}^{\mkern-5mu\mathsf{H}}
}

% Element inverse (usually used for matrix inverse)
% \inv{A} renders A^{-1}
\DeclareDocumentCommand{\inv}{m}{%
  {#1}^{-1}%
}

% Dot-product
% \dotp{a}{b} => a \cdot b
\DeclareDocumentCommand{\dotp}{m m}{%
  {#1} \cdot {#2}
}

% Unit axis coordinate vector
% \evec{x} => \vect{e}_{x} => e_x
% \evec{z} renders \vect{e}_{z} => e_z
% \evec[k]{x} => \vect{k}_{x} => k_x
\DeclareDocumentCommand{\evec}{O{e} m}{%
  \vect{#1}_{\mc{#2}}%
}

% Declare atant a math operator rendering atan2
\DeclareMathOperator{\arctantwo}{atan2}

% Arcus tangent 2
% \atantwo{y}{x} renders atan2(y, x)
\NewDocumentCommand{\arctant}{m m}{%
  \arctantwo \left( #1, #2 \right)%
}%

% Math operator for the trace of matrix
\DeclareMathOperator{\trace}{tr}%

% Range of numbers
% \irange{m} renders i = 1, ..., m
% \irange{m}{j} renders j = 1, ..., m
% \irange[3]{m} renders i = 1, 3, ..., m
% \irange[3]{m}{j} renders j = 1, 3, ..., m
\NewDocumentCommand{\irange}{o m g}{%
  \def\runner{\IfValueTF{#3}{#3}{i}}%
%  \def\delta{#1}%
%  \def\ending{#2}%
  \IfValueTF{#1}{%
    {\runner = 1, #1, \ldots, #2}%
  }{%
    {\runner = 1, \ldots, #2}%
  }%
}%

% Well-scaled math subscripts
\DeclareDocumentCommand{\ms}{m}{%
  {\mbox{\textscale{0.6}{#1}}}%
}

% Proper math subscripts for textual indices like "std" or "coeff". Do not use for variable indices like "i" or "j"
\DeclareDocumentCommand{\mc}{m}{%
  {\ms{\text{#1}}}
}

% Rotation matrix without argument
\DeclareDocumentCommand{\rotm}{}{%
  \matr{R}%
}

% Rotation matrix R with argument with optional index
% \rot{\gamma} renders \matr{R} (\gamma)
% \rot[x]{\gamma} renders \matr{R}_x (\gamma)
\NewDocumentCommand{\rot}{o m}{%
  \IfValueTF{#1}{%
    \rotm_{#1} \left( #2 \right)%
  }{%
    \rotm \left( #2 \right)%
  }%
}

%\newcommand{\rot}[2]{\bm{R}_{#1}\left( #2 \right)}
\DeclareDocumentCommand{\rotx}{m}{%
  \rot[x]{#1}
}
\DeclareDocumentCommand{\roty}{m}{%
  \rot[y]{#1}
}
\DeclareDocumentCommand{\rotz}{m}{%
  \rot[z]{#1}
}

% Operator names for Imaginary and Real unit
\newcommand{\Imop}{\operatorname{Im}}
\newcommand{\Reop}{\operatorname{Re}}

% Imaginary unit i
\DeclareMathOperator{\imagu}{\mathrm{i}}
\DeclareDocumentCommand{\imgu}{}{%
  {\imagu\mkern1mu}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FLOAT COMMANDS                                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create two new lengths for TikZ images: figurewidth and figureheight
\newlength{\figurewidth}
\newlength{\figureheight}
% Set the default lenghts of above defined lengths with aspect ratio 16:9 to width
% of 75% of line width (and height accordingly)
\setlength{\figurewidth}{0.75\linewidth}
\setlength{\figureheight}{0.421875\linewidth}

% Easily include a TikZ image with only three arguments (one required, two optional) - default aspect ratio for a tikz image is 4:3 (0.75 x 0.5625 \linewidth) [width x height]
% a) Width of rendered image
% b) Height of rendered image
% 1) Path to the file
%\newcommand{\includetikz}[3]{%
% \DeclareDocumentCommand{\includetikz}{O{0.75\linewidth} O{0.5625\linewidth} m}{%
%   \setlength{\figurewidth}{#1}%
%   \setlength{\figureheight}{#2}%
% %  \tikzsetnextfilename{#3}%
%   \input{#3.tikz}%
% }
% Deprecate `\includetikz` in favor of `\includegraphics` with the `tikzscale` package
\deprecate{includetikz}{\includegraphics}

% Easily include SVG files with only one required argument (and one optional argument)
% a) Width of the file
% 1) Path to the file
\DeclareDocumentCommand{\includesvg}{o m}{%
  \IfNoValueTF{#1}{%
    \def\svgwidth{0.75\linewidth}
  }{%
    \def\svgwidth{#1}
  }
  \executeiffilenewer{#2.svg}{#2.pdf}{
    inkscape -z -D --file=#2.svg --export-pdf=#2.pdf --export-latex
  }
  \input{#2.pdf_tex}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEXT COMMANDS                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% General typesetting
% Add tm to any trademarked thing
\newcommand{\trademark}[1]{#1\textsuperscript{\texttrademark}}
% Add the (R) to any registered thing
\newcommand{\registered}[1]{#1\textsuperscript{\textregistered}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Common English abbreviations

% w.r.t. => with respect to [in Bezug zu/auf]
\newcommand{\textWrt}{w\@.r\@.t\@.\xspace}
% w.l.o.g. => without loss of generality [o.B.d.A => ohne Beschraenkung der Allgemeinheit]
\newcommand{\textWlog}{w\@.l\@.o\@.g\@.\xspace}
% a.k.a. => also known as [aka => Auch bekannt als]
\newcommand{\textAka}{a\@.k\@.a\@.\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Common German abbreviations

% o.B.d.A => ohne Beschraenkung der Allgemeinheit
\newcommand{\textObda}{o\@.B\@.d\@.A\@.\xspace}
% z.B. => zum Beispiel
\newcommand{\textZb}{z\@.B\@.\xspace}
% o.\"a. => oder aehnliche(s)
\newcommand{\textOae}{o\@.\"a\@.\xspace}
% o.a. => oder andere
\newcommand{\textOa}{o\@.a\@.\xspace}
% u.a. => unter anderem
\newcommand{\textUa}{u\@.a\@.\xspace}
% bzw. => beziehungweise
\newcommand{\textBzw}{bzw\@.\xspace}
% E. h. => Ehrenhalber
\newcommand{\textEh}{E\@.\xspace h\@.\xspace}
% d.h. => das heisst
\newcommand{\textDh}{d\@.\xspace h\@.\xspace}
% o.g. => oben genannt
\newcommand{\textOg}{o.g\@.\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Latin abbreviations
% etc. => et cetera
\newcommand{\textEtc}{etc\@.\xspace}
% i.e. => id est => that is [das ist/heisst]
\newcommand{\textIe}{i\@.e\@.,\xspace}
% cf. => confer => refer to [siehe]
\newcommand{\textCf}{cf\@.\xspace}
% e.g. => exemplari grati => for example [zum Beispiel]
\newcommand{\textEg}{e\@.g\@.,\xspace}
% vs. => versus => against [gegen]
\newcommand{\textVs}{vs\@.\xspace}
% h. c. => honoris causa
\newcommand{\textHc}{h\@.\xspace c\@.\xspace}
% h. c. mult. => honoris causa mult.
\newcommand{\textHcMult}{h\@.\xspace c\@.\xspace mult\@.\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Titles
% Dipl.-Ing. => Diplomingenieur
\newcommand{\textDiplIng}{Dipl.-Ing\@.\xspace}
% Dr.-Ing. => Doktoringenieur
\newcommand{\textDrIng}{Dr.-Ing\@.\xspace}
% Prof. => Professor
\newcommand{\textProf}{Prof\@.\xspace}
% Junior-Prof. => Juniorprofessor
\newcommand{\textJuniorProf}{Junior-Prof\@.\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Company types
% GmbH => Gesellschaft mit beschraenker Haftung
\newcommand{\textGmbh}{GmbH}
% AG => Aktiengesellschaft
\newcommand{\textAg}{AG}
% KG => Kommanditgesellschaft
\newcommand{\textKg}{KG}
% Inc. => Incorporated
\newcommand{\textInc}{Inc\@.\xspace}
% Ltd. => Limited
\newcommand{\textLtd}{Ltd\@.\xspace}
% LLC => Limited liability company
\newcommand{\textLlc}{LLC}



% NOTE: In the following, command arguments are specified as follows
% * Required arguments (given in {} curly brackets) are listed with numeric labels e.g., 1) for the first required argument
% * Optional arguments (given in [] square bracktes) are listed with lowercase alpha label e.g., a) for the first optional argument.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document properties

% Examiner
\newcommand{\examiner}[1]{\gdef\@examiner{#1}}
\newcommand{\@examiner}{No \texttt{\textbackslash examiner} given\@latex@warning@no@line{No \noexpand\examiner given}}

% Student's matriculation number
\newcommand{\matriculation}[1]{\gdef\@matriculation{#1}}
\newcommand{\@matriculation}{\@latex@warning@no@line{No \noexpand\matriculation given}}

% Name of the student's supervisor(s)
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\@supervisor}{No \texttt{\textbackslash supervisor} given\@latex@warning@no@line{No \noexpand\supervisor given}}

% Name of the student's major
\newcommand{\major}[1]{\gdef\@major{#1}}
\newcommand{\@major}{No \texttt{\textbackslash major} given\@latex@warning@no@line{No \noexpand\major given}}

% Name of the partner company/department/faculty/etc
\newcommand{\partner}[1]{\gdef\@partner{#1}}
\gdef\@partner{}

% Place of birth
\newcommand{\placeofbirth}[1]{\gdef\@placeofbirth{#1}}
\gdef\@placeofbirth{}















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Localization                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\addto\captionsenglish{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr\@. 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\def\DocumentLocaleDraft{Draft}
\def\DocumentLocaleLogosuffix{-en}
\def\DocumentLocalePartner{In cooperation with}
\def\DocumentLocaleKeywords{Keywords}
\def\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\contentsname}{Table of Contents}
%\renewcommand{\@dedicationname}{Dedication}
%
\ifdefstring{\DocumentType}{regular}{%
  \def\DocumentName{}
}{}
%
\ifdefstring{\DocumentType}{exam}{%
  \def\DocumentName{Exam}
}{}
%
\ifdefstring{\DocumentType}{exercise}{%
  \def\DocumentName{Exercise}
}{}
%
\ifdefstring{\DocumentType}{offprint}{%
  \def\DocumentName{Offprint}
}{}
%
\ifdefstring{\DocumentType}{report}{%
  \def\DocumentName{Report}
}{}
%
}

\addto\captionsngerman{%
\university{Universit\"at Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen}
\departmentaddress{Seidenstr\@. 36, 70174 Stuttgart}
\departmentshort{ISW}
%
%
\def\DocumentLocaleDraft{Entwurf}
\def\DocumentLocaleLogosuffix{-de}
\def\DocumentLocalePartner{In Kooperation mit}
\def\DocumentLocaleKeywords{Stichw\"orter}
\def\DocumentLocaleDeclaration{Erkl{\"a}rung des Autors}
%
\renewcommand{\appendixtocname}{Anh\"ange}
\renewcommand{\appendixname}{Anhang}
\renewcommand{\appendixpagename}{Anh\"ange}
\renewcommand{\abstractname}{Zusammenfassung}
\renewcommand{\contentsname}{Inhaltsverzeichnis}
%\renewcommand{\@dedicationname}{Widmung}
%
\ifdefstring{\DocumentType}{regular}{%
  \def\DocumentName{}
}{}
%
\ifdefstring{\DocumentType}{exam}{%
  \def\DocumentName{Pr\"ufung}
}{}
%
\ifdefstring{\DocumentType}{exercise}{%
  \def\DocumentName{Aufgaben zur Vorlesung}
}{}
%
\ifdefstring{\DocumentType}{offprint}{%
  \def\DocumentName{Umdruck}
}{}
%
\ifdefstring{\DocumentType}{report}{%
  \def\DocumentName{Bericht}
}{}
%
}

\addto\captionsgerman{%
\university{Universit\"at Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen}
\departmentaddress{Seidenstr\@. 36, 70174 Stuttgart}
\departmentshort{ISW}
%
%
\def\DocumentLocaleDraft{Entwurf}
\def\DocumentLocaleLogosuffix{-de}
\def\DocumentLocalePartner{In Kooperation mit}
\def\DocumentLocaleKeywords{Stichw\"orter}
\def\DocumentLocaleDeclaration{Erkl{\"a}rung des Autors}
%
\renewcommand{\appendixtocname}{Anh\"ange}
\renewcommand{\appendixname}{Anhang}
\renewcommand{\appendixpagename}{Anh\"ange}
\renewcommand{\abstractname}{Zusammenfassung}
\renewcommand{\contentsname}{Inhaltsverzeichnis}
%\renewcommand{\@dedicationname}{Widmung}
%
\ifdefstring{\DocumentType}{regular}{%
  \def\DocumentName{}
}{}
%
\ifdefstring{\DocumentType}{exam}{%
  \def\DocumentName{Pr\"ufung}
}{}
%
\ifdefstring{\DocumentType}{exercise}{%
  \def\DocumentName{Aufgaben zur Vorlesung}
}{}
%
\ifdefstring{\DocumentType}{offprint}{%
  \def\DocumentName{Umdruck}
}{}
%
\ifdefstring{\DocumentType}{report}{%
  \def\DocumentName{Bericht}
}{}
%
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure layout                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Counter definition
% Set counter for the section numbering
\setcounter{secnumdepth}{3}
% Set counter of what to show in the Toc and what not
\setcounter{tocdepth}{2}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header and footer lines
% Thickness of header top line
\setheadtopline{0pt}
% Thickness of header separator line
\setheadsepline{1pt}
% Thickness of footer separator line
\setfootsepline{1pt}
% Thickness of footer bottom line
\setfootbotline{0pt}
% Line above the header
\addtokomafont{headtopline}{\color{MainColor}}
% Line below the header
\addtokomafont{headsepline}{\color{PrimaryColor}}
% Line above the footer
\addtokomafont{footsepline}{\color{PrimaryColor}}
% Line below the footer
\addtokomafont{footbotline}{\color{MainColor}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HEADER STYLES
% Even pages (left pages) from outside to inside
\lehead*[]{\leftmark}
\cehead*[]{}
\rehead*[]{}
% Odd pages (right pages) from inside to outside
\lohead*[]{}
\cohead*[]{}
\rohead*[]{\rightmark}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FOOTER STYES
% Even pages (left pages) from outside to inside
\lefoot*[\pagemark]{\pagemark}
\cefoot*[]{}
\refoot*[]{}
% Odd pages (right pages) from inside to outside
\lofoot*[]{\copyright\,\the\year\space\@departmentshort, \@university}
\cofoot*[]{}
\rofoot*[\pagemark]{\pagemark}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Footnote
\renewcommand{\footnoterule}{\kern-3pt {\color{MainColorLight}{\hrule width 2in}} \kern 2.6pt}
\renewcommand{\thefootnote}{\textcolor{PrimaryColor}{\arabic{footnote}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Komafont definitions
% Setting title to be written in main color, sans-serif, and Huge
\setkomafont{title}{\color{MainColor}\sffamily\Huge}
% Setting subtitle to be written in main color, sans-serif, and large
\setkomafont{subtitle}{\color{MainColor}\sffamily\large}
% Setting author to be written in main color, sans-serif, and huge
\setkomafont{author}{\color{MainColor}\sffamily\huge}
% Setting date to be written in main color, normal font, and normal size
\setkomafont{date}{\color{MainColor}\normalfont\normalsize}
% Page header and footer should be written in the main color and sans-serif
\setkomafont{pageheadfoot}{\color{MainColor}\sffamily}
% Page footer should be written in the main color, sans-serif and small font size
\setkomafont{pagefoot}{\color{MainColor}\sffamily\small}
% Create a new font for "place of birth"
\newkomafont{placeofbirth}{\normalfont\normalsize}
% Make page numbers printed in MainColor
\addtokomafont{pagenumber}{\color{MainColor}\sffamily}

\addtokomafont{disposition}{\color{PrimaryColor}}
\addtokomafont{sectioning}{\color{PrimaryColor}}
\addtokomafont{part}{\color{PrimaryColor}\normalfont\sffamily\Huge}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DICTUM (Part and chapter prefix)
\renewcommand{\dictumwidth}{0.8\linewidth}
\setkomafont{dictum}{\slshape}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tables
% Stretch the padding between table rows globally
\renewcommand{\arraystretch}{1.4}
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\setlength{\belowbottomsep}{0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Itemize Environments: PrimaryColor'ed boxes
% Level one
\setlist[itemize,1]{label={\protect\tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=PrimaryColor, draw=PrimaryColor,fill=PrimaryColor] (0, 0ex) rectangle (0.6ex, 0.6ex);}}
% Level 2
\setlist[itemize,2]{label={\protect \tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=PrimaryColor, draw=PrimaryColor, fill=PrimaryColor] (0,0) circle (0.3ex);}}
% Level 3
\setlist[itemize,3]{label={\protect \tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=PrimaryColor, draw=PrimaryColor, line width=0.15ex] (0,0) rectangle (0.6ex, 0.6ex);}}
% Level 4
\setlist[itemize,4]{label={\protect \tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=PrimaryColor, draw=PrimaryColor, line width=0.15ex] (0,0) circle (0.3ex);}}
% Level 5 ... oo - WHY? Who is using more than four levels of items?


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Captions of all floats
% Setup captions of all floats (figures and captions)
\captionsetup{
  format=hang,% 
  labelsep=colon,% 
  textformat=simple,% 
  justification=justified,% 
  singlelinecheck=off,% 
  font={},% Affects the whole figure caption
  labelfont={footnotesize, bf, color=PrimaryColor},% Affects only the label name and its number
  textfont={},% Affects only the actual float caption
  subrefformat=parens,% 
}
% Setup captions of tables
\captionsetup[table]{
  position=above,%
  belowskip=2pt,%
}
% Setup captions of figures
\captionsetup[figure]{
  position=below,%
}
% Setup captions of subfigures
\captionsetup[subfigure]{%
  position=below,% 
  belowskip=2pt,% 
}
% Setup captions of subfigures
\captionsetup[subfigure]{
  labelformat=parens,
  textfont={sl},
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New Column Types
\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\Centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\RaggedLeft\arraybackslash}p{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Numbering of equations, figures, and tables according to their chapter
\numberwithin{equation}{section}
\numberwithin{figure}{section}
\numberwithin{table}{section}
\counterwithout{footnote}{section}


%\addtokomafont{section}{\color{PrimaryColor}\normalfont\sffamily}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HEADER STYLES
% Even pages (left pages) from outside to inside
\lehead*[]{\leftmark}
\cehead*[]{}
\rehead*[ ]{\runtitle}
% Odd pages (right pages) from inside to outside
\lohead*[]{\runtitle}
\cohead*[]{}
\rohead*[]{\rightmark}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FOOTER STYES
% Even pages (left pages) from outside to inside
\lefoot*[\pagemark]{\pagemark}
\cefoot*[]{}
\refoot*[]{}
% Odd pages (right pages) from inside to outside
\lofoot*[]{\copyright\,\the\year\space\@departmentshort, \@university}
\cofoot*[]{}
\rofoot*[\pagemark]{\pagemark}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Titlepage creation %
\renewcommand{\maketitle}{%
  \newgeometry{inner=1cm, outer=1cm, top=1cm, bottom=1cm}%
  \begin{titlepage}%
    \thispagestyle{empty}%
    \centering%
    \begin{minipage}[t][1cm][c]{0.9\linewidth}%
      \centering%
      \huge\DocumentName\par%
    \end{minipage}\par%
    \vfill\par%
    \begin{minipage}[t][3cm][c]{0.9\linewidth}%
      \centering%
      {\usekomafont{title}{\@title}\par}%
    \end{minipage}\par%
    \vspace*{0.1cm}\par%
    \begin{minipage}[t][1.5cm][c]{0.7\linewidth}%
      \centering%
      \ifdefempty{\@subtitle}{}{%
        \usekomafont{subtitle}{\@subtitle}%
      }%
    \end{minipage}\par%
    \vfill%
    \begin{minipage}[t][2.5cm][c]{0.8\linewidth}
      \centering%
      \let\oldAnd\and%
      \renewcommand{\and}{\unskip,\xspace}%
      {\usekomafont{author}{\@author}}\par%
      \renewcommand{\and}{\oldAnd}%
      \vspace{0.5cm}\par%
    \end{minipage}
    \vfill%
    \begin{minipage}[t][1cm][c]{0.5\linewidth}
      \centering%
      \ifdraft{\color{Red}{\bfseries\ttfamily\Huge\DocumentLocaleDraft}}{}
    \end{minipage}
    \vfill%
    \begin{minipage}[t]{0.7\linewidth}
      \centering%
      \@department, \@university.\par%
      \let\oldAnd\and%
      \renewcommand{\and}{\par}%
      \ifdefempty{\@partner}{}{%
        \vspace*{0.3cm}\par%
        \@partner%
      }%
      \renewcommand{\and}{\oldAnd}%
    \end{minipage}
    \vfill
    \begin{minipage}[t][1cm][t]{0.2\linewidth}
      \centering%
%      \printdayoff%
      \@date%
%      \printdayon%
    \end{minipage}%
  \end{titlepage}%
  \restoregeometry%
  \cleardoublepage%
  \setcounter{page}{1}%
}%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some cleanup tasks                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\let\originalmainmatter\mainmatter%
\newcommand{\mainmatter}{%
  \setstretch{1.25}%
  \setlength{\parindent}{2ex}%
  \arrayrulecolor{ArrayRuleColor}%
  \cleardoublepage%
}%

\ifdraft{
% Set the overfullrule to 5pt if we are in draft mode
\overfullrule=5pt


}{}

% No single lines of text of the following paragraph on the current page's bottom
\clubpenalty=9000
% No single lines of text of the previous paragraph on a new page's top
\widowpenalty=10000
\displaywidowpenalty=10000



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Make @ Letter and at Begin Document                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter%
% Set the hyperref document information
\AtBeginDocument{
  \let\oldAnd\and%
  \renewcommand{\and}{, }%
  \hypersetup{
    pdfauthor={\theauthor},
    pdftitle={\thetitle},
%    pdfsubject={\@isw@thesis},
    pdfkeywords={\@keywords},
  }%
  \renewcommand{\and}{\oldAnd}%
  \iflanguage{ngerman}{%
    \hypersetup{pdflang=de}%
  }{%
    \hypersetup{pdflang=en}%
  }%
  % Select the proper language
  \pagenumbering{Roman}%
  \pagenumbering{arabic}%
  \pagestyle{scrheadings}%
%  \addtocontents{toc}{\protect\setcounter{isw@savetocdepth}{\protect\value{tocdepth}}}
}

% Reset the table row counter for even-odd coloring after every table
\preto\tabular{\global\rownum=\z@}


\makeatother

\AtBeginDocument{%
% Set thesis and bibliography language
\makeatletter
  % Set the thesis language
  \expandafter\selectlanguage\expandafter{\DocumentLang}
  % Set the bibliography language
  \expandafter\selectbiblanguage\expandafter{\DocumentLang}
\makeatother

% Adjust rule color of arrays i.e., tables
\arrayrulecolor{ArrayRuleColor}%


}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of file                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput


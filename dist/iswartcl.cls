% Definition of class version and last release date
\def\fileversion{1.0.1}
\def\filedate{2018/02/04}

% Definition of the actual class interface
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iswartcl}[\filedate\space Version \fileversion\space by Philipp Tempel <philipp.tempel@isw.uni-stuttgart.de>]

% Typeout a notice
\typeout{}
\typeout{ISW - Institute for Control Engineering of Machine Tools}
\typeout{      and Manufacturing Units, University Stuttgart}
\typeout{      Document class for documents}
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

% Declare the document type
\def\DocumentType{regular}
\DeclareOption{regular}{\def\DocumentType{regular}}
\DeclareOption{exam}{\def\DocumentType{exam}}
\DeclareOption{exercise}{\def\DocumentType{exercise}}
\DeclareOption{assignment}{\def\DocumentType{assignment}}
\DeclareOption{offprint}{\def\DocumentType{offprint}}
\DeclareOption{report}{\def\DocumentType{report}}

% Input more common options
% Declare debug options
\DeclareBoolOption{debug}

% Color space
\DeclareBoolOption[true]{rgb}
\DeclareComplementaryOption{cmyk}{rgb}

% Allow user to choose a "big title page"
\DeclareBoolOption[false]{bigtitle}

% Gender of the author
\DeclareBoolOption{female}
\DeclareComplementaryOption{male}{female}

% Users may choose to make use of TikZ for plotting
\DeclareBoolOption{tikz}

% If the user needs more mathematical classes, they can make use of the
% mathematics option
\DeclareBoolOption{mathematics}

% Declare whether thesis was accepted and ready for print (use draft/final to
% switch between draft and final version of either the submission or publishing
% version
\DeclareBoolOption[false]{accepted}


% Pass any other options not known to the scrartcl package
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% Execute default options
\ExecuteOptions{ngerman, draft, paper=a4paper, oneside, cleardoublepage=empty, open=right}

% Process options passed to the class
\ProcessKeyvalOptions{ISW}
\ProcessOptions*






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
%  fleqn,% Position equations at a fixed indent from the left margin rather than centered in the text column.
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
  % english,%
  % german,%
  % ngerman,%
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
% \PassOptionsToPackage{%
%   paper=a4paper,%
%   % top=2.5cm,%
%   % bottom=3cm,%
%   % outer=4cm,%
%   % inner=3cm,%
%   heightrounded,%
%   marginparwidth=2.5cm,%
%   marginparsep=0.5cm,%
%   footnotesep=2\baselineskip,%
% }{geometry}


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
  backref=false,% do bibliographical back references
  baseurl={http://www.isw.uni-stuttgart.de/},% set base URL for document
  bookmarks=true,% make bookmarks
  bookmarksnumbered=true,% put section numbers in bookmarks
  bookmarksopen=false,% open up bookmark tree
  bookmarksopenlevel=1,% level to which bookmarks are open
  bookmarkstype=toc,% to specity which 'toc' file to mimic
  breaklinks=true,% allow links to break ove rlines
  CJKbookmarks=false,% to produce CJK bookmarks
  colorlinks=true,% color links
  debug=false,% provide details of anchors defined; same as verbose
  destlabel=false,% destinations are named by the fist \label after the anchor creation
%  draft=false,% do not do any hyperlinking
%  final=true,% all hypertext options are turned on
  frenchlinks=false,% use small caps instead of color for links
  hyperfigures=false,% make figures hyper links
  hyperfootnotes=true,% set up hyperlinked footnotes
  hyperindex=true,% set up hyperlinked indices
  hypertexnames=true,% use guessable names for links
  implicit=true,% redefine LaTeX internals
  linktocpage=false,% mage page number, not text, be link on TOC, LOF, and LOT
  linktoc=all,% Color all links in TOC
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
  setpagesize=true,% set page size by special driver commands
  unicode=false,% Unicode encoded pdf strings
  verbose=false,% be chatty
}{hyperref}

% Set layout of PDF document in case it is twosided
\if@twoside%
  \PassOptionsToPackage{%
    pdfpagelayout=TwoColumnRight,%
  }{hyperref}%
% Set layout of PDF document in case it is onesided
\else
  \PassOptionsToPackage{%
    pdfpagelayout=OneColumn,%
  }{hyperref}%
\fi

% We need to explicitely tell hyperref that we are in draft or final mode
% @see https://en.wikibooks.org/wiki/LaTeX/Print_version#Problems_with_draft_mode
% Draft case
\ifdraft{%
  \PassOptionsToPackage{%
    final=false,%
    draft=true,%
  }{hyperref}%
% Final case
}{%
  \PassOptionsToPackage{%
    draft=false,%
    final=true,%
  }{hyperref}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Isodate
\PassOptionsToPackage{%
  % english,%
  % german,%
  % ngerman,%
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
  usegeometry,% use geometry package and pass the calculate page dimensions to it
  a4paper,% set papersize to a4
  DIV=12,% typearea(w:157.50 h:222.75) margins(t:24.75 b:17.50)
}{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% biblatex
\PassOptionsToPackage{%
	backend=biber,
	%bibencoding=ascii,%
	language=auto,%
	style=ieee,%numeric-comp,%
	sorting=none, % wie unsrt in bibtex: Nummern nach Zitierreihenfolge vergeben
	%style=authoryear-comp, % Author 1999, 2010
	%bibstyle=authoryear, dashed=true, % dashed: substitute rep. author with ---
	%sorting=nyt, % name, year, title
	maxbibnames=10, % default: 3, et al.
	isbn=false,               %_ISBN ausblenden
	%url = false,
	doi=true,               %_DOI ausblenden
	%uniquename=full,
	giveninits=true,          %Only first letter of given names -> increase chances for homogeneous bibliography
	%backref=true,%
	natbib=true % natbib compatibility mode (\citep and \citet still work)
}{biblatex}


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

% A package which allows the user to set tensor-style super- and subscripts with offsets between successive indices. It supports the typesetting of tensors with mixed upper and lower indices with spacing, also typset preposed indices. This is a complete revision and extension of the original ‘tensor’ package by Mike Piff.
\RequirePackage{tensor}

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
\RequirePackage{tikzscale}
\pgfplotsset{compat=newest}
\ifDocumenttikz
  % The package provides straightforward ways to define three-dimensional coordinate frames through which to plot in TikZ. The user can specify the orientation of the main coordinate frame, and use standard TikZ commands and coordinates to render their tikzfigure. A secondary coordinate frame is provided to allow rotations and translations with respect to the main coordinate frame. In addition, the package can also handle plotting user-specified functions in spherical polar coordinates, where both the radius and fill color can be expressed as parametric functions of polar angles. 
  \RequirePackage{tikz-3dplot}
\fi


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

\ifDocumentmathematics
  % Typeset in-line fractions in a "nice" way. The package typesets fractions "nicely" - in the form 'a/b' (i.e., staggered with a slash between them, rather than directly one over the other). The package is distributed as part of a bundle including the units package. Nicefrac's facilities are provided, in a cleaner way, by the (experimental) xfrac package, but see also the faktor package for quotient spaces and the like.
  \RequirePackage{nicefrac}

  % fouridx - Left sub- and superscripts in maths mode
  % The package enables left subscripts and superscripts in maths mode. The sub- and superscripts are raised for optimum fitting to the symbol indexed, in such a way that left and right sub- and superscripts are set on the same level, as appropriate.
  % The package provides an alternative to the use of the \sideset command in the amsmath package.
  \RequirePackage{fouridx}

  % Place lines through maths formulae. A package to draw diagonal lines ("cancelling" a term) and arrows with limits (cancelling a term "to a value") through parts of maths formulae.
  \RequirePackage{cancel}

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
\fi

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

% Reference last page for Page N of M type footers. Reference the number of pages in your LaTeX document through the introduction of a new label which can be referenced like \pageref{LastPage} to give a reference to the last page of a document. It is particularly useful in the page footer that says: Page N of M.
\RequirePackage{lastpage}

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

% Interpretes quotation marks " and ' and correctly typesets them. Some LaTeX-Editors however provide an option for automatically replacing the correct LaTeX code for quotes, which should be preferred.
\RequirePackage{csquotes}

% Use biblatex, which is the (highly configurable) successor of bibtex and biber
% biber is still used though to sort the bibliography in the background. 
\RequirePackage{biblatex}

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

% Some packages from other authors may have problems with KOMA-Script. In my opinion some packages could be improved. With some packages this makes only sense, if KOMA-Script was used. With some other packages the package author has another opinion. Sometimes proposals was never answered. Package scrhack contains all those improvement proposals for other packages. This means, scrhack redefines macros of pack- ages from other authors! The redefinitions are only activated, if those packages were loaded. Users may prevent scrhack from redefining macros of individual packages.
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
%% Define colors                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main colors
\ifDocumentrgb
  \definecolor{PrimaryColor}{RGB}{62,68,76}
  \definecolor{PrimaryAccent}{RGB}{0,81,158}
  \definecolor{SecondaryAccent}{RGB}{0,190,255}
  \definecolor{TertiaryAccent}{RGB}{231,81,18}
\else
  \definecolor{PrimaryColor}{cmyk}{50,35,25,70}
  \definecolor{PrimaryAccent}{cmyk}{100,70,0,0}
  \definecolor{SecondaryAccent}{cmyk}{70,0,0,0}
  \definecolor{TertiaryAccent}{cmyk}{0,80,100,0}
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shades of main colors
\colorlet{PrimaryColorVeryVeryLight}{PrimaryColor!40}
\colorlet{PrimaryColorVeryLight}{PrimaryColor!60}
\colorlet{PrimaryColorLight}{PrimaryColor!80}
\colorlet{PrimaryColorDark}{PrimaryColor!120}
\colorlet{PrimaryColorVeryDark}{PrimaryColor!140}
\colorlet{PrimaryColorVeryVeryDark}{PrimaryColor!160}

\colorlet{PrimaryAccentVeryVeryLight}{PrimaryAccent!40}
\colorlet{PrimaryAccentVeryLight}{PrimaryAccent!60}
\colorlet{PrimaryAccentLight}{PrimaryAccent!80}
\colorlet{PrimaryAccentDark}{PrimaryAccent!120}
\colorlet{PrimaryAccentVeryDark}{PrimaryAccent!140}
\colorlet{PrimaryAccentVeryVeryDark}{PrimaryAccent!160}

\colorlet{SecondaryAccentVeryVeryLight}{SecondaryAccent!40}
\colorlet{SecondaryAccentVeryLight}{SecondaryAccent!60}
\colorlet{SecondaryAccentLight}{SecondaryAccent!80}
\colorlet{SecondaryAccentDark}{SecondaryAccent!120}
\colorlet{SecondaryAccentVeryDark}{SecondaryAccent!140}
\colorlet{SecondaryAccentVeryVeryDark}{SecondaryAccent!160}

\colorlet{TertiaryAccentVeryVeryLight}{TertiaryAccent!40}
\colorlet{TertiaryAccentVeryLight}{TertiaryAccent!60}
\colorlet{TertiaryAccentLight}{TertiaryAccent!80}
\colorlet{TertiaryAccentDark}{TertiaryAccent!120}
\colorlet{TertiaryAccentVeryDark}{TertiaryAccent!140}
\colorlet{TertiaryAccentVeryVeryDark}{TertiaryAccent!160}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Line above header
\colorlet{headtopline}{PrimaryColor!60}
% Line below header
\colorlet{headsepline}{PrimaryColor}
% Line above footer
\colorlet{footsepline}{PrimaryColor!60}
% Line below footer
\colorlet{footbotline}{PrimaryColor}
% Line above footnotes
\colorlet{footnoterule}{PrimaryColor}
% Footnote number
\colorlet{thefootnote}{PrimaryColor}

% Setting title to be written in main color, sans-serif, and Huge
\colorlet{title}{PrimaryColor}
% Setting subtitle to be written in main color, sans-serif, and large
\colorlet{subtitle}{PrimaryColor}
% Setting author to be written in main color, sans-serif, and huge
\colorlet{author}{PrimaryColor}
% Setting date to be written in main color, normal font, and normal size
\colorlet{date}{PrimaryColor}
% Page header and footer should be written in the main color and sans-serif
\colorlet{pageheadfoot}{PrimaryColor}
% Page footer should be written in the main color, sans-serif and small font size
\colorlet{pagefoot}{PrimaryColor}
% Create a new font for "place of birth"
\colorlet{placeofbirth}{black}
% Make page numbers printed in PrimaryColor
\colorlet{pagenumber}{PrimaryColor}

% Colors for document headings from part over sectioning down to paragraphs
\colorlet{part}{PrimaryColor}
\colorlet{chapter}{part}
\colorlet{disposition}{chapter}
\colorlet{sectioning}{disposition}
\colorlet{section}{sectioning}
\colorlet{subsection}{sectioning}
\colorlet{subsubsection}{sectioning}
\colorlet{paragraph}{black}
\colorlet{subparagraph}{black}
% Color of dictum
\colorlet{dictum}{black}

\colorlet{itemizei}{PrimaryColor}
\colorlet{itemizeii}{PrimaryColor}
\colorlet{itemizeiii}{PrimaryColor}
\colorlet{itemizeiv}{PrimaryColor}

% Color of float object's caption i.e., "Table" or "Figure"
\colorlet{captionlabel}{PrimaryColor}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make hyperref use these colors
\hypersetup{%
  % set color of anchors 
  anchorcolor=Black,%
  % color of border around citation links
  citebordercolor=Black,%
  % color of citation links
  citecolor=Black,%
  %  color of border aroundfile links
  filebordercolor=Black,%
  % color of file links
  filecolor=Black,%
  % color of border around links
  linkbordercolor=Black,%
  % color of links
  linkcolor=Black,%
  % color of border around menu links
  menubordercolor=Black,%
  % color for menu links
  menucolor=Black,%
  % color of border around 'run' links
  runbordercolor=Black,%
  % color of 'run' links
  runcolor=Black,%
  % color of border around URL links
  urlbordercolor=Black,%
  % color of URL links
  urlcolor=Black,%
}%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors for tables
\colorlet{ArrayRuleColor}{PrimaryColor}
\colorlet{TableHeader}{PrimaryColor}
\colorlet{TableRowEven}{LightGray}
\colorlet{TableRowOdd}{LightGray!50}
\colorlet{TableCellHighlight}{SecondaryAccentVeryLight}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONFIGURE PACKAGES          												  %%
%% (needs color information)                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modify enumerates behaviour with setting the format for referencing and colors. The original labels are kept with this order. Referencing now returns the complete list state, e.g. `2.b.iv.A` in a reference to list level 4
% Requires package enumitem which is loaded anyways
\setlist[enumerate,1]{label={\color{PrimaryColor}\arabic*.}, ref = \arabic*}
\setlist[enumerate,2]{label={\color{PrimaryColor}\alph*)}, ref = \theenumi.\alph*}
\setlist[enumerate,3]{label={\color{PrimaryColor}\roman*.}, ref = \theenumii.\roman*}
\setlist[enumerate,4]{label={\color{PrimaryColor}\Alph*.}, ref = \theenumiii.\Alph*}

% Biblatex configuration for hiding URL entries (which may be autogenerated by Citavi), but show them in entry types @misc and @electronics:
\DeclareFieldFormat*{url}{}
\DeclareFieldFormat[misc]{url}{\mkbibacro{URL}\addcolon\space\url{#1}}
\DeclareFieldFormat[electronic]{url}{\mkbibacro{URL}\addcolon\space\url{#1}}



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
    \textbf{\color{PrimaryColor}\keywordsname:}~\@keywords%
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
\newcommand{\university}[1]{\gdef\AuthorUniversity{#1}}
\newcommand{\AuthorUniversity}{No \texttt{\textbackslash university} given\@latex@warning@no@line{No \noexpand\university given}}

% Long name of the department
\newcommand{\department}[1]{\gdef\AuthorDepartment{#1}}
\newcommand{\AuthorDepartment}{No \texttt{\textbackslash department} given\@latex@warning@no@line{No \noexpand\department given}}

% Short name of the department
\newcommand{\departmentshort}[1]{\gdef\AuthorDepartmentShort{#1}}
\gdef\AuthorDepartmentShort{}

% Address of the department
\newcommand{\departmentaddress}[1]{\gdef\AuthorDepartmentAddress{#1}}
\newcommand{\AuthorDepartmentAddress}{\@latex@warning@no@line{No \noexpand\departmentaddress given}}

% Name of the faculty
\newcommand{\faculty}[1]{\gdef\AuthorFaculty{#1}}
\newcommand{\AuthorFaculty}{\@latex@warning@no@line{No \noexpand\faculty given}}

% Path to the university logo can be redefined using e.g., \renewcommand{\universitylogo}{logos/utrecht}
\newcommand{\universitylogo}{images/logo/university}

% Path to the department logo
\newcommand{\departmentlogo}{images/logo/department}

% Image to be shown on the coverpage
\newcommand{\coverpageimage}[1]{\gdef\@coverpageImage{#1}}
\newcommand{\@coverpageImage}{}

% Thank you for the cover page logo
\newcommand{\coverpagethanks}[1]{\gdef\@coverpageThanks{#1}}
\newcommand{\@coverpageThanks}{}

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

% List of keywords
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\@keywords}{\@latex@warning@no@line{No \noexpand\keywords given}}

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
  \IfLanguageName{english}{%
    #1%
  }{%
    \IfLanguageName{german}{%
      #2%
    }{%
      #1%
    }%
  }%
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

% Colored rule command: \crule{Width}{Height} for a "PrimaryColor" colored rule, or \crule[Color]{Width}{Height} for a "Color" colored rule
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

% Only load if option mathematics given
\ifDocumentmathematics
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
% \vect{q} => \bm{q}
% \vect[P]{q} => \tensor*[^{P}]{\vect{q}}
\DeclareDocumentCommand{\vect}{o m}{%
  \IfValueTF{#1}{%
    \tensor*[^{#1}]{\vect{#2}}{}%
  }{%
%    \vec{#2}%
    \bm{#2}%
  }%
}

% Absolute value
% \abs{x} => |x|
\DeclarePairedDelimiterX{\abs}[1]{\lvert}{\rvert}{#1}

% Norm
% \norm{a_i} => \lVert a_i \rVert
\DeclarePairedDelimiterX{\norm}[1]{\lVert}{\rVert}{#1}

% Power
% \pow{x} => {x}^{2}
% \pow[3]{x} => {x}^{3}
\DeclareDocumentCommand{\pow}{O{2} m}{%
  #2^{#1}%
}

% Skew-symmetric matrix
% \skewm{x} => [ x ]_{\times}
% \skewm[\Bigg]{x} => \Bigg[ x \Bigg]_{\times}
\DeclarePairedDelimiterX{\skewm}[1]{[}{]}{#1}

% Cross product
% \crosp{#1}{#2} => {#1} \times {#2}
\DeclareDocumentCommand{\crossp}{m m}{%
  {#1} \times {#2}
}

% Diagonal
% \diag => diag for a matrix as diagonal of the elements
\DeclareMathOperator{\diag}{diag}

% Mathemtical sign operator
\DeclareMathOperator{\sign}{sign}


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
% \transp{A} => A^T
\DeclareDocumentCommand{\transp}{m}{%
%  {#1}^{\intercal}%
%  {#1}^{\mkern-1.5mu\intercal}%
  {#1}^{\mkern-5mu\mathsf{T}}%
}

% Transformation matrix from one system to another
% \trafom{O}{P} => \tensor[^P]{\matr{T}}{_O}
% \trafom[Q]{O}{P} => \tensor[^P]{\matr{Q}}{_O}
\DeclareDocumentCommand{\trafom}{ O{T} m m}{%
  \tensor[^#3]{\matr{#1}}{_#2}
}

% Conjugate complex
\DeclareDocumentCommand{\conj}{ m }{%
  \overline{#1}
}

% Hermitian conjugate of matrix
\DeclareDocumentCommand{\hermconj}{ m m }{%
  {#1}^{\mkern-5mu\mathsf{H}}
}

% Element inverse (usually used for matrix inverse)
% \inv{A} => A^{-1}
\DeclareDocumentCommand{\inv}{m}{%
  #1^{-1}%
}

% Dot-product
% \dotp{a}{b} => a \cdot b
\DeclareDocumentCommand{\dotp}{m m}{%
  {#1} \cdot {#2}
}

% Unit axis coordinate vector
% \evec{x} => \vect{e}_{x} => e_x
% \evec{z} => \vect{e}_{z} => e_z
% \evec[k]{x} => \vect{k}_{x} => k_x
\DeclareDocumentCommand{\evec}{O{e} m}{%
  \vect{#1}_{\mc{#2}}%
}

% Declare atant a math operator rendering atan2
\DeclareMathOperator{\arctantwo}{atan2}

% Arcus tangent 2
% \atantwo{y}{x} => atan2(y, x)
\NewDocumentCommand{\arctant}{m m}{%
  \arctantwo \of{#1, #2}%
}%

% Math operator for the trace of matrix
\DeclareMathOperator{\trace}{tr}%

% Range of numbers
% \irange{m} => i = 1, ..., m
% \irange{m}{j} => j = 1, ..., m
% \irange[3]{m} => i = 1, 3, ..., m
% \irange[3]{m}{j} => j = 1, 3, ..., m
\NewDocumentCommand{\irange}{o m g}{%
  \def\runner{\IfValueTF{#3}{#3}{i}}%
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

% Rotation matrix entry
\DeclareDocumentCommand{\rotscal}{}{%
  R%
}

% Rotation matrix
\DeclareDocumentCommand{\rotmatr}{}{%
  \matr{\rotscal}%
}

% Rotation matrices about specific axes
% \rotx{\alpha} => \rotmatr_{x} \of{\alpha}
\DeclareDocumentCommand{\rotx}{m}{%
  \rotmatr_{x} \of{#1}%
}
% \roty{\beta} => \rotmatr_{y} \of{\beta}
\DeclareDocumentCommand{\roty}{m}{%
  \rotmatr_{y} \of{#1}%
}
% \rotz{\gamma} => \rotmatr_{z} \of{\gamma}
\DeclareDocumentCommand{\rotz}{m}{%
  \rotmatr_{z} \of{#1}%
}

% Operator names for Imaginary and Real unit
\newcommand{\Imop}{\operatorname{Im}}
\newcommand{\Reop}{\operatorname{Re}}

% Imaginary unit i
\DeclareMathOperator{\imagu}{\mathrm{i}}
\DeclareDocumentCommand{\imgu}{}{%
  {\imagu\mkern1mu}%
}

% Inverse hyperbolic functions i.e., more precisely, inverse hyperbolic math
% operators
\DeclareMathOperator{\sech}{sech}
\DeclareMathOperator{\csch}{csch}
\DeclareMathOperator{\arcsec}{arcsec}
\DeclareMathOperator{\arccot}{arccot}
\DeclareMathOperator{\arccsc}{arccsc}
\DeclareMathOperator{\arccosh}{arcCosh}
\DeclareMathOperator{\arcsinh}{arcsinh}
\DeclareMathOperator{\arctanh}{arctanh}
\DeclareMathOperator{\arcsech}{arcsech}
\DeclareMathOperator{\arccsch}{arcCsch}
\DeclareMathOperator{\arccoth}{arcCoth} 


%% Trigonometric functions with parentheses around argument
% \prtrig{\sin}{\beta} => \sin \of{ \beta }
\DeclareDocumentCommand{\prtrig}{ s m m }{%
  #2{%
    \IfBooleanTF{#1}{%
      \of*{#3}%
    }{%
      \of{#3}%
    }%
  }%
}

% Parentheses around sine
\DeclareDocumentCommand{\psin}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\sin}{#2}%
  }{%
    \prtrig{\sin}{#2}%
  }%
}

% Parentheses around cosine
\DeclareDocumentCommand{\pcos}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\cos}{#2}%
  }{%
    \prtrig{\cos}{#2}%
  }%
}

% Parentheses around tangent
\DeclareDocumentCommand{\ptan}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\tan}{#2}%
  }{%
    \prtrig{\tan}{#2}%
  }%
}

% Parentheses around secant
\DeclareDocumentCommand{\psec}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\sec}{#2}%
  }{%
    \prtrig{\sec}{#2}%
  }%
}

% Parentheses around cosecant
\DeclareDocumentCommand{\pcsc}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\csc}{#2}%
  }{%
    \prtrig{\csc}{#2}%
  }%
}

% Parentheses around cotangent
\DeclareDocumentCommand{\pcot}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\cot}{#2}%
  }{%
    \prtrig{\cot}{#2}%
  }%
}


%% Inverse trigonometric functions with parentheses around argument
% Parentheses around arcus sine
\DeclareDocumentCommand{\parcsin}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\arcsin}{#2}%
  }{%
    \prtrig{\arcsin}{#2}%
  }%
}

% Parentheses around arcus cosine
\DeclareDocumentCommand{\parccos}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\arccos}{#2}%
  }{%
    \prtrig{\arccos}{#2}%
  }%
}

% Parentheses around arcus 
\DeclareDocumentCommand{\parctan}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\arctan}{#2}%
  }{%
    \prtrig{\arctan}{#2}%
  }%
}

% Parentheses around arcus 
\DeclareDocumentCommand{\parcsec}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\arcsec}{#2}%
  }{%
    \prtrig{\arcsec}{#2}%
  }%
}

% Parentheses around arcus 
\DeclareDocumentCommand{\parccsc}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\arccsc}{#2}%
  }{%
    \prtrig{\arccsc}{#2}%
  }%
}

% Parentheses around arcus 
\DeclareDocumentCommand{\parccot}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\arccot}{#2}%
  }{%
    \prtrig{\arccot}{#2}%
  }%
}


%% Hyperbolic trigonometric functions with parentheses around argument
% Parentheses around sin hyperbolic
\DeclareDocumentCommand{\psinh}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\sinh}{#2}%
  }{%
    \prtrig{\sinh}{#2}%
  }%
}

% Parentheses around cosine hyperbolic
\DeclareDocumentCommand{\pcosh}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\cosh}{#2}%
  }{%
    \prtrig{\cosh}{#2}%
  }%
}

% Parentheses around cosine hyperbolic
\DeclareDocumentCommand{\ptanh}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\tanh}{#2}%
  }{%
    \prtrig{\tanh}{#2}%
  }%
}

% Parentheses around cosine hyperbolic
\DeclareDocumentCommand{\pcoth}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\coth}{#2}%
  }{%
    \prtrig{\coth}{#2}%
  }%
}


%% Exponential and logarithmic functions with parentheses around argument
% Parentheses around exp
\DeclareDocumentCommand{\pexp}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\exp}{#2}%
  }{%
    \prtrig{\exp}{#2}%
  }%
}

% Parentheses around logarithm base 10
\DeclareDocumentCommand{\plog}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\log}{#2}%
  }{%
    \prtrig{\log}{#2}%
  }%
}

% Parentheses around logarithm base 2
\DeclareDocumentCommand{\pln}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\ln}{#2}%
  }{%
    \prtrig{\ln}{#2}%
  }%
}

% Parentheses around logarithm base e
\DeclareDocumentCommand{\plg}{ s m }{%
  \IfBooleanTF{#1}{%
    \prtrig*{\lg}{#2}%
  }{%
    \prtrig{\lg}{#2}%
  }%
}

% Declare a nice "function of" short hand
% @see https://tex.stackexchange.com/questions/2607/spacing-around-left-and-right
% T \of{x} => T \parentheses{x}
% T \of*{x} => T \parentheses*{x}
% T \of[\big]{x} => T \parentheses[\big]{x}
\DeclarePairedDelimiter\parentheses{\lparen}{\rparen}
\DeclareDocumentCommand{\of}{ s O{} m }{%
  \IfBooleanTF{#1}{%
    \parentheses*[#2]{#3}%
  }{%
    \parentheses{#3}%
  }%
}

\fi
% END Only load if option mathematics given

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FLOAT COMMANDS                                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
\newcommand{\textWrt}{w.r.t.\@\xspace}
% w.l.o.g. => without loss of generality [o.B.d.A => ohne Beschraenkung der Allgemeinheit]
\newcommand{\textWlog}{w.l.o.g.\@\xspace}
% a.k.a. => also known as [aka => Auch bekannt als]
\newcommand{\textAka}{a.k.a.\@\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Common German abbreviations

% o.B.d.A => ohne Beschraenkung der Allgemeinheit
\newcommand{\textObda}{o.\@~B.\@~d.\@~A.\@\xspace}
% z.B. => zum Beispiel
\newcommand{\textZb}{z.\@~B.\@\xspace}
% o.\"a. => oder aehnliche(s)
\newcommand{\textOae}{o.\@~\"a.\@\xspace}
% o.a. => oder andere
\newcommand{\textOa}{o.\@~a.\@\xspace}
% u.a. => unter anderem
\newcommand{\textUa}{u.\@~a.\@\xspace}
% bzw. => beziehungweise
\newcommand{\textBzw}{bzw.\@\xspace}
% E. h. => Ehrenhalber
\newcommand{\textEh}{E.\@\xspace~h.\@\xspace}
% d.h. => das heisst
\newcommand{\textDh}{d.\@\xspace~h.\@\xspace}
% o.g. => oben genannt
\newcommand{\textOg}{o.\@~g.\@\xspace}
% ggf. => gegebenenfalls
\newcommand{\textGgf}{ggf.\@\xspace}
% ca. => circa
\newcommand{\textCa}{ca.\@\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Latin abbreviations
% etc. => et cetera
\newcommand{\textEtc}{etc.\@\xspace}
% i.e. => id est => that is [das ist/heisst]
\newcommand{\textIe}{i.e.\@,\xspace}
% cf. => confer => refer to [siehe]
\newcommand{\textCf}{cf.\@\xspace}
% e.g. => exemplari grati => for example [zum Beispiel]
\newcommand{\textEg}{e.g.\@,\xspace}
% vs. => versus => against [gegen]
\newcommand{\textVs}{vs.\@\xspace}
% h. c. => honoris causa
\newcommand{\textHc}{h.c.\@\xspace}
% h. c. mult. => honoris causa mult.
\newcommand{\textHcMult}{h.\@\xspace~c.\@\xspace~mult.\@\xspace}
% et al. => honoris causa mult.
\newcommand{\textEtAl}{et~al.\@\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Titles
% Dipl.-Ing. => Diplomingenieur
\newcommand{\textDiplIng}{Dipl.-Ing.\@\xspace}
% Dr.-Ing. => Doktoringenieur
\newcommand{\textDrIng}{Dr.-Ing.\@\xspace}
% Prof. => Professor
\newcommand{\textProf}{Prof.\@\xspace}
% Junior-Prof. => Juniorprofessor
\newcommand{\textJuniorProf}{Junior-Prof.\@\xspace}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Company types
% GmbH => Gesellschaft mit beschraenker Haftung
\newcommand{\textGmbh}{GmbH}
% AG => Aktiengesellschaft
\newcommand{\textAg}{AG}
% KG => Kommanditgesellschaft
\newcommand{\textKg}{KG}
% Inc. => Incorporated
\newcommand{\textInc}{Inc.\@\xspace}
% Ltd. => Limited
\newcommand{\textLtd}{Ltd.\@\xspace}
% LLC => Limited liability company
\newcommand{\textLlc}{LLC}

% NOTE: In the following, command arguments are specified as follows
% * Required arguments (given in {} curly brackets) are listed with numeric labels e.g., 1) for the first required argument
% * Optional arguments (given in [] square bracktes) are listed with lowercase alpha label e.g., a) for the first optional argument.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document properties


% Name of the partner company/department/faculty/etc
\newcommand{\partner}[1]{\gdef\@partner{#1}}
\gdef\@partner{}

\newcommand{\frontmatter}{%
  %
}

% \newcommand{\mainmatter}{%
%   \cleardoublepage%
% }







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Localization                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\@ifpackageloaded{babel}{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\newcommand{\keywordsname}{Keywords}
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

  \addto\captionsenglish{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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
  \addto\captionsUSenglish{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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
  \addto\captionsamerican{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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
  \addto\captionsUKenglish{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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
  \addto\captionsbritish{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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
  \addto\captionscanadian{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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
  \addto\captionsaustralian{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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
  \addto\captionsnewzealand{%
\university{University of Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institute for Control Engineering of Machine Tools and Manufacturing Units}
\departmentaddress{Seidenstr.\@ 36, D-70174 Stuttgart, Germany}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Draft}
\gdef\DocumentLocaleLogosuffix{-en}
\gdef\DocumentLocalePartner{In cooperation with}
\gdef\DocumentLocaleKeywords{Keywords}
\gdef\DocumentLocaleDeclaration{Declaration of Authorship}
%
\renewcommand{\appendixtocname}{Appendices}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\appendixpagename}{Appendices}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\keywordsname}{Keywords}
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

  \addto\captionsaustrian{%
\university{Universit\"at Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen}
\departmentaddress{Seidenstr.\@ 36, 70174 Stuttgart}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Entwurf}
\gdef\DocumentLocaleLogosuffix{-de}
\gdef\DocumentLocalePartner{In Kooperation mit}
\gdef\DocumentLocaleKeywords{Stichw\"orter}
\gdef\DocumentLocaleDeclaration{Erkl{\"a}rung des Autors}
%
\renewcommand{\appendixtocname}{Anh\"ange}
\renewcommand{\appendixname}{Anhang}
\renewcommand{\appendixpagename}{Anh\"ange}
\renewcommand{\abstractname}{Zusammenfassung}
\renewcommand{\keywordsname}{Keywords}
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
  }%
  \addto\captionsgerman{%
\university{Universit\"at Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen}
\departmentaddress{Seidenstr.\@ 36, 70174 Stuttgart}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Entwurf}
\gdef\DocumentLocaleLogosuffix{-de}
\gdef\DocumentLocalePartner{In Kooperation mit}
\gdef\DocumentLocaleKeywords{Stichw\"orter}
\gdef\DocumentLocaleDeclaration{Erkl{\"a}rung des Autors}
%
\renewcommand{\appendixtocname}{Anh\"ange}
\renewcommand{\appendixname}{Anhang}
\renewcommand{\appendixpagename}{Anh\"ange}
\renewcommand{\abstractname}{Zusammenfassung}
\renewcommand{\keywordsname}{Keywords}
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
  }%
  \addto\captionsgermanb{%
\university{Universit\"at Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen}
\departmentaddress{Seidenstr.\@ 36, 70174 Stuttgart}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Entwurf}
\gdef\DocumentLocaleLogosuffix{-de}
\gdef\DocumentLocalePartner{In Kooperation mit}
\gdef\DocumentLocaleKeywords{Stichw\"orter}
\gdef\DocumentLocaleDeclaration{Erkl{\"a}rung des Autors}
%
\renewcommand{\appendixtocname}{Anh\"ange}
\renewcommand{\appendixname}{Anhang}
\renewcommand{\appendixpagename}{Anh\"ange}
\renewcommand{\abstractname}{Zusammenfassung}
\renewcommand{\keywordsname}{Keywords}
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
  }%
  \addto\captionsnaustrian{%
\university{Universit\"at Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen}
\departmentaddress{Seidenstr.\@ 36, 70174 Stuttgart}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Entwurf}
\gdef\DocumentLocaleLogosuffix{-de}
\gdef\DocumentLocalePartner{In Kooperation mit}
\gdef\DocumentLocaleKeywords{Stichw\"orter}
\gdef\DocumentLocaleDeclaration{Erkl{\"a}rung des Autors}
%
\renewcommand{\appendixtocname}{Anh\"ange}
\renewcommand{\appendixname}{Anhang}
\renewcommand{\appendixpagename}{Anh\"ange}
\renewcommand{\abstractname}{Zusammenfassung}
\renewcommand{\keywordsname}{Keywords}
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
  }%
  \addto\captionsngerman{%
\university{Universit\"at Stuttgart}
\faculty{Konstruktions-, Produktions- und Fahrzeugtechnik}
\department{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen}
\departmentaddress{Seidenstr.\@ 36, 70174 Stuttgart}
\departmentshort{ISW}
%
%
\gdef\DocumentLocaleDraft{Entwurf}
\gdef\DocumentLocaleLogosuffix{-de}
\gdef\DocumentLocalePartner{In Kooperation mit}
\gdef\DocumentLocaleKeywords{Stichw\"orter}
\gdef\DocumentLocaleDeclaration{Erkl{\"a}rung des Autors}
%
\renewcommand{\appendixtocname}{Anh\"ange}
\renewcommand{\appendixname}{Anhang}
\renewcommand{\appendixpagename}{Anh\"ange}
\renewcommand{\abstractname}{Zusammenfassung}
\renewcommand{\keywordsname}{Keywords}
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
  }%

}{}%



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
% \setheadtopline{0pt}
\KOMAoptions{headtopline=false}
% Thickness of header separator line
% \setheadsepline{0.66pt}
\KOMAoptions{headsepline=0.66pt}
% Thickness of footer separator line
% \setfootsepline{0.66pt}
\KOMAoptions{footsepline=0.66pt}
% Thickness of footer bottom line
% \setfootbotline{0pt}
\KOMAoptions{footbotline=false}
% Line above header
\addtokomafont{headtopline}{\color{headtopline}}
% Line below header
\addtokomafont{headsepline}{\color{headsepline}}
% Line above footer
\addtokomafont{footsepline}{\color{footsepline}}
% Line below footer
\addtokomafont{footbotline}{\color{footbotline}}


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
\refoot*[]{\copyright\,\the\year\space\AuthorDepartmentShort, \AuthorUniversity}
% Odd pages (right pages) from inside to outside
\lofoot*[]{}
\cofoot*[]{}
\rofoot*[\pagemark]{\pagemark}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Footnote
\renewcommand{\footnoterule}{\kern-3pt{\color{footnoterule}{\hrule width 2in}}\kern2.6pt}
\renewcommand{\thefootnote}{\textcolor{thefootnote}{\arabic{footnote}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Komafont definitions
% Setting title to be written in main color, sans-serif, and Huge
\setkomafont{title}{\color{title}\Huge}
% Setting subtitle to be written in main color, sans-serif, and large
\setkomafont{subtitle}{\color{subtitle}\Large}
% Setting author to be written in main color, sans-serif, and huge
\addtokomafont{author}{\color{author}}
% Setting date to be written in main color, normal font, and normal size
\setkomafont{date}{\color{date}\normalfont\normalsize}
% Page header and footer should be written in the main color and sans-serif
\setkomafont{pageheadfoot}{\color{pageheadfoot}}
% Page footer should be written in the main color, sans-serif and small font size
\setkomafont{pagefoot}{\color{pagefoot}\small}
% Create a new font for "place of birth"
\newkomafont{placeofbirth}{\color{placeofbirth}\normalfont\normalsize}
% Make page numbers printed in PrimaryColor
\addtokomafont{pagenumber}{\color{pagenumber}}

% All headings
\addtokomafont{disposition}{\color{disposition}\rmfamily\bfseries}

% All sections (section, subsection, subsubsection)
\addtokomafont{sectioning}{\color{sectioning}}
% Adjustment to sections
\addtokomafont{section}{\color{section}}
% Adjustments to subsection
\addtokomafont{subsection}{\color{subsection}}
% Adjustments to subsubsections
\addtokomafont{subsubsection}{\color{subsubsection}}
% We'll make paragraphs have medium font-weight
\addtokomafont{paragraph}{\color{paragraph}\mdseries}
% And have sub-paragraphs have medium font-weight with a smaller font size
% compared to paragraphs
\addtokomafont{subparagraph}{\color{subparagraph}\mdseries\small}
% Font of label in a description list
% \addtokomafont{descriptionlabel}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DICTUM (Part and chapter prefix)
\renewcommand{\dictumwidth}{0.8\linewidth}
\setkomafont{dictum}{\color{dictum}\slshape}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tables
% Stretch the padding between table rows globally
\renewcommand{\arraystretch}{1.4}
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\setlength{\belowbottomsep}{0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Itemize Environments
% Level one
\setlist[itemize,1]{label={\protect\tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=itemizei, draw=itemizei, fill=itemizei] (0, 0ex) rectangle (0.6ex, 0.6ex);}}
% Level 2
\setlist[itemize,2]{label={\protect \tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=itemizeiii, draw=itemizeiii, line width=0.15ex] (0,0) rectangle (0.6ex, 0.6ex);}}
% Level 3
\setlist[itemize,3]{label={\protect \tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=itemizeii, draw=itemizeii, fill=itemizeii] (0,0) circle (0.3ex);}}
% Level 4
\setlist[itemize,4]{label={\protect \tikz[baseline=-\the\dimexpr\fontdimen22\textfont2\relax] \draw[color=itemizeiv, draw=itemizeiv, line width=0.15ex] (0,0) circle (0.3ex);}}
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
  labelfont={footnotesize, bf, color=captionlabel},% Affects only the label name and its number
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HEADER STYLES
% Even pages (left pages) from outside to inside
\lehead*[]{\leftmark}
\cehead*[]{}
\rehead*[]{\rightmark}
% Odd pages (right pages) from inside to outside
\lohead*[]{\leftmark}
\cohead*[]{}
\rohead*[]{\rightmark}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FOOTER STYES
% Even pages (left pages) from outside to inside
\lefoot*[]{}
\cefoot*[]{--\pagemark--}
\refoot*[]{}
% Odd pages (right pages) from inside to outside
\lofoot*[]{}
\cofoot*[]{--\pagemark--}
\rofoot*[]{}
% \AuthorUniversity\\\copyright\,\the\year\space\AuthorDepartmentShort

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header and footer lines
% Thickness of header top line
% \setheadtopline{0pt}
\KOMAoptions{headtopline=false}
% Thickness of header separator line
% \setheadsepline{0.66pt}
\KOMAoptions{headsepline=0.66pt}
% Thickness of footer separator line
% \setfootsepline{0.66pt}
\KOMAoptions{footsepline=0.66pt}
% Thickness of footer bottom line
% \setfootbotline{0pt}
\KOMAoptions{footbotline=false}
% Line above header
\addtokomafont{headtopline}{\color{headtopline}}
% Line below header
\addtokomafont{headsepline}{\color{headsepline}}
% Line above footer
\addtokomafont{footsepline}{\color{footsepline}}
% Line below footer
\addtokomafont{footbotline}{\color{footbotline}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Footnote
\renewcommand{\footnoterule}{\kern-3pt{\color{footnoterule}{\hrule width 2in}}\kern2.6pt}
\renewcommand{\thefootnote}{\textcolor{thefootnote}{\arabic{footnote}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Komafont definitions
% Setting title to be written in main color, sans-serif, and Huge
\setkomafont{title}{\color{title}\Huge}
% Setting subtitle to be written in main color, sans-serif, and large
\setkomafont{subtitle}{\color{subtitle}\normalsize}
% Setting author to be written in main color, sans-serif, and huge
\addtokomafont{author}{\Large}
% Setting date to be written in main color, normal font, and normal size
% \setkomafont{date}{\color{date}\normalfont\normalsize}
% Page header and footer should be written in the main color and sans-serif
% \setkomafont{pageheadfoot}{\color{pageheadfoot}}
% Page footer should be written in the main color, sans-serif and small font size
% \setkomafont{pagefoot}{\color{pagefoot}\small}
% Make page numbers printed in PrimaryColor
% \addtokomafont{pagenumber}{\color{pagenumber}}

% All headings
% \addtokomafont{disposition}{\color{disposition}}

% % All sections (section, subsection, subsubsection)
%\setkomafont{sectioning}{\color{sectioning}\sffamily\mdseries}
% % Adjustment to sections
% \addtokomafont{section}{\color{section}}
% % Adjustments to subsection
% \addtokomafont{subsection}{\color{subsection}}
% % Adjustments to subsubsections
% \addtokomafont{subsubsection}{\color{subsubsection}}
% % We'll make paragraphs have medium font-weight
\setkomafont{paragraph}{\color{paragraph}\bfseries}
% % And have sub-paragraphs have medium font-weight with a smaller font size
% % compared to paragraphs
\setkomafont{subparagraph}{\color{subparagraph}\bfseries\small}
% % Font of label in a description list
% % \addtokomafont{descriptionlabel}{}

\newcommand{\coverpage}{%
  \noindent%
  \thispagestyle{empty}%
  \newgeometry{inner=0cm, outer=0cm, top=0cm, bottom=0cm}%
  \sffamily%
  \begin{tikzpicture}[%
      remember picture,%
      overlay,%
      inner sep=0pt,%
      outer sep=0pt,%
      x=\paperwidth,%
      y=\paperheight,%
    ]%
    % BLOCK for TITLE and SUBTITLE
    \draw[fill=PrimaryAccent, draw=PrimaryAccent] (0, 0.1) rectangle (1, -0.25);%
    % TITLE
    \node[align=center, anchor=south, text width=0.9\paperwidth] at (0.5, -0.083) {\usekomafont{title}{\larger[3]\color{white}{\@title}}};%
    % SUBTITLE
    \node[align=center, anchor=north, text width=0.75\paperwidth] at (0.5, -0.166) {\usekomafont{subtitle}{\larger[1]\color{white}{\@subtitle}}};%
    % GRAY BLOCK UNDERNEATH TITLE
    \draw[fill=PrimaryColor, draw=PrimaryColor] (0, -0.25) rectangle (1, -0.7);%
    % TYPE OF DOCUMENT
    \node[align=center, text width=0.7\paperwidth] at (0.5, -0.275) {\color{white}{\huge\DocumentName}};%
    % IMAGE
    \ifdefempty{\@coverpageImage}{}{%
      \begin{scope}%
        \clip (0, -0.30) rectangle (1, -0.65);%
        \node[anchor=west, inner sep=0pt, outer sep=0pt] at (0.015, -0.475) {%
          \includegraphics[keepaspectratio, height=0.45\paperheight]{\@coverpageImage}%
        };%
      \end{scope}%
    };%
    % LOGOS
    \ifdefempty{\universitylogo}{}{%
      \node[anchor=west] at (0.083, -0.875) {%
        \includegraphics[width=0.3\paperwidth, keepaspectratio]{\universitylogo}%
      };%
    };%
    \ifdefempty{\departmentlogo}{}{%
      \node[anchor=east] at (0.917, -0.875) {%
        \includegraphics[width=0.3\paperwidth, height=0.08\paperwidth, keepaspectratio]{\departmentlogo}%
      };%
    };%
    % DATE
    \node at (0.5, -0.95) {%
      \printdayoff%
      \@date%
      \printdayon%
    };%
    % LEFT BAR
    \draw[fill=SecondaryAccent, draw=SecondaryAccent] (0,0.1) rectangle (0.033, -1);
  \end{tikzpicture}%
  \clearpage%
  \newgeometry{inner=1.5cm, outer=1.5cm, top=1.5cm, bottom=1.5cm}%
  \thispagestyle{empty}%
  \vspace*{\fill}%
  \begin{minipage}[l]{0.8\linewidth}
    \smaller%
    \ifdefempty{\@coverpageThanks}{}{%
      \@coverpageThanks%
    }%
  \end{minipage}%
  \clearpage%
  \restoregeometry%
  \setcounter{page}{1}%
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Titlepage creation %
\ifDocumentbigtitle
  \renewcommand{\maketitle}{%
    \newgeometry{inner=1.50cm, outer=1.50cm, top=1.50cm, bottom=1.50cm}%
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
        \AuthorDepartment, \AuthorUniversity.\par%
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
\else%
  \renewcommand{\maketitle}{%
    \begin{center}
      \thispagestyle{empty}%
      \centering%
      \ifdefempty{\DocumentName}{}{%
        \begin{minipage}[t][2\baselineskip][c]{0.9\linewidth}%
          \centering%
          \huge\DocumentName\par%
        \end{minipage}\par%
      }%
      \begin{minipage}[t][6\baselineskip][c]{0.9\linewidth}%
        \centering%
        {\usekomafont{title}{\@title}\par}%
      \end{minipage}\par%
      \begin{minipage}[t][3\baselineskip][c]{0.7\linewidth}%
        \centering%
        \ifdefempty{\@subtitle}{}{%
          \usekomafont{subtitle}{\@subtitle}%
        }%
      \end{minipage}\par%
      \vspace*{1\baselineskip}\par%
      \begin{minipage}[t][2\baselineskip][c]{0.9\linewidth}%
        \centering%
        \let\oldAnd\and%
        \renewcommand{\and}{\unskip,\xspace}%
        {\usekomafont{author}{\@author}}\par%
        \renewcommand{\and}{\oldAnd}%
        \vspace{0.5cm}\par%
      \end{minipage}\par%
      \begin{minipage}[t][4\baselineskip][t]{0.65\linewidth}%
        \centering%
        \AuthorDepartment, \AuthorUniversity.\par%
        \let\oldAnd\and%
        \renewcommand{\and}{\par}%
        \ifdefempty{\@partner}{}{%
          \partnername\par%
          \vspace*{0.3cm}\par%
          \@partner%
        }%
        \renewcommand{\and}{\oldAnd}%
      \end{minipage}%
    \end{center}%
    % \cleardoublepage%
    \setcounter{page}{1}%
  }
\fi%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some cleanup tasks                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\mainmatter}{}%
\let\originalmainmatter\mainmatter%
\renewcommand{\mainmatter}{%
\originalmainmatter%
\setlength{\parindent}{2ex}%
\arrayrulecolor{ArrayRuleColor}%
\setstretch{1.25}%
\originalmainmatter%
\setstretch{1.25}%
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
    pdfauthor={\theauthor},%
    pdftitle={\thetitle},%
    pdfkeywords={\@keywords},%
  }%
  \renewcommand{\and}{\oldAnd}%
  % \IfLanguageName{ngerman}{%
  %   \hypersetup{pdflang=de}%
  % }{%
  %   \hypersetup{pdflang=en}%
  % }%
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
  % \expandafter\selectlanguage\expandafter{\DocumentLang}
  % Set the bibliography language
  % \expandafter\selectbiblanguage\expandafter{\DocumentLang}
\makeatother

% Adjust rule color of arrays i.e., tables
\arrayrulecolor{ArrayRuleColor}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of file                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput

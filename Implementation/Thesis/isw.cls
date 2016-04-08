% Definition of class version and last release date
\def\fileversion{0.5.7}
\def\filedate{2016/04/08}

% Definition of the actual class interface
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isw}[\filedate\space Version \fileversion\space by Philipp Tempel <philipp.tempel@isw.uni-stuttgart.de>]

% Typeout a notice
\typeout{}
\typeout{ISW - Institute for Control Engineering of Machine Tools}
\typeout{      and Manufacturing Units, University Stuttgart}
\typeout{      Version \fileversion\space(\filedate) }
\typeout{}

% A generic document command parser
\RequirePackage[log-declarations=true]{xparse}

% e-TeX tools for LaTeX
\RequirePackage{etoolbox}

% Conditional commands in LaTeX documents
\RequirePackage{ifthen}

% The package defines commands that switch according to the prevailing ‘draft’ or ‘final’ options; each command takes two arguments, the first for the ‘true’, the second for the ‘false’ case. Commands are:
%   \ifdraft determines whether we're operating in draft (‘true’) or final mode;
%   \ifoptiondraft determines whether a ‘draft’ option has been given; and
%   \ifoptionfinal determines whether a ‘final’ option has been given.
\RequirePackage{ifdraft}

% Process 'key=value' schemes
\RequirePackage{xkeyval}

%
\RequirePackage{xparse}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPTIONS FOR CLASS                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Provide exclusive option pair "online/print" to allow for setting different color values in e.g., hyperref for online and print publication
\newtoggle{online}\togglefalse{online}
\DeclareOption{online}{\toggletrue{online}}
\DeclareOption{print}{\togglefalse{online}}

% Option for automatically colored table rows
\newbool{alternatingrowcolors}
\DeclareOption{coloredtables}{\booltrue{alternatingrowcolors}}

% Allow user to choose whether they want a mini-toc at the beginning of every chapter
%\newbool{minitoc}
%\DeclareOption{minitoc}{\booltrue{minitoc}}

% Allow the user to switch from listings to minted (if they have the proper environment)
\newbool{minted}
\DeclareOption{minted}{\booltrue{minted}}
\DeclareOption{listing}{\boolfalse{minted}}
\DeclareOption{code=minted}{\booltrue{minted}}
\DeclareOption{code=listing}{\boolfalse{minted}}

% Define the arguments for the language
\def\@thesisLanguage{english}
%\DeclareOption{american}{\def\@thesisLanguage{american}}
\DeclareOption{english}{\def\@thesisLanguage{english}}
\DeclareOption{german}{\def\@thesisLanguage{ngerman}}
%\DeclareOption{language=american}{\def\@thesisLanguage{american}}
\DeclareOption{language=english}{\def\@thesisLanguage{english}}
\DeclareOption{language=german}{\def\@thesisLanguage{ngerman}}

% Allow some paper sizes
\DeclareOption{a4paper}{\PassOptionsToPackage{paper=a4}{typearea}\PassOptionsToPackage{paper=a4paper}{geometry}}
\DeclareOption{a5paper}{\PassOptionsToPackage{paper=a5}{typearea}\PassOptionsToPackage{paper=a5paper}{geometry}}
\DeclareOption{letter}{\PassOptionsToPackage{paper=letter}{typearea}\PassOptionsToPackage{paper=letterpaper}{geometry}}

% Allow to set oneside or twoside
\newtoggle{oneside}
\DeclareOption{twoside}{\togglefalse{oneside}\PassOptionsToPackage{twoside=true}{scrreprt}}
\DeclareOption{oneside}{\toggletrue{oneside}\PassOptionsToPackage{twoside=false}{scrreprt}}

% The actual thesis type
\def\@thesis{ba}
\DeclareOption{description-bsc}{\def\@thesis{description-bsc}}
\DeclareOption{description-bachelor}{\def\@thesis{description-bsc}}
\DeclareOption{description-msc}{\def\@thesis{description-msc}}
\DeclareOption{description-master}{\def\@thesis{description-msc}}
\DeclareOption{bachelor}{\def\@thesis{ba}}
\DeclareOption{bsc}{\def\@thesis{ba}}
\DeclareOption{master}{\def\@thesis{ma}}
\DeclareOption{msc}{\def\@thesis{ma}}
\DeclareOption{study}{\def\@thesis{sa}}
\DeclareOption{sa}{\def\@thesis{sa}}
\DeclareOption{diplom}{\def\@thesis{da}}
\DeclareOption{da}{\def\@thesis{da}}
\DeclareOption{bachelorproject}{\def\@thesis{bpa}}
\DeclareOption{bpa}{\def\@thesis{bpa}}
\DeclareOption{doctorate}{\def\@thesis{phd}}
\DeclareOption{phd}{\def\@thesis{phd}}
\DeclareOption{report}{\def\@thesis{rep}}
\DeclareOption{requirement}{\def\@thesis{prd}}
\DeclareOption{requirements}{\def\@thesis{prd}}
\DeclareOption{specification}{\def\@thesis{fsd}}
\DeclareOption{specifications}{\def\@thesis{fsd}}

% Pass any other options not known to the scrreprt package
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

% Default options
\ExecuteOptions{bachelor,english,langauge=english,a4paper,twoside=true,open=right,draft}

% Process options (finally)
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE DEFAULT OPTIONS PASSED TO CLASSES AND PACKGES                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Default options to the scrreprt class (the main class of this class)
\PassOptionsToClass{%
%    fontsize=11pt, % Obvious option, eh? Fontsize may only be between 10pt...12pt
    parskip=half-, % half a line vertical space between paragraphs; there must be at least 1 em free space in the last line of a paragraph
    chapterprefix=false, %
    numbers=noenddot, % All the numbers (after part, section, etc.) are without ending period
    numbers=noendperiod, % All the numbers (after part, section, etc.) are without ending period
    open=right, %
    cleardoublepage=empty, %
    twoside=true, %
%    captions=tableheading, %
%    captions=nooneline, %
    toc=bibliography, % The bibliography will be represented by an entry at the table of contents, but will not be numbered.
    toc=listof, % The lists of floating environments, e. g., the list of figures and the list of tables, will be represented by entries at the table of contents, but will not be numbered.
    abstract=on, %
    version=last, %
}{scrbook}

% Options to scrlayer-scrpage
\PassOptionsToPackage{
    automark, % 
    headsepline=0.3pt, %
    headtopline=0.6pt, %
    footsepline=0.3pt, %
    draft=false, % To remove rulers inserted by the package
}{scrlayer-scrpage}

% Default options to the geometry paackage
\PassOptionsToPackage{%
    paper=a4paper,
    top=3cm,
    bottom=4cm,
    outer=3.5cm,
    inner=2.5cm,
    heightrounded,
    marginparwidth=2.5cm,
    marginparsep=0.5cm,
}{geometry}

% Configuration of hyperref
\PassOptionsToPackage{%
%    anchorcolor=MainColor, % set color of anchors 
    backref=false, % do bibliographical back references
    baseurl={http://www.isw.uni-stuttgart.de/}, % set base URL for document
    bookmarks=true, % make bookmarks
    bookmarksnumbered=true, % put section numbers in bookmarks
    bookmarksopen=false, % open up bookmark tree
    bookmarksopenlevel=1, % level to which bookmarks are open
    bookmarkstype=toc, % to specity which 'toc' file to mimic
    breaklinks=true, % allow links to break ove rlines
    CJKbookmarks=false, % to produce CJK bookmarks
%    citebordercolor=SecondaryColor, % color of border around citation links
%    citecolor=PrimaryColor, % color of citation links
    colorlinks=true, % color links
    debug=false, % provide details of anchors defined; same as verbose
    destlabel=false, % destinations are named by the fist \label after the anchor creation
%    filebordercolor=SecondaryColor, %  color of border aroundfile links
%    filecolor=PrimaryColor, % color of file links
    frenchlinks=false, % use small caps instead of color for links
    hyperfigures=false, % make figures hyper links
    hyperfootnotes=true, % set up hyperlinked footnotes
    hyperindex=true, % set up hyperlinked indices
    hypertexnames=true, % use guessable names for links
    implicit=true, % redefine LaTeX internals
%    linkbordercolor=SecondaryColor, % color of border aroudn links
%    linkcolor=PrimaryColor, % color of links
    linktocpage=false, % mage page number, not text, be link on TOC, LOF, and LOT
    linktoc=all, % Color all links in TOC
%    menubordercolor=SecondaryColor, % color of border around menu links
%    menucolor=PrimaryColor, % color for menu links
%    nativepdf=false, % an alias for dvips
    naturalnames=false, % use LaTeX-computed names for links
    nesting=false, % allow nesting of links
    pageanchor=true, % put an anchor on every page
    pagebackref=false, % backreference by page number
    pdfborder={0, 0, 1}, % width of PDF link border
    pdfcenterwindow=false, % position the document window in the center of the screen
%    pdfdirection={}, % direction setting
    pdfdisplaydoctitle=true, % display document title instead of file name in title bar
%    pdfduplex={}, % paper handling option for print dialog
    pdffitwindow=false, % resize document window to fit document size
%    pdfhighlight=/I, % se highlighting of PDF loinks
%    pdfinfo={}, % alternative way of setting document information
%    pdfkeywords={}, % text for PDF Keywords field (set later on in MakeAtL)
%    pdflang=\relax, % PDF langauge identifier (RFC 3066)
    pdfstartpage=1, % page at which PDF document opens
    pdfpagemode=UseOutlines, % set default mode of PDF display
    pdfstartview=Fit, % starting view of PDF document
    pdfpagelayout=TwoColumnRight, % set layout of PDF pages
    raiselinks=false, % raise up links (for HyperTeX backend)
%    runbordercolor=SecondaryColor, % color of border around 'run' links
%    runcolor=PrimarColor, % color of 'run' links
    setpagesize=true, % set page size by special driver commands
    unicode=false, % Unicode encoded pdf strings
%    urlbordercolor=SecondaryColor, % color of border around URL links
%    urlcolor=PrimaryColor, % color of URL links
    verbose=false, % be chatty
}{hyperref}

% Depending on online we will define options to hyperref
\iftoggle{online}{% Online options
}{% Print options
    \PassOptionsToPackage{%
        hidelinks=true,
    }{hyperref}
}

% Pass option final or draft to hyperref depending on thesisfinal
\ifdraft{
    \PassOptionsToPackage{draft}{hyperref}
}{
    \PassOptionsToPackage{final}{hyperref}
}

% Necessary options for package xcolor
\PassOptionsToPackage{
    usenames,       % 
    dvipsnames,     % 
    svgnames,       % 
    table,          % 
    hyperref,       % 
}{xcolor}

% Configure amsmath
\PassOptionsToPackage{
    centertags, % (default) center tags vertically
%    tbtags,     % 'Top-or-bottom tags': For a split equation, place equation
    % numbers level with the last (resp. first) line, if numbers
    % are on the right (resp. left).
    sumlimits,  %(default) Place the subscripts and superscripts of summation
    % symbols above and below
%    nosumlimits,  % Always place the subscripts and superscripts of
    % summation-type symbols to the side, even in displayed
    % equations.
    intlimits,   % Like sumlimits, but for integral symbols.
    %nointlimits, % (default) Opposite of intlimits.
    namelimits,  % (default) Like sumlimits, but for certain 'operator names'
    % such as det, inf, lim, max, min, that traditionally have
    % subscripts placed underneath when they occur in a displayed
    % equation.
%    nonamelimits, % Opposite of namelimits.
    leqno,     % Place equation numbers on the left.
%    reqno,     % Place equation numbers on the right.
%    fleqn,     % Position equations at a fixed indent from the left margin rather than centered in the text column.
}{amsmath}

% Only few configuration options to cleveref
\PassOptionsToPackage{
    capitalise
}{cleveref}

% Some configuration of natbib
\PassOptionsToPackage{
    square,
    comma,
    sort&compress,
    numbers
}{natbib}

% Todnotes be configured, too
\PassOptionsToPackage{
    obeyFinal,
    colorinlistoftodos
}{todonotes}

% For code highlighting
\PassOptionsToPackage{%
    chapter, %
}{minted}
\ifdraft{
    \PassOptionsToPackage{draft}{minted}
}{
    \PassOptionsToPackage{final}{minted}
}

\PassOptionsToPackage{
    % to stop the redefinition of \ref and \pageref, and related commands from the varioref package
    notref,
    % to stop the redefinition of \cite and related commands from the harvard and natbib packages.
    notcite
}{showkeys}

\PassOptionsToPackage{
    obeyspaces,
    hyphens,
    spaces
}{url}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOAD ALL PACKAGES NECESSARY FOR SETTING UP THE CLASS                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the scrreprt class
\LoadClass{scrbook}

% Load the language class
\PassOptionsToPackage{english,ngerman}{babel}
\RequirePackage{babel}

%
\RequirePackage{scrlayer-scrpage}

\RequirePackage{xspace}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALL FURTHER PACKAGES                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tune the output format of dates according to language. This package provides ten output formats of the commands \today, \printdate, \printdatε-TeX, and \daterange (partly language dependent). Formats available are: ISO (yyyy-mm-dd), numeric (e.g.,dd.\,mm.~yyyy), short (e.g.,dd.\,mm.\,yy), TeX (yyyy/mm/dd), original (e.g., dd. mmm yyyy), short original (e.g., dd. mmm yy), as well as numerical formats with Roman numerals for the month. The commands \printdate and \printdatε-TeX print any date. The command \daterange prints a date range and leaves out unnecessary year or month entries. This package supports German (old and new rules), Austrian, US English, British English, French, Danish, Swedish, and Norwegian.
\PassOptionsToPackage{english,ngerman}{isodate}
\RequirePackage{isodate}
\daymonthsepgerman{}%
\monthyearsepgerman{}{}%

%\PassOptionsToPackage{english,ngerman}{todonotes}

% Latin modern font package
\RequirePackage{lmodern}

% The package provides the principal packages in the AMS-LaTeX distribution. It adapts for use in LaTeX most of the mathematical features found in AMS-TeX; it is highly recommended as an adjunct to serious mathematical typesetting in LaTeX. 
\RequirePackage{amsmath}
% Number equations, figures, and tables according to their chapter
\numberwithin{equation}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}

% Additional math symbolys for a list see http://milde.users.sourceforge.net/LUCR/Math/mathpackages/amssymb-symbols.pdf
\RequirePackage{amssymb}

% Improves the interface for defining floating objects such as figures and tables. Introduces the boxed float, the ruled float and the plaintop float. You can define your own floats and improve the behaviour of the old ones. The package also provides the H float modifier option of the obsolete here package. You can select this as automatic default with \floatplacement{figure}{H}.
\RequirePackage{float}

%
\RequirePackage{setspace}

%
\RequirePackage{geometry}

% Include Encapsulated PostScript in LaTeX documents
\RequirePackage{epsfig}

% Provides optional arguments to \includegraphics
\RequirePackage{graphicx}
\graphicspath{{figures/}{images/}}

%
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{tikz-3dplot}
\pgfplotsset{compat=newest}
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


% The package has a lot of flexibility, including an option for specifying an entry at the “natural” width of its text.
% The package is distributed with the bigdelim and bigstrut packages, which can be used to advantage with \multirow cells.
\RequirePackage{multirow}

% The package starts from the basic facilities of the color package, and provides easy driver-independent access to several kinds of color tints, shades, tones, and mixes of arbitrary colors. It allows a user to select a document-wide target color model and offers complete tools for conversion between eight color models. Additionally, there is a command for alternating row colors plus repeated non-aligned material (like horizontal lines) in tables. Colors can be mixed like \color{red!30!green!40!blue}.
\RequirePackage{xcolor}
% Defines the 16 colors from Ethan Schoonover's Solarized palette
\RequirePackage{xcolor-solarized}

% The bm package defines a command \bm which makes its argument bold. The argument may be any maths object from a single symbol to an expression. This is closely related to the specification of the \boldsymbol command in AMS-LaTeX, but \bm is rather more careful in the way it does things.
\RequirePackage{bm}

% The package is intended for setting rich text into titling capitals (in which the first character of words are capitalized). It automatically accounts for diacritical marks (like umlauts), national symbols (like “ae”), punctuation, and font changing commands that alter the appearance or size of the text. It allows a list of predesignated words to be protected as lower-cased, and also allows for titling exceptions of various sorts.
\RequirePackage{titlecaps}
\Addlcwords{the,a,an,and,but,for,or,nor,to,}

% Intermix single and multiple columns. Multicol defines a multicols environment which typesets text in multiple columns (up to a maximum of 10), and (by default) balances the end of each column at the end of the environment. The package enables you to switch between any (permitted) number of columns at will: there is no imposed "clear page" operation, as there is in unadorned LaTeX at a switch between \onecolumn and \twocolumn sections. The multicolumn environment can also be used inside a box, thus allowing multicolumned insets in text. Multicol patches the output routine, and may clash with other packages that do the same (e.g., longtable); furthermore, there is no provision for single column floats inside a multicolumn environment, so figures and tables must be coded in-line (using, for example, the H modifier of the float package). The package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{multicol}

%% Longtable allows you to write tables that continue to the next page. You can write captions within the table (typically at the start of the table), and headers and trailers for pages of table. Longtable arranges that the columns on successive pages have the same widths. This last contrasts with the superficially similar supertabular package.
%% Longtable (unlike supertabular) modifies the output routine, and consequently won't work in a multicolumn environment (or in other circumstances where the output routine has been critically altered); it also fails in twocolumn pages.
%% This package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{longtable}

% The package allows rows and columns to be coloured, and even individual cells.
\RequirePackage{colortbl}

% The pack­age pro­vides an en­vi­ron­ment, tabu, which will make any sort of tab­u­lar (that doesn't need to split across pages), and an en­vi­ron­ment longtabu which pro­vides the fa­cil­i­ties of tabu in a mod­i­fied longtable en­vi­ron­ment. (Note that this lat­ter of­fers an en­hance­ment of ltxtable.)
% The pack­age re­quires the ar­ray pack­age, and needs e-TeX to run (since ar­ray.sty is present in ev­ery con­form­ing dis­tri­bu­tion of LaTeX, and since ev­ery pub­licly avail­able LaTeX for­mat is built us­ing e-TeX, the re­quire­ments are pro­vided by de­fault on any rea­son­able sys­tem). The pack­age also re­quires xcolor for coloured rules in ta­bles, and col­ortbl for coloured cells. The longtabu en­vi­ron­ment fur­ther re­quires that longtable be loaded. The pack­age it­self does not load any of these pack­ages for the user.
% The tabu en­vi­ron­ment may be used in place of tab­u­lar, tab­u­lar* and tab­u­larx en­vi­ron­ments, as well as the ar­ray en­vi­ron­ment in maths mode. It over­loads tab­u­larx's X-col­umn spec­i­fi­ca­tion, al­low­ing a width spec­i­fi­ca­tion, align­ment (l, r, c and j) and col­umn type in­di­ca­tion (p, m and b).
% \be­gin{tabu} to <di­men> spec­i­fies a tar­get width, and \be­gin{tabu} spread <di­men> en­larges the en­vi­ron­ment’s “nat­u­ral” width.
\RequirePackage{tabu}

% The package enhances the quality of tables in LaTeX, providing extra commands as well as behind-the-scenes optimisation. Guidelines are given as to what constitutes a good table in this context. From version 1.61, the package offers longtable compatibility.
\RequirePackage{booktabs}

% The package defines new commands \Centering, \RaggedLeft, and \RaggedRight and new environments Center, FlushLeft, and FlushRight, which set ragged text and are easily configurable to allow hyphenation (the corresponding commands in LaTeX, all of whose names are lower-case, prevent hyphenation altogether).
\RequirePackage{ragged2e}

% Typeset in-line fractions in a "nice" way. The package typesets fractions “nicely” — in the form ‘a/b’ (i.e., staggered with a slash between them, rather than directly one over the other). The package is distributed as part of a bundle including the units package. Nicefrac’s facilities are provided, in a cleaner way, by the (experimental) xfrac package, but see also the faktor package for quotient spaces and the like.
\RequirePackage{nicefrac}

% Place lines through maths formulae. A package to draw diagonal lines (“cancelling” a term) and arrows with limits (cancelling a term “to a value”) through parts of maths formulae.
\RequirePackage{cancel}

% A comprehensive (SI) units package. Typesetting values with units requires care to ensure that the combined mathematical meaning of the value plus unit combination is clear. In particular, the SI units system lays down a consistent set of units with rules on how they are to be used. However, different countries and publishers have differing conventions on the exact appearance of numbers (and units). A number of LaTeX packages have been developed to provide consistent application of the various rules: SIunits, sistyle, unitsdef and units are the leading examples. The numprint package provides a large number of number-related functions, while dcolumn and rccol provide tools for typesetting tabular numbers. The siunitx package takes the best from the existing packages, and adds new features and a consistent interface. A number of new ideas have been incorporated, to fill gaps in the existing provision. The package also provides backward-compatibility with SIunits, sistyle, unitsdef and units. The aim is to have one package to handle all of the possible unit-related needs of LaTeX users. The package relies on LaTeX 3 support from the l3kernel and l3packages bundles.
\RequirePackage[per-mode=symbol]{siunitx}

% This package provides the command \marginnote that may be used instead of \marginpar at almost every place where \marginpar cannot be used, e.g., inside floats, footnotes, or in frames made with the framed package.
\RequirePackage{marginnote}

% Typeset source code listings using LaTeX. The package enables the user to typeset programs (programming code) within LaTeX; the source code is read directly by TeX—no front-end processor is needed. Keywords, comments and strings can be typeset using different styles (default is bold for keywords, italic for comments and no special style for strings). Support for hyperref is provided. To use, \usepackage{listings}, identify the language of the object to typeset, using a construct like: \lstset{language=Python}, then use environment lstlisting for inline code. External files may be formatted using \lstinputlisting to process a given file in the form appropriate for the current language. Short (in-line) listings are also available, using either \lstinline|...| or |...| (after defining the | token with the \lstMakeShortInline command).
\ifbool{minted}{}{%
    \RequirePackage{listings}
    \lstset{
        basicstyle=\footnotesize,        % basic style that applies to everything
        backgroundcolor=\color{white},   % choose the background color; you must add \usepackage{color} or \usepackage{xcolor}
        breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
        breaklines=true,                 % sets automatic line breaking
        deletekeywords={...},            % if you want to delete keywords from the given language
        escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
%        fancyvrb=true,
        frame=tb,                        % add a frame at the top and bottom
        numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
        numbersep=5pt,                   % how far the line-numbers are from the code
        numberstyle=\tiny\color{MainColorDark}, % the style that is used for the line-numbers
        numberfirstline=true,            % number the first line regardless of stepnumber
        rulecolor=\color{MainColorVeryDark}, % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
        stepnumber=5,                    % the step between two line-numbers. If it's 1, each line will be numbered
    }
    \lstloadlanguages{[Visual]C++,[95]Fortran,HTML,Java,make,Mathematica,Matlab,MuPAD,Octave,Pascal,Perl,Python,Ruby,sh,SQL,[LaTeX]TeX,XML,XSLT}
}

% minted is a package that allows formatting source code in LATEX. For example:
%\begin{minted}{<language>}
% <code>
%\end{minted}
% will highlight a piece of code in a chosen language. The appearance can be customized with a number of options and color schemes.
% ftp://ftp.tu-chemnitz.de/pub/tex/macros/latex/contrib/minted/minted.pdf
\ifbool{minted}{%
    \RequirePackage{minted}
    \setminted{
        linenos=true,
        numbers=left,
        frame=leftline,
    }
}{}

% Enumerate and itemize within paragraphs. Provides enumerate and itemize environments that can be used within paragraphs to format the items either as running text or as separate paragraphs with a preceding number or symbol. Also provides compacted versions of enumerate and itemize.
\RequirePackage{paralist}

% The caption package provides many ways to customise the captions in floating environments like figure and table, and cooperates with many other packages. Facilities include rotating captions, sideways captions, continued captions (for tables or figures that come in several parts). A list of compatibility notes, for other packages, is provided in the documentation. The package also provides the “caption outside float” facility, in the same way that simpler packages like capt-of do. The package supersedes caption2.
\RequirePackage{caption}
%%% Setup captions of all floats (figures and captions)
\captionsetup{
    format=hang,
    labelsep=colon,
    textformat=simple,
    justification=RaggedRight,
    singlelinecheck=on,
    font={}, % Affects the whole figure caption
    labelfont={footnotesize, bf, color=PrimaryColor}, % Affects only the label name and its number
    textfont={sl}, % Affects only the actual float caption
}
%%% Setup captions of tables
\captionsetup[table]{
    position=above, %
    belowskip=2pt, % 
}
%%% Setup captions of figures
\captionsetup[figure]{
    position=below, %
}
\captionsetup[subfigure]{%
    position=below, % 
    belowskip=2pt, % 
}

% The package provides a means of using facilities analagous to those of the caption package, when writing captions for subfigures and the like.
% The package is distributed with caption.
\RequirePackage{subcaption}
\captionsetup{
    subrefformat=parens,
}
%%% Setup captions of subfigures
\captionsetup[subfigure]{
    labelformat=parens,
    textfont={sl},
}

% The appendix package provides various ways of formatting the titles of appendices. Also (sub)appendices environments are provided that can be used, for example, for per chapter/section appendices. The word ‘Appendix’ or similar can be prepended to the appendix number for article class documents. The word ‘Appendices’ or similar can be added to the table of contents before the appendices are listed. The word ‘Appendices’ or similar can be typeset as a \part-like heading (page) in the body. An appendices environment is provided which can be used instead of the \appendix command.
\RequirePackage[toc, page]{appendix}

% The package lets the user mark things to do later, in a simple and visually appealing way. The package takes several options to enable customization/finetuning of the visual appearance.
\RequirePackage{todonotes}

% An extended version of TeX, from the NTS project An extended version of TeX (which is capable of running as if it were TeX unmodified). E-TeX has been specified by the LaTeX team as the engine for the development of LaTeX 2e, in the immediate future; as a result, LaTeX programmers may (in all current TeX distributions) assume e-TeX functionality. Development versions of e-TeX are to be found in the TeX live source repository.
\RequirePackage{etex}

% Extended UTF-8 input encoding support for LaTeX. The bundle provides the ucs package, and utf8x.def, together with a large number of support files. The utf8x.def definition file for use with inputenc covers a wider range of Unicode characters than does utf8.def in the LaTeX distribution. The package provides facilities for efficient use of its large sets of Unicode characters. Glyph production may be controlled by various options, which permits use of non-ASCII characters when coding mathematical formulae. Note that the bundle previously had an alias “unicode”; that alias has now been withdrawn, and no package of that name now exists.
\RequirePackage{ucs}

% Reference last page for Page N of M type footers. Reference the number of pages in your LaTeX document through the introduction of a new label which can be referenced like \pageref{LastPage} to give a reference to the last page of a document. It is particularly useful in the page footer that says: Page N of M.
\RequirePackage{lastpage}

% EMPHasizing EQuations. The empheq package is part of the mathtools bundle. The package provides a visual markup extension to amsmath. The user-friendly interface allows the user to put a set of equations inside a box thus enhancing the \boxed feature of amsmath. As a side effect it's also possible to add material on both sides of the equations thus providing (and surpassing) the functionality of the cases package. Users of ntheorem will probably want to have a look at it as well, since the problem with end-of-theorem marks in gather and other environments can be circumvented using empheq.
\RequirePackage{empheq}

% A package built on the standard LaTeX graphics package to perform all the different sorts of rotation one might like, including complete figures and tables with their captions.% 
% If you want continuous text (i.e., more than one page) set in landscape mode, use the lscape package instead. The rotating packages only deals in rotated boxes (or floats, which are % themselves boxes), and boxes always stay on one page.
% If you need to use the facilities of the float in the same document, load rotating.sty via rotfloat, which smooths the path between the rotating and float packages.
\RequirePackage{rotating}

% Control layout of itemize, enumerate, description. This package provides user control over the layout of the three basic list environments: enumerate, itemize and description. It supersedes both enumerate and mdwlist (providing well-structured replacements for all their funtionality), and in addition provides functions to compute the layout of labels, and to ‘clone’ the standard environments, to create new environments with counters of their own.
\RequirePackage{enumitem}

% Typesetting theorems (AMS style). The package facilitates the kind of theorem setup typically needed in American Mathematical Society publications. The package offers the theorem setup of the AMS document classes (amsart, amsbook, etc.) encapsulated in LaTeX package form so that it can be used with other document classes. Amsthm is part of the (required) AMS-LaTeX distribution, so should be present in any LaTeX distribution.
\RequirePackage{amsthm}

% A simple type of box for LaTeX. This small package provides a convenient input syntax for boxes that don't break their text over lines automatically, but do allow manual line breaks. The boxes shrink to the natural width of the longest line they contain
\RequirePackage{minibox}

% Generate English ordinal numbers. The command \nth{<number>} generates English ordinal numbers of the form 1st, 2nd, 3rd, 4th, etc. LaTeX package options may specify that the ordinal mark be superscripted, and that negative numbers may be treated; Plain TeX users have no access to package options, so need to redefine macros for these changes.
\RequirePackage[super]{nth}

% Show label, ref, cite and bib keys. The showkeys package modifies the \label, \ref, \pageref, \cite and \bibitem commands so that the ‘internal’ key is printed, without affecting the appearance of the rest of the text, so far as is possible (the keys typically appear in the margin). The package is part of the tools bundle in the LaTeX required distribution.
%\ifbool{thesisfinal}{}{\RequirePackage{showkeys}}

% Expand acronyms at least once. This package ensures that all acronyms used in the text are spelled out in full at least once. It also provides an environment to build a list of acronyms used. The package is compatible with pdf bookmarks. The package requires the suffix package, which in turn requires that it runs under e-TeX.
\RequirePackage{acronym}

% LaTeX’s built-in two-column code finishes off a document exactly where the text stops; this will typically leave an isolated left-hand column, or a right-hand column shorter than the left-hand one. This package modifies the LaTeX output routine to make the two columns as nearly of the same length as possible. 
% Only used with two-column layout (or, in general, multicols)
\RequirePackage{flushend}

% The bundle provides a package that implements both author-year and numbered references, as well as much detailed of support for other bibliography use. Also Provided are versions of the standard BibTeX styles that are compatible with natbib—plainnat, unsrtnat, abbrnat. The bibliography styles produced by custom-bib are designed from the start to be compatible with natbib.
\RequirePackage{natbib}
\bibliographystyle{ieeetr}

% The dcolumn package makes use of the array package to define a "D" column format for use in tabular environments.
% This package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{dcolumn}

% The European currency symbol for the Euro implemented in METAFONT, using the official European Commission dimensions, and providing several shapes (normal, slanted, bold, outline). The package also includes a LaTeX package which defines the macro, pre-compiled tfm files, and documentation.
\RequirePackage[gen]{eurosym}

% The command \url is a form of verbatim command that allows linebreaks at certain characters or combinations of characters, accepts reconfiguration, and can usually be used in the argument to another command. (The \urldef command provides robust commands that serve in cases when \url doesn't work in an argument.) The command is intended for email addresses, hypertext links, directories/paths, etc., which normally have no spaces, so by default the package ignores spaces in its argument. However, a package option “allows spaces”, which is useful for operating systems where spaces are a common part of file names.
\RequirePackage{url}

% The hyperref package is used to handle cross-referencing commands in LaTeX to produce hypertext links in the document. The package provides backends for the \special set defined for HyperTeX DVI processors; for embedded pdfmark commands for processing by Acrobat Distiller (dvips and Y&Y’s dvipsone); for Y&Y’s dviwindo; for PDF control within pdfTeX and dvipdfm; for TeX4ht; and for VTeX’s pdf and HTML backends.
% The package is distributed with the backref and nameref packages, which make use of the facilities of hyperref.
% The package depends on the author’s kvoptions, ltxcmdsand refcount packages.
\RequirePackage{hyperref}

% Intelligent cross-referencing. The package enhances LaTeX's cross-referencing features, allowing the format of references to be determined automatically according to the type of reference. The formats used may be customised in the preamble of a document; babel support is available (though the choice of languages remains limited: currently Danish, Dutch, English, French, German, Italian, Norwegian, Russian, Spanish and Ukranian). The package also offers a means of referencing a list of references, each formatted according to its type. In such lists, it can collapse sequences of numerically-consecutive labels to a reference range.
\RequirePackage{cleveref}

% Create glossaries and lists of acronyms. The glossaries package supports acronyms and multiple glossaries, and has provision for operation in several languages (using the facilities of either babel or polyglossia). New entries are defined to have a name and description (and optionally an associated symbol). Support for multiple languages is offered, and plural forms of terms may be specified. An additional package, glossaries-accsupp, can make use of the accsupp package mechanisms for accessibility support for PDF files containing glossaries. The user may define new glossary styles, and preambles and postambles can be specified. There is provision for loading a database of terms, but only terms used in the text will be added to the relevant glossary. The package uses an indexing program to provide the actual glossary; either makeindex or xindy may serve this purpose, and a Perl script is provided to serve as interface. The package distribution also provides the mfirstuc package, for changing the first letter of a word to upper case. The package supersedes the author’s glossary package (which is now obsolete), and a conversion tool is provided.
\RequirePackage{glossaries}

% Some packages from other authors may have problems with KOMA-Script. In my opinion some packages could be im- proved. With some packages this makes only sense, if KOMA- Script was used. With some other packages the package author has another opinion. Sometimes proposals was never answered. Package scrhack contains all those improvement proposals for other packages. This means, scrhack redefines macros of pack- ages from other authors! The redefinitions are only activated, if those packages were loaded. Users may prevent scrhack from redefining macros of individual packages.
\RequirePackage{scrhack}

% Set the language as defined in the language option to the class
\AtBeginDocument{
    \expandafter\selectlanguage\expandafter{\@thesisLanguage}
}


\newcommand{\DeclarationOfAuthorship}{Unknown language set for declaration of authorship}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOCALIZATION AND INTERNATIONALIZATION                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For German
\addto{\captionsngerman}{%
    \def\@localDraft{Entwurf}
    \def\@localExaminer{Pr\"ufer}
    \def\@localSupervisor{Betreuer}
    \def\@localLogoSuffix{-de}
    \def\@localSubmittedBy{eingereicht von}
    \def\@localFrom{aus}
    \def\@localSubmittedOn{Eingereicht am}
    \def\@localMajor{Studiengang}
    \def\@localPartner{In Kooperation mit}
    \def\@localKeywords{Stichw\"orter}
    %
    \renewcommand{\appendixtocname}{Anh\"ange}
    \renewcommand{\appendixname}{Anhang}
    \renewcommand{\appendixpagename}{Anh\"ange}
    \renewcommand{\abstractname}{Zusammenfassung}
    %    \renewcommand{\@dedicationname}{Widmung}
    %
    \ifdefstring{\@thesis}{description-bsc}{%
        \def\@ThesisName{Projektexpos\'e}
        \def\@ThesisType{student}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{description-msc}{%
        \def\@ThesisName{Projektexpos\'e}
        \def\@ThesisType{student}
        \def\@DegreeLong{Master of Science}
        \def\@DegreeShort{M.Sc.}
    }{}
    \ifdefstring{\@thesis}{ba}{%
        \def\@ThesisName{Bachelorarbeit}
        \def\@ThesisType{student}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{ma}{%
        \def\@ThesisName{Masterarbeit}
        \def\@ThesisType{student}
        \def\@DegreeLong{Master of Science}
        \def\@DegreeShort{M.Sc.}
    }{}
    \ifdefstring{\@thesis}{sa}{%
        \def\@ThesisName{Studienarbeit}
        \def\@ThesisType{student}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{da}{%
        \def\@ThesisName{Diplomarbeit}
        \def\@ThesisType{student}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{bpa}{%
        \def\@ThesisName{Bachelor Projektarbeit}
        \def\@ThesisType{stuent}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{phd}{%
        \def\@ThesisName{Dissertation}
        \def\@ThesisType{phd}
        \def\@DegreeLong{Doktor-Ingenieur}
        \def\@DegreeShort{Dr.-Ing.}
    }{}
    \ifdefstring{\@thesis}{prd}{
        \def\@ThesisName{Lastenheft}
        \def\@ThesisType{document}
        \def\@DegreeLong{}
        \def\@DegreeShort{}
    }{}
    \ifdefstring{\@thesis}{fsd}{
        \def\@ThesisName{Pflichtenheft}
        \def\@ThesisType{document}
        \def\@DegreeLong{}
        \def\@DegreeShort{}
    }{}
    \ifdefstring{\@thesis}{rep}{
        \def\@ThesisName{Report}
        \def\@ThesisType{document}
        \def\@localSubmittedBy{von}
        \def\@DegreeLong{}
        \def\@DegreeShort{}
    }{}
    \ifdefstring{\@ThesisType}{document}{%
        \def\@ThesisPretext{}
    }{%
        \def\@ThesisPretext{%
            Eine \@ThesisName\space zur Vorlage an der Fakult\"at %
            \@faculty, \@university,%
            \ifdefempty{\@DegreeLong}{}{%
                \space zur Erlangung des akademischen Grades %\\%
                {\@DegreeLong}\space (\@DegreeShort)%
            }%
        }%
    }%
    %
    \renewcommand{\DeclarationOfAuthorship}{%
        \thispagestyle{empty}%
        \foreignlanguage{ngerman}{%
    %        \vspace*{0.5cm}%
            \chapter*{Ekl\"arung des Autors}%
            \vspace{1\baselineskip}
            Hiermit versichere ich, \@author, Autor der vorliegenden \@ThesisName\space mit dem Titel%
            \vspace{1\baselineskip}
            \begin{center}
                \selectfont\sffamily
                \@title\\%
                \ifdefempty{\@subtitle}{}{
                    \vspace{0.15cm}
                    \@subtitle\\%
                }
            \end{center}
            \vspace{1\baselineskip}
            \begin{enumerate}%
                \item Dass ich meine Arbeit bzw. bei einer Gruppenarbeit den entsprechend gekennzeichneten Anteil der Arbeit selbstst\"andig verfasst habe.%
                \item Dass ich keine anderen als die angegebenen Quellen benutzt und alle w\"ortlich oder sinngem\"a\ss{} aus anderen Werken \"ubernommenen Aussagen als solche gekennzeichnet habe.%
                \item Dass die eingereichte Arbeit weder vollst\"andig noch in wesentlichen Teilen Gegenstand eines anderen Pr\"ufungsverfahrens gewesen ist.%
                \item Dass ich die Arbeit weder vollst\"andig noch in Teilen bereits ver\"offentlicht habe.%
                \item Dass das elektronische Exemplar mit den anderen Exemplaren \"ubereinstimmt.%
            \end{enumerate}%
            \vfill%\vspace{2\baselineskip}%
            %
            \begin{center}%
                \selectfont\sffamily%
                \small%
                \begin{tabu} to \linewidth {X[5,R] X[1] X[5,L]}%
                    \rule{\linewidth}{0.5pt}%
                        & \rule{\linewidth}{0pt}%
                        & \rule{\linewidth}{0.5pt}%
                        \\[-1.5ex]%
                    Autor%
                        & %
                        & Datum \\%
                \end{tabu}%
            \end{center}%
            \vfill%
            \cleardoublepage%
        }%
    }
}

% For English
\addto{\captionsenglish}{%
    \def\@localDraft{Draft}
    \def\@localExaminer{Examiner}
    \def\@localSupervisor{Supervisor}
    \def\@localLogoSuffix{-en}
    \def\@localSubmittedBy{submitted by}
    \def\@localFrom{from}
    \def\@localSubmittedOn{Submitted on}
    \def\@localMajor{Major}
    \def\@localPartner{In cooperation with}
    \def\@localKeywords{Keywords}
    %
    \renewcommand{\appendixtocname}{Appendices}
    \renewcommand{\appendixname}{Appendix}
    \renewcommand{\appendixpagename}{Appendices}
    \renewcommand{\abstractname}{Abstract}
    \renewcommand{\contentsname}{Table of Contents}
    %    \renewcommand{\@dedicationname}{Dedication}
    %
    \ifdefstring{\@thesis}{description-bsc}{%
        \def\@ThesisName{Project Description}
        \def\@ThesisType{student}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{description-msc}{%
        \def\@ThesisName{Project Description}
        \def\@ThesisType{student}
        \def\@DegreeLong{Master of Science}
        \def\@DegreeShort{M.Sc.}
    }{}
    \ifdefstring{\@thesis}{ba}{%
        \def\@ThesisName{Bachelor's Thesis}
        \def\@ThesisType{student}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{ma}{%
        \def\@ThesisName{Master's Thesis}
        \def\@ThesisType{student}
        \def\@DegreeLong{Master of Science}
        \def\@DegreeShort{M.Sc.}
    }{}
    \ifdefstring{\@thesis}{sa}{%
        \def\@ThesisName{Student Research Project}
        \def\@ThesisType{student}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{da}{%
        \def\@ThesisName{Diploma Thesis}
        \def\@ThesisType{student}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{bpa}{%
        \def\@ThesisName{Bachelor's Project Report}
        \def\@ThesisType{student}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{phd}{%
        \def\@ThesisName{Doctoral Thesis}
        \def\@ThesisType{phd}
        \def\@DegreeLong{Doktor-Ingenieur}
        \def\@DegreeShort{Dr.-Ing.}
    }{}
    \ifdefstring{\@thesis}{prd}{
        \def\@ThesisName{Product Requirements Document}
        \def\@ThesisType{document}
        \def\@DegreeLong{}
        \def\@DegreeShort{}
    }{}
    \ifdefstring{\@thesis}{fsd}{
        \def\@ThesisName{Functional Specification}
        \def\@ThesisType{document}
        \def\@DegreeLong{}
        \def\@DegreeShort{}
    }{}
    \ifdefstring{\@thesis}{rep}{
        \def\@ThesisName{Report}
        \def\@ThesisType{document}
        \def\@localSubmittedBy{by}
        \def\@DegreeLong{}
        \def\@DegreeShort{}
    }{}
    \ifdefstring{\@ThesisType}{document}{%
        \def\@ThesisPretext{}
    }{%
        \def\@ThesisPretext{A \@ThesisName\space presented to the faculty %\\%
            \@faculty, \@university,%
            \ifdefempty{\@DegreeLong}{}{%
                \space in partial fulfillment of the requirements for the degree of %\\%
                {\@DegreeLong}\space (\@DegreeShort)%
            }%
        }%
    }%
    %
    %
    \renewcommand{\DeclarationOfAuthorship}{%
        \thispagestyle{empty}%
        %        \vspace*{0.5cm}%
        \chapter*{Ekl\"arung des Autors}%
        \vspace{1\baselineskip}
        Hiermit versichere ich, \@author, Autor der vorliegenden \@ThesisName\space mit dem Titel%
        \vspace{1\baselineskip}
        \begin{center}
            \selectfont\sffamily
            \@title\\%
            \ifdefempty{\@subtitle}{}{
                \vspace{0.15cm}
                \@subtitle\\%
            }
        \end{center}
        \vspace{1\baselineskip}
        \begin{enumerate}%
            \item Dass ich meine Arbeit bzw. bei einer Gruppenarbeit den entsprechend gekennzeichneten Anteil der Arbeit selbstst\"andig verfasst habe.%
            \item Dass ich keine anderen als die angegebenen Quellen benutzt und alle w\"ortlich oder sinngem\"a\ss{} aus anderen Werken \"ubernommenen Aussagen als solche gekennzeichnet habe.%
            \item Dass die eingereichte Arbeit weder vollst\"andig noch in wesentlichen Teilen Gegenstand eines anderen Pr\"ufungsverfahrens gewesen ist.%
            \item Dass ich die Arbeit weder vollst\"andig noch in Teilen bereits ver\"offentlicht habe.%
            \item Dass das elektronische Exemplar mit den anderen Exemplaren \"ubereinstimmt.%
        \end{enumerate}%
        \vfill%\vspace{2\baselineskip}%
        %
        \begin{center}%
            \selectfont\sffamily%
            \small%
            \begin{tabu} to \linewidth {X[5,L] X[1] X[5,R]}%
                \rule{\linewidth}{0.5pt}%
                    & \rule{\linewidth}{0pt}%
                    & \rule{\linewidth}{0.5pt}%
                    \\[-1.5ex]%
                Autor%
                    & %
                    & Datum
            \end{tabu}%
        \end{center}%
        \vfill%
        \cleardoublepage%
    }
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{MainColor}{HTML}{BDBDBD}
\definecolor{MainColorLight}{HTML}{D8D8D8}
\definecolor{MainColorVeryLight}{HTML}{E6E6E6}
\definecolor{MainColorDark}{HTML}{A4A4A4}
\definecolor{MainColorVeryDark}{HTML}{848484}

\definecolor{PrimaryColor}{HTML}{004191}
\definecolor{SecondaryColor}{HTML}{00BEFF}
\colorlet{PrimaryColorVeryLight}{PrimaryColor!25}
\colorlet{PrimaryColorLight}{PrimaryColor!50}
\colorlet{PrimaryColorDark}{PrimaryColor!150}
\colorlet{PrimaryColorVeryDark}{PrimaryColor!200}
\colorlet{SecondaryColorVeryLight}{SecondaryColor!25}
\colorlet{SecondaryColorLight}{SecondaryColor!50}
\colorlet{SecondaryColorDark}{SecondaryColor!100}
\colorlet{SecondaryColorVeryDark}{SecondaryColor!200}

% And set the colors we have defined to also apply for hyperref
\hypersetup{%
    anchorcolor=MainColor, % set color of anchors 
    citebordercolor=SecondaryColor, % color of border around citation links
    citecolor=PrimaryColor, % color of citation links
    filebordercolor=SecondaryColor, %  color of border aroundfile links
    filecolor=PrimaryColor, % color of file links
    linkbordercolor=SecondaryColor, % color of border aroudn links
    linkcolor=PrimaryColor, % color of links
    menubordercolor=SecondaryColor, % color of border around menu links
    menucolor=PrimaryColor, % color for menu links
    runbordercolor=SecondaryColor, % color of border around 'run' links
    runcolor=PrimarColor, % color of 'run' links
    urlbordercolor=SecondaryColor, % color of border around URL links
    urlcolor=PrimaryColor, % color of URL links
}%

% Colors for tables
% \arrayrulecolor cannot be set in the preamble but in the document itself. That's why we are, further down, "extending" the mainmatter command to set the arrayrulecolor to Primarycolor
%\arrayrulecolor{PrimaryColor}
\colorlet{ArrayRuleColor}{PrimaryColor}
\AtBeginDocument{%
    \arrayrulecolor{ArrayRuleColor}%
}
\colorlet{TableHeader}{PrimaryColor}
\colorlet{TableRowEven}{MainColorDark!33}
\colorlet{TableRowOdd}{MainColorLight!50}
\colorlet{TableCellHighlight}{SecondaryColor}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAYOUT DEFINITION                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set counter for the section numbering
\setcounter{secnumdepth}{3}
% Set counter of what to show in the Toc and what not
\setcounter{tocdepth}{2}

% Styles for header and footer lines
\setheadtopline{0.5pt}
\setheadsepline{0.6pt}
%\renewcommand{\headrulewidth}{0.4pt}
%\renewcommand{\footrulewidth}{0.2pt}
%\renewcommand{\chaptermark}[1]{\markboth{\thechapter\space#1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\space#1}}
% Styles for header
%\fancyhead[LE]{\nouppercase{\sffamily\leftmark}}
%\fancyhead[CE]{}
%\fancyhead[RE]{}
%\fancyhead[LO]{\nouppercase{\sffamily\rightmark}}
%\fancyhead[CO]{}
%\fancyhead[RO]{}
%% Styles for footer
%\fancyfoot[LE]{\sffamily\thepage}
%\fancyfoot[CE]{}
%\fancyfoot[RE]{\sffamily\@author}
%\fancyfoot[LO]{\sffamily\@author}
%\fancyfoot[CO]{}
%\fancyfoot[RO]{\sffamily\thepage}
\lofoot{\copyright\,\the\year\space\@departmentshort, \@university}

% Make sure the ToC only shows entries down till subsubsection
\setcounter{tocdepth}{2}

% Setting or adding to some koma fonts
\setkomafont{title}{\sffamily\Huge}
\setkomafont{subtitle}{\sffamily\large}
\setkomafont{author}{\sffamily\huge}
\setkomafont{date}{\normalfont\normalsize}
\setkomafont{pageheadfoot}{\color{MainColorVeryDark}\sffamily}
\setkomafont{pagefoot}{\sffamily\small}
\newkomafont{placeofbirth}{\normalfont\normalsize}
\addtokomafont{pagenumber}{\sffamily\color{MainColorVeryDark}}
\addtokomafont{headtopline}{\color{MainColor}}
\addtokomafont{headsepline}{\color{MainColorVeryDark}}
\addtokomafont{footsepline}{\color{MainColorDark}}
\addtokomafont{footbotline}{\color{MainColorVeryDark}}
\addtokomafont{disposition}{\color{PrimaryColor}}
\addtokomafont{sectioning}{\color{PrimaryColor}}
\addtokomafont{chapter}{\normalfont\sffamily\Huge\color{PrimaryColor}}
\addtokomafont{part}{\normalfont\sffamily\Huge\color{PrimaryColor}}

%% Tables
% Stretch the padding between table rows globally
\renewcommand{\arraystretch}{1.4}
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\setlength{\belowbottomsep}{0pt}

% Set the overfullrule to 5pt if we are in thesisdraft mode
\ifdraft{
    \overfullrule=5pt
}{}

% Minitoc is not working proplery yet
%\ifbool{minitoc}{%
%    \mtcsetdepth{minitoc}{2}% ~ \setcounter{minitocdepth}{2}
%    \mtcsetfont{minitoc}{*}{\usekomafont{chapterentry}}
%    \mtcsetfont{minitoc}{section}{\usekomafont{chapterentry}\bfseries} 
%    \mtcsetfont{minitoc}{subsection}{\usekomafont{chapterentry}} 
%    \mtcsettitle{minitoc}{\relax}% remove “Contents”
%    \mtcsetoffset{minitoc}{-3.5em}% don’t know the appropriate length
%    \mtcsetrules{minitoc}{off}
%    \mtcsetpagenumbers{minitoc}{on}% default anyway
%    %\mtcsetfeature{minitoc}{before|after|open|close|pagestyle}{command} 
%}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW COMMANDS FOR TYPESETTING                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Declaring commands to set document properties
% Examiner
\newcommand{\examiner}[1]{\gdef\@examiner{#1}}
\newcommand{\@examiner}{\@latex@warning@no@line{No \noexpand\examiner given}}
% Name of the university
\newcommand{\university}[1]{\gdef\@university{#1}}
\newcommand{\@university}{\@latex@warning@no@line{No \noexpand\university given}}
% Long name of the department
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\@department}{\@latex@warning@no@line{No \noexpand\department given}}
% Short name of the department
\newcommand{\departmentshort}[1]{\gdef\@departmentshort{#1}}
\gdef\@departmentshort{}
% Address of the department
\newcommand{\departmentaddress}[1]{\gdef\@departmentAddress{#1}}
\newcommand{\@departmentAddress}{\@latex@warning@no@line{No \noexpand\departmentaddress given}}
% Student's matriculation number
\newcommand{\matriculation}[1]{\gdef\@matriculation{#1}}
\newcommand{\@matriculation}{\@latex@warning@no@line{No \noexpand\matriculation given}}
% Name of the student's supervisor(s)
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\@supervisor}{\@latex@warning@no@line{No \noexpand\supervisor given}}
% Name of the student's major
\newcommand{\major}[1]{\gdef\@major{#1}}
\newcommand{\@major}{\@latex@warning@no@line{No \noexpand\major given}}
% Name of the faculty
\newcommand{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand{\@faculty}{\@latex@warning@no@line{No \noexpand\faculty given}}
% Name of the partner
\newcommand{\partner}[1]{\gdef\@partner{#1}}
\gdef\@partner{}
% List of keywords
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\@keywords}{\@latex@warning@no@line{No \noexpand\keywords given}}
% Place of birth
\newcommand{\placeofbirth}[2]{\gdef\@placeofbirth{#1}}
\gdef\@placeofbirth{}

% Path to the university logo can be redefined using e.g., \renewcommand{\universitylogo}{logos/utrecht}
\newcommand{\universitylogo}{logo/university}
% Path to the department logo
\newcommand{\departmentlogo}{logo/department}
% Path to the partner's logo
\newcommand{\partnerlogo}{}

%%% Provide commands for easier (and more beautiful table creation)
% Set the correct order of colors for tables with a head
\newcommand{\tablecolorwithhead}{\rowcolors{1}{TableRowEven}{TableRowOdd}}
% Set the correct order of colors for tables without a head
\newcommand{\tablecolorwithouthead}{\rowcolors{1}{TableRowOdd}{TableRowEven}}
% Sets the table head row color
\newcommand{\tableheadcolor}{\rowcolor{TableHeader}}
% Command to apply styles for a table head column
\newcommand{\thead}[1]{{\color{MainColorLight}{\bfseries{#1}}}}
% Command to open a table header
\newcommand{\theadbegin}{\toprule\tableheadcolor}
% And command to close a table header
\newcommand{\theadend}{\midrule}



%%%%%%%%%%%%%%%%%%%%%%
% Titlepage creation %
\renewcommand{\maketitle}{%
    \newgeometry{inner=1cm, outer=1cm, top=1cm, bottom=1cm}%
    \begin{titlepage}%
        \thispagestyle{empty}%
        \centering%
        \vspace*{0.25cm}\par%
%        \fbox{%
            \begin{minipage}[t][1cm][c]{0.9\linewidth}%
                \centering
                \ifdefstring{\@ThesisType}{phd}{}{%
                    \huge\@ThesisName\par%
                }
            \end{minipage}\par%
%        }
        \vspace*{0.75cm}\par%
%        \fbox{%
            \begin{minipage}[t][3cm][c]{0.9\linewidth}%
                \centering%
                {\usekomafont{title}{\@title}\par}%
            \end{minipage}\par%
%        }%
        \vspace*{0.1cm}\par%
%        \fbox{%
            \begin{minipage}[t][1.5cm][c]{0.7\linewidth}%
                \centering%
                \ifdefempty{\@subtitle}{%
                    %
                }{%
                    \usekomafont{subtitle}{\@subtitle}%
                }%
            \end{minipage}\par%
%        }%
        \vspace*{1.5cm}\par%
%        \fbox{%
            \begin{minipage}[t][1.5cm][t]{0.75\linewidth}%
                \centering
                \begin{spacing}{1.25}
                    {\@ThesisPretext\par}%
                \end{spacing}
            \end{minipage}
%        }%
        \vspace*{1.5cm}\par%
%        \fbox{%
            \begin{minipage}[t][2.5cm][c]{0.8\linewidth}
                \centering%
                \@localSubmittedBy\par%
                \vspace{0.5cm}\par%
                {\usekomafont{author}{\@author}}\par%
                \vspace{0.5cm}\par%
                \ifdefempty{\@placeofbirth}{%
                    \par%
                }{%
                    \@localFrom\space{\usekomafont{placeofbirth}{\@placeofbirth}}\par%
                }%
            \end{minipage}
%        }%
        \vspace*{1cm}\par%
%        \fbox{%
            \begin{minipage}[t][1cm][c]{0.5\linewidth}
                \centering
                \ifdraft{\color{red}{\bfseries\ttfamily\Huge\@localDraft}}{}
            \end{minipage}
%        }%
        \vspace*{1cm}\par%
%        \fbox{%
            \begin{minipage}[c][3cm][c]{0.7\linewidth}%
                \ifdefstring{\@ThesisType}{document}{}{%
                    \begin{tabu} to \linewidth {X[1,l] X[4,l]}%
                    {\@localExaminer:}%
                        & \@examiner \\%
                    {\@localSupervisor:}%
                        & {\renewcommand{\and}{\par}\@supervisor} \\%
                    {\@localSubmittedOn:}%
                        & {\usekomafont{date}{\printdate{\@date}}\par}%
                    \end{tabu}%
                }%
            \end{minipage}%
%        }%
        \vfill
%        \fbox{%
            \begin{minipage}[t][1.5cm][t]{0.7\linewidth}
                \@department, \@university.
            \end{minipage}
%        }%
        \vfill
%        \fbox{%
            \begin{minipage}[t][1cm][t]{0.2\linewidth}
                \printdayoff
                \printdate{\@date}
                \printdayon
            \end{minipage}%
%        }%
    \end{titlepage}%
    \restoregeometry%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command to set front matter specific things %


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command to set main matter specific things %
\let\originalmainmatter\mainmatter%
\renewcommand{\mainmatter}{%
    \originalmainmatter%
    \arrayrulecolor{ArrayRuleColor}%
}%


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abstract of the thesis %
\newenvironment{abstract}{%
    \chapter*{\abstractname}%
    \addcontentsline{toc}{chapter}{\abstractname}%
}{%
\vfill
\textbf{\@localKeywords:} \@keywords
\iftoggle{oneside}{\clearpage}{\cleardoublepage}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dedication environment %
%\renewenvironment{dedication}{%
%    \thispagestyle{plain}
%    \chapter*{\@dedicationname}%
%%    \addcontentsline{toc}{chapter}{\dedicationname}%
%%    \vspace{\baselineskip}\vspace{\parskip}
%    \begin{RaggedRight}%
%}{%
%\end{RaggedRight}%
%\iftoggle{oneside}{\clearpage}{\cleardoublepage}%
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chapter intro environment %
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Komascript sectioning styles    %
\renewcommand*{\raggedchapter}{\RaggedLeft}
\renewcommand{\chapterlinesformat}[3]{%
    % \ifstr{str}{}{empty}{non-empty}
    \ifstr{#2}{}{}{%
        \setlength{\fboxrule}{2pt}
        \makebox[\linewidth][r]{%
            \rotatebox{90}{%
                \makebox[2cm][l]{%
                    \resizebox{2.5cm}{!}{%
                        \color{PrimaryColor}\normalfont\Large\scshape\space\chapapp\space%
                    }%
                }%
            } % Leave this white space here or the "CHAPTER" will move into the gray box
            \resizebox{!}{2.5cm}{%
                \fboxsep=6pt%
                \fontsize{85}{100}\selectfont\sffamily\color{PrimaryColor}\colorbox{MainColor!80}{\thechapter}%
            }%
        }\\*%
    }%
    \addvspace{20\p@}%
    #3%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THINGS TO RUN AT LETTER                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set the hyperref document information
\makeatletter{
    \AtBeginDocument{
        \hypersetup{
            pdfauthor={\@author},
            pdftitle={\@title},
            pdfsubject={\@ThesisPretext},
            pdfkeywords={\@keywords},
        }%
        \iflanguage{ngerman}{%
            \hypersetup{pdflang=de}%
        }{%
            \hypersetup{pdflang=en}%
        }%
        % Select the proper language
        \pagenumbering{Roman}
        \pagenumbering{arabic}
        \pagestyle{scrheadings}
    %    \addtocontents{toc}{\protect\setcounter{isw@savetocdepth}{\protect\value{tocdepth}}}
    }
\makeatother

% Reset the table row counter for even-odd coloring after every table
\makeatletter
    \preto\tabular{\global\rownum=\z@}
\makeatother



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMANDS                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%
% MATH RELATED COMMANDS %
%%%%%%%%%%%%%%%%%%%%%%%%%

% Absolute value
% \abs{x} renders |x|
\newcommand{\abs}[1]{\ensuremath{\vert {#1} \vert}}

% Norm
% \norm{a_i} renders || a_i ||_2 
% \norm[1]{a_i} renders || a_i ||_1
\newcommand{\norm}[2][2]{\ensuremath{\Vert {#2} \Vert_{#1}}}

% Power
% \pow{x} renders x^2
% \pow[3]{x} renders x^3
\newcommand{\pow}[2][2]{\ensuremath{{#2}^{#1}}}

% Partial differential
\newcommand{\pd}[1]{\partial\mspace{1mu}{#1}}

% Totial differential
\newcommand{\td}[1]{\,\mathrm{d}{#1}}

% Real value
\renewcommand{\Re}{\operatorname{Re}}

% Imaginary value
\renewcommand{\Im}{\operatorname{Im}}

% Transpose items
% \transp{A} renders A^T
\newcommand{\transp}[1]{\ensuremath{{#1}^{\mathrm{T}}}}

% Range of numbers
% \irange{m} renders i = 1, ..., m
% \irange{m}{j} renders j = 1, ..., m
% \irange[3]{m} renders i = 1, 3, ..., m
% \irange[3]{m}{j} renders j = 1, 3, ..., m
\NewDocumentCommand{\irange}{o m g}{%
    \def\runner{\IfValueTF{#3}{#3}{i}}
    \def\delta{#1}
    \def\ending{#2}
    \IfValueTF{#1}{%
        \ensuremath{\runner = 1, \delta, \ldots, \ending}
    }{%
        \ensuremath{\runner = 1, \ldots, \ending}
    }
}



%%%%%%%%%%%%%%%%%
% TEXT COMMANDS %
%%%%%%%%%%%%%%%%%
% Add tm to any trademarked thing
\newcommand{\trademark}[1]{#1\textsuperscript{\texttrademark}}
% Add the (R) to any registered thing
\newcommand{\registered}[1]{#1\textsuperscript{\textregistered}}



%%%%%%%%%%%%%%%%%%%
% FIGURE COMMANDS %
%%%%%%%%%%%%%%%%%%%
\newlength{\figurewidth}
\newlength{\figureheight}
\setlength{\figurewidth}{0.75\linewidth}
\setlength{\figureheight}{0.55\linewidth}
% Easily include a TikZ image with only three arguments
% 1) Path to the file
% 2) Width of rendered image
% 3) Height of rendered image
\newcommand{\includetikz}[3]{%
    \setlength{\figurewidth}{#2}
    \setlength{\figureheight}{#3}
    \tikzsetnextfilename{figures/#1}
    \include{figures/#1.tikz}
}



%%%%%%%%%%%%%%%%%%%%%%%%
% TYPESETTING COMMANDS %
%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\content}[1]{%
    \input{content/#1}
}

\newcommand{\demo}[1]{%
    \input{demo/#1}
}

\newcommand\crule[3][black]{\textcolor{#1}{\rule{#2}{#3}}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT THE DEPARTMENTAL INFORMATION                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\input{config/department}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DONE WITH THE CLASS DEFINITION                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput

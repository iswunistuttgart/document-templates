 % Definition of class version and last release date
\def\fileversion{0.1.3}
\def\filedate{2015/08/31}

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
\newtoggle{print}\toggletrue{print}
\DeclareOption{online}{\toggletrue{online}\togglefalse{print}}
\DeclareOption{print}{\toggletrue{print}\togglefalse{online}}

% Different thing than "draft/final"
\newbool{thesisfinal}
\DeclareOption{thesisdraft}{\boolfalse{thesisfinal}}
\DeclareOption{thesisfinal}{\booltrue{thesisfinal}}

% Declare option draft and final
\DeclareOption{draft}{\setlength{\overfullrule}{5pt}}
\DeclareOption{final}{\booltrue{thesisfinal}}

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
\DeclareOption{bachelor}{\def\@thesis{ba}}
\DeclareOption{master}{\def\@thesis{ma}}
\DeclareOption{study}{\def\@thesis{sa}}
\DeclareOption{diplom}{\def\@thesis{da}}
\DeclareOption{bachelorproject}{\def\@thesis{bpa}}
\DeclareOption{doctorate}{\def\@thesis{phd}}
\DeclareOption{phd}{\def\@thesis{phd}}
\DeclareOption{report}{\def\@thesis{rep}}

% Pass any other options not known to the scrreprt package
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}

% Default options
\ExecuteOptions{bachelor,language=english,a4paper,twoside=true,open=right,thesisdraft}

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
}{scrreprt}

% Options to scrlayer-scrpage
\PassOptionsToPackage{
    automark, % 
    headsepline=0.4pt, %
    headtopline=0.6pt, %
    footsepline=0.4pt, %
}{scrlayer-scrpage}

% Default options to the geometry paackage
\PassOptionsToPackage{%
%    showframe, % We are using 'showframe' only for typesetting the layout, it is not needed for the actual class
    paper=a4paper,
    marginparwidth=2.5cm,
    top=3cm,
    bottom=4cm,
    outer=3.5cm,
    inner=2.5cm,
}{geometry}

% Depending on online we will define options to hyperref
\iftoggle{online}{%
    % Online options
    \PassOptionsToPackage{%
        anchorcolor=blue,%
        bookmarksopen=true,%
        colorlinks=true,%
        urlcolor=blue,%
    }{hyperref}
    % Print options
}{%
    \PassOptionsToPackage{%
        hidelinks=true,%
    }{hyperref}
}

% Pass option final or draft to hyperref depending on thesisfinal
\ifbool{thesisfinal}{
    \PassOptionsToPackage{final}{hyperref}
}{
    \PassOptionsToPackage{draft}{hyperref}
}

% Configuration of hyperref
\PassOptionsToPackage{%
    % Lesezeichen erzeugen
    bookmarks=true,
    % Lesezeichen ausgeklappt
    bookmarksopen=false,
    % Level bis zu welchen Bookmarks geofffnet sind
    bookmarksopenlevel=1,
    % Anzeige der Kapitelzahlen am Anfang der Namen der Lesezeichen
    bookmarksnumbered=true,
    % Seite, welche automatisch geoeffnet werden soll
    % praktisch, wenn z.B. im Inhaltsverzeichnis gestartet
    % werden soll oder eine Seite bearbeitet wird.
    pdfstartpage=1,
%   % Miniaturansicht nicht anzeigen
    pdfpagemode=UseOutlines,
    % Startansicht des PDF-Dokuments
    pdfstartview=Fit,
    % URL des PDF-Dokuments (oder Hintergrundinformationen)
    baseurl={http://www.isw.uni-stuttgart.de/},
    % Display document title instead of file name in title bar
    pdfdisplaydoctitle=true,
    % Setzt die StandardAnsicht fuer das Dokument auf
    % TwoColumnRight: Zweiseitig,Fortlaufen,mit Cover-Up-Page
    % TwoColumnLeft: Zweiseitig,Fortlaufen,ohne Cover-Up-Page
    pdfpagelayout=TwoColumnRight,
%    pdfhighlight=/N,
    % ermoeglicht einen Umbruch von URLs
    breaklinks=true,
}{hyperref}

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

% Only few configuration options to cleverref
\PassOptionsToPackage{
    capitalise
}{cleverref}

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
\ifbool{thesisfinal}{%
    \PassOptionsToPackage{final}{minted}
}{
    \PassOptionsToPackage{draft}{minted}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOAD ALL PACKAGES NECESSARY FOR SETTING UP THE CLASS                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the scrreprt class
\LoadClass{scrreprt}

% Load the language class
\PassOptionsToPackage{english,ngerman}{babel}
\RequirePackage{babel}

%
\RequirePackage{scrlayer-scrpage}


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
\numberwithin{equation}{chapter}

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

% The package has a lot of flexibility, including an option for specifying an entry at the “natural” width of its text.
% The package is distributed with the bigdelim and bigstrut packages, which can be used to advantage with \multirow cells.
\RequirePackage{multirow}

%
\RequirePackage{fncychap}

% The package starts from the basic facilities of the color package, and provides easy driver-independent access to several kinds of color tints, shades, tones, and mixes of arbitrary colors. It allows a user to select a document-wide target color model and offers complete tools for conversion between eight color models. Additionally, there is a command for alternating row colors plus repeated non-aligned material (like horizontal lines) in tables. Colors can be mixed like \color{red!30!green!40!blue}.
\RequirePackage{xcolor}
% Defines the 16 colors from Ethan Schoonover's Solarized palette
\RequirePackage{xcolor-solarized}

%
\RequirePackage{setspace}

% The bm package defines a command \bm which makes its argument bold. The argument may be any maths object from a single symbol to an expression. This is closely related to the specification of the \boldsymbol command in AMS-LaTeX, but \bm is rather more careful in the way it does things. 
\RequirePackage{bm}

% The package is intended for setting rich text into titling capitals (in which the first character of words are capitalized). It automatically accounts for diacritical marks (like umlauts), national symbols (like “ae”), punctuation, and font changing commands that alter the appearance or size of the text. It allows a list of predesignated words to be protected as lower-cased, and also allows for titling exceptions of various sorts.
\RequirePackage{titlecaps}
\Addlcwords{the,a,an,and,but,for,or,nor,to,}

% The package enhances the quality of tables in LaTeX, providing extra commands as well as behind-the-scenes optimisation. Guidelines are given as to what constitutes a good table in this context. From version 1.61, the package offers longtable compatibility.
\RequirePackage{booktabs}

% Intermix single and multiple columns. Multicol defines a multicols environment which typesets text in multiple columns (up to a maximum of 10), and (by default) balances the end of each column at the end of the environment. The package enables you to switch between any (permitted) number of columns at will: there is no imposed "clear page" operation, as there is in unadorned LaTeX at a switch between \onecolumn and \twocolumn sections. The multicolumn environment can also be used inside a box, thus allowing multicolumned insets in text. Multicol patches the output routine, and may clash with other packages that do the same (e.g., longtable); furthermore, there is no provision for single column floats inside a multicolumn environment, so figures and tables must be coded in-line (using, for example, the H modifier of the float package). The package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{multicol}

% The package defines new commands \Centering, \RaggedLeft, and \RaggedRight and new environments Center, FlushLeft, and FlushRight, which set ragged text and are easily configurable to allow hyphenation (the corresponding commands in LaTeX, all of whose names are lower-case, prevent hyphenation altogether).
\RequirePackage{ragged2e}

% Longtable allows you to write tables that continue to the next page. You can write captions within the table (typically at the start of the table), and headers and trailers for pages of table. Longtable arranges that the columns on successive pages have the same widths. This last contrasts with the superficially similar supertabular package.
% Longtable (unlike supertabular) modifies the output routine, and consequently won't work in a multicolumn environment (or in other circumstances where the output routine has been critically altered); it also fails in twocolumn pages.
% This package is part of the tools bundle in the LaTeX required distribution.
\RequirePackage{longtable}

% The package allows rows and columns to be coloured, and even individual cells.
\RequirePackage{colortbl}

% Typeset in-line fractions in a "nice" way. The package typesets fractions “nicely” — in the form ‘a/b’ (i.e., staggered with a slash between them, rather than directly one over the other). The package is distributed as part of a bundle including the units package. Nicefrac’s facilities are provided, in a cleaner way, by the (experimental) xfrac package, but see also the faktor package for quotient spaces and the like.
\RequirePackage{nicefrac}

% Place lines through maths formulae. A package to draw diagonal lines (“cancelling” a term) and arrows with limits (cancelling a term “to a value”) through parts of maths formulae.
\RequirePackage{cancel}

% A comprehensive (SI) units package. Typesetting values with units requires care to ensure that the combined mathematical meaning of the value plus unit combination is clear. In particular, the SI units system lays down a consistent set of units with rules on how they are to be used. However, different countries and publishers have differing conventions on the exact appearance of numbers (and units). A number of LaTeX packages have been developed to provide consistent application of the various rules: SIunits, sistyle, unitsdef and units are the leading examples. The numprint package provides a large number of number-related functions, while dcolumn and rccol provide tools for typesetting tabular numbers. The siunitx package takes the best from the existing packages, and adds new features and a consistent interface. A number of new ideas have been incorporated, to fill gaps in the existing provision. The package also provides backward-compatibility with SIunits, sistyle, unitsdef and units. The aim is to have one package to handle all of the possible unit-related needs of LaTeX users. The package relies on LaTeX 3 support from the l3kernel and l3packages bundles.
\RequirePackage[per-mode=symbol]{siunitx}

% Typeset source code listings using LaTeX. The package enables the user to typeset programs (programming code) within LaTeX; the source code is read directly by TeX—no front-end processor is needed. Keywords, comments and strings can be typeset using different styles (default is bold for keywords, italic for comments and no special style for strings). Support for hyperref is provided. To use, \usepackage{listings}, identify the language of the object to typeset, using a construct like: \lstset{language=Python}, then use environment lstlisting for inline code. External files may be formatted using \lstinputlisting to process a given file in the form appropriate for the current language. Short (in-line) listings are also available, using either \lstinline|...| or |...| (after defining the | token with the \lstMakeShortInline command).
\ifbool{minted}{}{%
    \RequirePackage{listings}
    \lstset{
        numbers=left,
        numberstyle=\tiny,
        stepnumber=2,
        numbersep=5pt,
        frame=leftline,
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
    font={},
    labelfont={footnotesize, sc},
    textfont={sl},
}
%%% Setup captions of tables
\captionsetup[table]{
    position=above
}
%%% Setup captions of figures
\captionsetup[figure]{
    position=below
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

% Control layout of itemize, enumerate, description. This package provides user control over the layout of the three basic list environments: enumerate, itemize and description. It supersedes both enumerate and mdwlist (providing well-structured replacements for all their funtionality), and in addition provides functions to compute the layout of labels, and to ‘clone’ the standard environments, to create new environments with counters of their own.
\RequirePackage{enumitem}

% Typesetting theorems (AMS style). The package facilitates the kind of theorem setup typically needed in American Mathematical Society publications. The package offers the theorem setup of the AMS document classes (amsart, amsbook, etc.) encapsulated in LaTeX package form so that it can be used with other document classes. Amsthm is part of the (required) AMS-LaTeX distribution, so should be present in any LaTeX distribution.
\RequirePackage{amsthm}

% A simple type of box for LaTeX. This small package provides a convenient input syntax for boxes that don't break their text over lines automatically, but do allow manual line breaks. The boxes shrink to the natural width of the longest line they contain
\RequirePackage{minibox}

% Generate English ordinal numbers. The command \nth{<number>} generates English ordinal numbers of the form 1st, 2nd, 3rd, 4th, etc. LaTeX package options may specify that the ordinal mark be superscripted, and that negative numbers may be treated; Plain TeX users have no access to package options, so need to redefine macros for these changes.
\RequirePackage[super]{nth}

% Show label, ref, cite and bib keys. The showkeys package modifies the \label, \ref, \pageref, \cite and \bibitem commands so that the ‘internal’ key is printed, without affecting the appearance of the rest of the text, so far as is possible (the keys typically appear in the margin). The package is part of the tools bundle in the LaTeX required distribution.
\ifbool{thesisfinal}{}{\RequirePackage{showkeys}}

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

% The Euro­pean cur­rency sym­bol for the Euro im­ple­mented in METAFONT, us­ing the of­fi­cial Euro­pean Com­mis­sion di­men­sions, and pro­vid­ing sev­eral shapes (nor­mal, slanted, bold, out­line). The pack­age also in­cludes a LaTeX pack­age which de­fines the macro, pre-com­piled tfm files, and doc­u­men­ta­tion.
\usepackage[gen]{eurosym}

% Intelligent cross-referencing. The package enhances LaTeX's cross-referencing features, allowing the format of references to be determined automatically according to the type of reference. The formats used may be customised in the preamble of a document; babel support is available (though the choice of languages remains limited: currently Danish, Dutch, English, French, German, Italian, Norwegian, Russian, Spanish and Ukranian). The package also offers a means of referencing a list of references, each formatted according to its type. In such lists, it can collapse sequences of numerically-consecutive labels to a reference range.
\RequirePackage{cleveref}

% Create glossaries and lists of acronyms. The glossaries package supports acronyms and multiple glossaries, and has provision for operation in several languages (using the facilities of either babel or polyglossia). New entries are defined to have a name and description (and optionally an associated symbol). Support for multiple languages is offered, and plural forms of terms may be specified. An additional package, glossaries-accsupp, can make use of the accsupp package mechanisms for accessibility support for PDF files containing glossaries. The user may define new glossary styles, and preambles and postambles can be specified. There is provision for loading a database of terms, but only terms used in the text will be added to the relevant glossary. The package uses an indexing program to provide the actual glossary; either makeindex or xindy may serve this purpose, and a Perl script is provided to serve as interface. The package distribution also provides the mfirstuc package, for changing the first letter of a word to upper case. The package supersedes the author’s glossary package (which is now obsolete), and a conversion tool is provided.
\RequirePackage{glossaries}

%
\RequirePackage{hyperref}

%
%\ifbool{minitoc}{\RequirePackage[]{minitoc}}{}

% Some packages from other authors may have problems with KOMA-Script. In my opinion some packages could be im- proved. With some packages this makes only sense, if KOMA- Script was used. With some other packages the package author has another opinion. Sometimes proposals was never answered. Package scrhack contains all those improvement proposals for other packages. This means, scrhack redefines macros of pack- ages from other authors! The redefinitions are only activated, if those packages were loaded. Users may prevent scrhack from redefining macros of individual packages.
\RequirePackage{scrhack}

% Set the language as defined in the language option to the class
\AtBeginDocument{
    \expandafter\selectlanguage\expandafter{\@thesisLanguage}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOCALIZATION AND INTERNATIONALIZATION                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For German
\addto{\captionsngerman}{%
    \def\@localDraft{Entwurf}
    \def\@localExaminer{Pr\"ufer}
    \def\@localSupervisor{Betreuer}
    \def\@localLogoSuffix{-deutsch}
    \def\@localSubmittedBy{eingereicht von}
    \def\@localSubmittedOn{am}
    \def\@localMajor{Studiengang}
    \def\@localPartner{In Kooperation mit}
    \def\@localKeywords{Stichw\"orter}
    %
    \renewcommand{\abstractname}{Zusammenfassung}
    %    \renewcommand{\@dedicationname}{Widmung}
    %
    \ifdefstring{\@thesis}{ba}{%
        \def\@ThesisName{Bachelorarbeit}
        \def\@ThesisType{Bachelorarbeit}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{ma}{%
        \def\@ThesisName{Masterarbeit}
        \def\@ThesisType{Masterarbeit}
        \def\@DegreeLong{Master of Science}
        \def\@DegreeShort{M.Sc.}
    }{}
    \ifdefstring{\@thesis}{sa}{%
        \def\@ThesisName{Studienarbeit}
        \def\@ThesisType{Studienarbeit}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{da}{%
        \def\@ThesisName{Diplomarbeit}
        \def\@ThesisType{Diplomarbeit}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{bpa}{%
        \def\@ThesisName{Bachelor Projektarbeit}
        \def\@ThesisType{Bachelor Projektarbeit}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{phd}{%
        \def\@ThesisName{Dissertation}
        \def\@ThesisType{Dissertation}
        \def\@DegreeLong{Doktoringenieur}
        \def\@DegreeShort{Dr.-Ing.}
    }{}
    \def\@ThesisPretext{Eine \@ThesisType\space zur Vorlage an der Fakult\"at\\%
        {\scshape\@faculty}\\%
        {\scshape\@university}\\%
        zur Erlangung des akademischen Grades\\%
        {\scshape\@DegreeLong}\space (\@DegreeShort)}
}

% For English
\addto{\captionsenglish}{%
    \def\@localDraft{Draft}
    \def\@localExaminer{Examiner}
    \def\@localSupervisor{Supervisor}
    \def\@localLogoSuffix{-english}
    \def\@localSubmittedBy{submitted by}
    \def\@localSubmittedOn{on}
    \def\@localMajor{Major}
    \def\@localPartner{In cooperation with}
    \def\@localKeywords{Keywords}
    %
    \renewcommand{\abstractname}{Abstract}
    %    \renewcommand{\@dedicationname}{Dedication}
    %
    \ifdefstring{\@thesis}{ba}{%
        \def\@ThesisName{Bachelor's Thesis}
        \def\@ThesisType{bachelor's thesis}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{ma}{%
        \def\@ThesisName{Master's Thesis}
        \def\@ThesisType{master's thesis}
        \def\@DegreeLong{Master of Science}
        \def\@DegreeShort{M.Sc.}
    }{}
    \ifdefstring{\@thesis}{sa}{%
        \def\@ThesisName{Student Research Project}
        \def\@ThesisType{student research project}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{da}{%
        \def\@ThesisName{Diploma Thesis}
        \def\@ThesisType{diploma thesis}
        \def\@DegreeLong{Diplomingenieur}
        \def\@DegreeShort{Dipl.-Ing.}
    }{}
    \ifdefstring{\@thesis}{bpa}{%
        \def\@ThesisName{Bachelor's Project Report}
        \def\@ThesisType{bachelor project report}
        \def\@DegreeLong{Bachelor of Science}
        \def\@DegreeShort{B.Sc.}
    }{}
    \ifdefstring{\@thesis}{phd}{%
        \def\@ThesisName{Dissertation}
        \def\@ThesisType{dissertation}
        \def\@DegreeLong{Doktoringenieur}
        \def\@DegreeShort{Dr.-Ing.}
    }{}
    \def\@ThesisPretext{A \@ThesisType\space presented to the faculty\\%
        {\scshape\@faculty}\\%
        {\scshape\@university}\\%
        in partial fulfillment of the requirements for the degree of\\%
        {\scshape\@DegreeLong}\space (\@DegreeShort)}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\colorlet{VVLGray}{Gray!10}
%\definecolor{VLGray}{gray}{0.8}
\colorlet{VLGray}{Gray!20}
%\definecolor{LGray}{gray}{0.6}
\colorlet{LGray}{Gray!40}
%\definecolor{MGray}{gray}{0.5}
\colorlet{MGray}{Gray!50}
%\definecolor{DGray}{gray}{0.4}
\colorlet{DGray}{Gray!60}
%\definecolor{VDGray}{gray}{0.2}
\colorlet{VDGray}{Gray!80}
\colorlet{VVDGray}{Gray!90}

% Main colors of the department and university
\definecolor{department-main}{HTML}{D33035}
\definecolor{department-sub}{HTML}{0076BD}
\definecolor{uni-main}{HTML}{768A9D}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAYOUT DEFINITION                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set counter for the section numbering
\setcounter{secnumdepth}{3}
% Set counter of what to show in the Toc and what not
\setcounter{tocdepth}{2}

% Styles for the header and footer lines
%\renewcommand{\headrulewidth}{0.4pt}
%\renewcommand{\footrulewidth}{0.2pt}
%\renewcommand{\chaptermark}[1]{\markboth{\thechapter\space#1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\space#1}}
% Styles for the header
%\fancyhead[LE]{\nouppercase{\sffamily\leftmark}}
%\fancyhead[CE]{}
%\fancyhead[RE]{}
%\fancyhead[LO]{\nouppercase{\sffamily\rightmark}}
%\fancyhead[CO]{}
%\fancyhead[RO]{}
%% Styles for the footer
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
\setkomafont{title}{\bfseries\LARGE}
\setkomafont{subtitle}{\slshape\large}
\setkomafont{author}{\sffamily\LARGE}
\setkomafont{pageheadfoot}{\color{VVDGray}\sffamily}
\setkomafont{pagefoot}{\sffamily\small}
\addtokomafont{pagenumber}{\sffamily\color{VVDGray}}
\addtokomafont{headtopline}{\color{VDGray}}
\addtokomafont{headsepline}{\color{MGray}}
\addtokomafont{footsepline}{\color{DGray}}
\addtokomafont{footbotline}{\color{VDGray}}
\addtokomafont{chapter}{\normalfont\sffamily\Huge}
\addtokomafont{part}{\normalfont\sffamily\Huge}

% Color all rules in tables with very dark gray
\arrayrulecolor{VDGray}

% Set the overfullrule to 5pt if we are in thesisdraft mode
\ifbool{thesisfinal}{}{%
    \overfullrule=5pt
}

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
\newcommand{\departmentlong}[1]{\gdef\@departmentlong{#1}}
\newcommand{\@departmentlong}{\@latex@warning@no@line{No \noexpand\departmentlong given}}
% Short name of the department
\newcommand{\departmentshort}[1]{\gdef\@departmentshort{#1}}
\newcommand{\@departmentshort}{}
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


% Path to the university logo can be redefined using e.g., \renewcommand{\universitylogo}{logos/utrecht}
\newcommand{\universitylogo}{logo/university}
% Path to the department logo
\newcommand{\departmentlogo}{logo/department}
% Path to the partner's logo
\newcommand{\partnerlogo}{}

%%%%%%%%%%%%%%%%%%%%%%
% Titlepage creation %
\renewcommand{\maketitle}{%
    \newgeometry{inner=2cm, outer=2cm, top=1.5cm, bottom=1.5cm}
    \begin{titlepage}
        \thispagestyle{empty}%
        % University Logo
        \begin{minipage}{0.49\linewidth}%
            \raggedright
            \includegraphics[width=\linewidth, height=1.25cm, keepaspectratio]{\expandafter\universitylogo\@localLogoSuffix\expandafter}%
        \end{minipage}\hfill%
        % Partner logo, if given
        \ifdefempty{\partnerlogo}{}{%
            \begin{minipage}{0.49\linewidth}%
                \raggedleft%
                \includegraphics[width=\linewidth, height=1.25cm, keepaspectratio]{\expandafter\partnerlogo\@localLogoSuffix\expandafter}%
            \end{minipage}%
        }\par%
        \centering%
        \vspace*{0.5cm}\par%
        % THESIS TYPE
        {\Large\sffamily\@ThesisName\par}%
        %
        % TITLE (and possibly subtitle)
        \vspace*{0.75cm}\par%
        \begin{minipage}[t][3.25cm][t]{\linewidth}%
            \centering%
            % TITLE
            {\usekomafont{title}{\@title\par}}%
            \vspace*{0.33cm}%
            % Possibly subtitle
            {\ifdefempty{\@subtitle}{}{\usekomafont{subtitle}{\@subtitle\par}}}%
        \end{minipage}\par%
        %
        \vspace*{1.5cm}\par%
        % AUTHOR
        \begin{minipage}[t][2cm][t]{\linewidth}
            \centering%
            {\small\@localSubmittedBy\par}%
%            \vspace*{0.25cm}%
            {\usekomafont{author}{\@author\par}}%
            \vspace*{0.25cm}%
            {\sffamily\@matriculation}%
        \end{minipage}\par%
        % DATE
        \vspace*{0.5cm}%
        \begin{minipage}[t][0.5cm][t]{\linewidth}
            \centering%
            \@localSubmittedOn\par
            {\usekomafont{date}\printdate{\@date}\par}%
        \end{minipage}\par
        %
        \vspace*{1cm}
        % DRAFT or not
        \begin{minipage}[t][0.5cm][t]{\linewidth}%
            \centering
            \ifbool{thesisfinal}{}{\color{red}{\bfseries\ttfamily\Huge\@localDraft}}
        \end{minipage}\par
        \vspace*{1cm}
        % Block for thesis pretext i.e., "a ... submitted in partial fulfillment of ..."
        \begin{minipage}[t][2.5cm][t]{\linewidth}%
            \begin{spacing}{1.33}
            \centering%
            {\small\@ThesisPretext\par}%
            \end{spacing}
        \end{minipage}\par%
        %
        \vspace*{2.5cm}%
        % EXAMINER, ADVISOR, GRADUATE PROGRAM, etc.
        \begin{minipage}[t][3.5cm][t]{\linewidth}%
            \begin{minipage}[t]{0.49\linewidth}%
                \raggedright
                % EXAMINER
                {\sffamily\itshape\@localExaminer:}\par%
                    \@examiner\par%
                \vspace*{0.5cm}%
                % SUPERVISOR
                {\sffamily\itshape\@localSupervisor:}\par%
                    \renewcommand{\and}{\par}%
                    \@supervisor\par%
            \end{minipage}%
            \hfill%
            \begin{minipage}[t]{0.49\linewidth}%
                % MAJOR
                \raggedleft
                {\sffamily\itshape\@localMajor:}\par%
                \@major\par%
                \vspace*{0.5cm}
                % PARTNER
                %
                \ifdefempty{\@partner}{}{%
                    {\sffamily\itshape\@localPartner:}\par%
                    \@partner\par%
                }
                %{}
            \end{minipage}%
        \end{minipage}\par%
        %
        \vfill%
        {%
            \begin{minipage}[b]{0.79\linewidth}%
                \@departmentlong\\
                \@departmentAddress
            \end{minipage}%
            \hfill%
            \begin{minipage}[b]{0.19\linewidth}%
                \raggedleft
                \includegraphics[height=1.5cm,keepaspectratio]{\departmentlogo\@localLogoSuffix}
            \end{minipage}%
        }%
    \end{titlepage}
    \restoregeometry
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command to set front matter specific things %
\newcommand{\frontmatter}{%
    \iftoggle{oneside}{\clearpage}{\cleardoublepage}%
    \pagenumbering{Roman}%
    \pagestyle{plain}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command to set main matter specific things %
\newcommand{\mainmatter}{%
    \iftoggle{oneside}{\clearpage}{\cleardoublepage}%
    \pagenumbering{arabic}%
    \pagestyle{scrheadings}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abstract of the thesis %
\newenvironment{thesisabstract}{%
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code for fancy chapters heading %
\makeatletter
\ChNameVar{\color{VDGray}\normalfont\Large\scshape} % sets the style for name
\ChNumVar{\fontsize{85}{100}\selectfont\sffamily\color{white}}
\ChTitleVar{\usekomafont{chapter}\raggedleft}
\ChRuleWidth{2pt}
\ChNameAsIs
\renewcommand{\DOCH}{%
    \setlength{\fboxrule}{\RW}
    \makebox[\linewidth][r]{
        \rotatebox{90}{
            \makebox[2cm][l]{
                \resizebox{2.5cm}{!}{
                    \CNV\FmN{\space\@chapapp}\space
                }
            }
        }
        \resizebox{!}{2.5cm}{\fboxsep=6pt
            \CNoV\colorbox{LGray}{\thechapter}
        }
    }%
    \par\nobreak
    \vskip 40\p@
}
\renewcommand{\DOTI}[1]{%
    \CTV\FmTi{#1}\par\nobreak
    \vskip 40\p@}
\renewcommand{\DOTIS}[1]{%
    \CTV\FmTi{#1}\par\nobreak
    \vskip -20\p@}
\makeatother



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THINGS TO RUN AT THE BEGINNING OF THE DOCUMENT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% At the beginning of the document...
\makeatletter{
    \AtBeginDocument{
        \hypersetup{
            pdfauthor={\@author},
            pdftitle={\@title},
            pdfsubject={\@ThesisPretext},
            pdfkeywords={\@keywords},
        }
        % Select the proper language
        \pagenumbering{Roman}
        \pagenumbering{arabic}
        \pagestyle{scrheadings}
    %    \addtocontents{toc}{\protect\setcounter{isw@savetocdepth}{\protect\value{tocdepth}}}
    }
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT THE DEPARTMENTAL INFORMATION                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\input{config/department}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DONE WITH THE CLASS DEFINITION                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput
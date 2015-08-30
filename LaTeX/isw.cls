% Definition of class version and last release date
\def\fileversion{0.1.0}
\def\filedate{2015/08/28}

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

% Detect "draft" and "final" class options
\RequirePackage{ifdraft}

% Process 'key=value' schemes
\RequirePackage{xkeyval}

\RequirePackage{xparse}


% Provide exclusive option pair "online/print" to allow for setting different color values in e.g., hyperref for online and print publication
\newtoggle{online}\togglefalse{online}
\newtoggle{print}\toggletrue{print}
\DeclareOption{online}{\toggletrue{online}\togglefalse{print}}
\DeclareOption{print}{\toggletrue{print}\togglefalse{online}}

% Declare option draft and final
\DeclareOption{draft}{\setlength{\overfullrule}{5pt}}
\DeclareOption{final}{}

% Different thing than "draft/final"
\newbool{thesisfinal}
\DeclareOption{thesisdraft}{\boolfalse{thesisfinal}}
\DeclareOption{thesisfinal}{\booltrue{thesisfinal}}

% Allow user to choose whether they want a mini-toc at the beginning of every chapter
%\newbool{minitoc}
%\DeclareOption{minitoc}{\booltrue{minitoc}}

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

% Pass any other options not known to the scrreprt package
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}

% Default options
\ExecuteOptions{bachelor,language=english,a4paper,twoside=true,open=right,thesisdraft}

% Process options (finally)
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE DEFAULT OPTIONS PASSED TO CLASSES AND PACKGES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Default options to the scrreprt class (the main class of this class)
\PassOptionsToClass{%
%    fontsize=11pt, % Obvious option, eh? Fontsize may only be between 10pt...12pt
    parskip=half*, % half a line vertical space between paragraphs; there must be at least 1 em free space in the last line of a paragraph
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOAD ALL PACKAGES NECESSARY FOR SETTING UP THE CLASS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the scrreprt class
\LoadClass{scrreprt}

% Load the language class
\PassOptionsToPackage{english,ngerman}{babel}
\RequirePackage{babel}

\RequirePackage{scrlayer-scrpage}

% Load the isodate class
\PassOptionsToPackage{english,ngerman}{isodate}
\RequirePackage{isodate}
\daymonthsepgerman{}%
\monthyearsepgerman{}{}%

\PassOptionsToPackage{english,ngerman}{todonotes}

% Latin modern font package
\RequirePackage{lmodern}

% Set the language as defined in the language option to the class
\AtBeginDocument{
    \expandafter\selectlanguage\expandafter{\@thesisLanguage}
}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

\RequirePackage{setspace}

\RequirePackage{geometry}

% Include Encapsulated PostScript in LaTeX documents
\RequirePackage{epsfig}

\RequirePackage{graphicx}
\graphicspath{{figures/}{images/}}

\RequirePackage{multirow}

%\RequirePackage{fancyhdr}

\RequirePackage{fncychap}

\RequirePackage{xcolor}

\RequirePackage{hyperref}

%\ifbool{minitoc}{\RequirePackage[]{minitoc}}{}

% Some packages from other authors may have problems with KOMA-Script. In my opinion some packages could be im- proved. With some packages this makes only sense, if KOMA- Script was used. With some other packages the package author has another opinion. Sometimes proposals was never answered. Package scrhack contains all those improvement proposals for other packages. This means, scrhack redefines macros of pack- ages from other authors! The redefinitions are only activated, if those packages were loaded. Users may prevent scrhack from redefining macros of individual packages.
\RequirePackage{scrhack}

%\input{config/packages}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOCALIZATION and INTERNATIONALIZATION %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    \def\@ThesisPretext{Eine \@ThesisType\space zur Vorlage an der Fakult\"at \@faculty\space der \@university\space zur Erlangung des akademischen Grades \@DegreeLong\space (\@DegreeShort)}
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
    \def\@ThesisPretext{A \@ThesisType\space submitted to the faculty \@faculty\space of \@university\space in partial fulfilment of the requirements for the degree of \@DegreeLong\space (\@DegreeShort)}
}



%%%%%%%%%%%%%%%%%%%%%
% COLOR DEFINITIONS %
%%%%%%%%%%%%%%%%%%%%%

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



%%%%%%%%%%%%%%%%%%%%%%
% LAYOUT DEFINITIONS %
%%%%%%%%%%%%%%%%%%%%%%

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
\setkomafont{title}{\bfseries\Huge}
\setkomafont{subtitle}{\slshape\Large}
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW COMMANDS OR RENEWED COMMANDS FOR TYPESETTING %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The command to create our beautiful titlepage
\renewcommand{\maketitle}{%
    \newgeometry{margin=2cm}
    \begin{titlepage}
        \thispagestyle{empty}%
        \centering%
        % University Logo
        \begin{minipage}{0.49\linewidth}%
            \ifdefempty{\partnerlogo}{\centering}{\raggedright}%
            \includegraphics[width=\linewidth, height=1.5cm, keepaspectratio]{\expandafter\universitylogo\@localLogoSuffix\expandafter}%
        \end{minipage}\hfill%
        % Partner logo, if given
        \ifdefempty{\partnerlogo}{}{%
            \begin{minipage}{0.49\linewidth}%
                \raggedleft%
                \includegraphics[width=\linewidth, height=1.5cm, keepaspectratio]{\expandafter\partnerlogo\@localLogoSuffix\expandafter}%
            \end{minipage}%
        }\par%
        \vspace*{0.5cm}\par%
        % THESIS TYPE
        {\huge\sffamily\@ThesisName\par}%
        %
        % TITLE (and possibly subtitle)
        \vspace*{0.75cm}\par%
        \begin{minipage}[t][3.5cm][t]{\linewidth}%
            \centering%
            % TITLE
            {\usekomafont{title}{\huge\@title\par}}%
            \vspace*{0.33cm}%
            % Possibly subtitle
            {\ifdefempty{\@subtitle}{}{\usekomafont{subtitle}{\@subtitle\par}}}%
        \end{minipage}\par%
        %
        \vspace*{1cm}\par%
        % AUTHOR
        \begin{minipage}[t][2cm][t]{\linewidth}
            \centering%
            {\small\@localSubmittedBy\par}%
%            \vspace*{0.25cm}%
            {\usekomafont{author}{\@author\par}}%
            \vspace*{0.25cm}%
            {\sffamily\@matriculation}%
        \end{minipage}\par
        % DATE
        \vspace*{0.25cm}%
        \begin{minipage}[t][0.5cm][t]{\linewidth}
            \centering%
            \@localSubmittedOn\par
            {\usekomafont{date}\printdate{\@date}\par}%
        \end{minipage}\par
        %
        \vspace*{1.25cm}
        % DRAFT or not
        \begin{minipage}[t][0.75cm][t]{\linewidth}%
            \centering
            \ifbool{thesisfinal}{}{\color{red}{\bfseries\ttfamily\Huge\@localDraft}}
        \end{minipage}\par
        \vspace*{1.25cm}
        % Block for thesis pretext i.e., "a ... submitted in partial fulfillment of ..."
        \begin{minipage}[t][2cm][t]{\linewidth}%
            \centering%
            {\small\@ThesisPretext\par}%
        \end{minipage}\par%
        %
        \vspace*{1.5cm}%
        % EXAMINER, ADVISOR, GRADUATE PROGRAM, etc.
        \begin{minipage}[t][4cm][t]{\linewidth}%
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
                \includegraphics[height=2cm,keepaspectratio]{\departmentlogo\@localLogoSuffix}
            \end{minipage}%
        }%
    \end{titlepage}
    \restoregeometry
}

%%%%%%%%%%
% Command to set front matter specific things
%%%%%%%%%%
\newcommand{\frontmatter}{%
    \iftoggle{oneside}{\clearpage}{\cleardoublepage}%
    \pagenumbering{Roman}%
    \pagestyle{plain}%
}

%%%%%%%%%%
% Command to set main matter specific things
%%%%%%%%%%
\newcommand{\mainmatter}{%
    \iftoggle{oneside}{\clearpage}{\cleardoublepage}%
    \pagenumbering{arabic}%
    \pagestyle{scrheadings}
}


%%%%%%%%%%%
%% Abstract of the thesis
%%%%%%%%%%%
\newenvironment{thesisabstract}{%
    \chapter*{\abstractname}%
    \addcontentsline{toc}{chapter}{\abstractname}%
}{%
\vfill
\textbf{\@localKeywords:} \@keywords
\iftoggle{oneside}{\clearpage}{\cleardoublepage}%
}

%%%%%%%%%%%
%% Dedication environment
%%%%%%%%%%%
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


%%%%%%%%%%%
%% Code for fancy chapters heading
%%%%%%%%%%%
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

\makeatletter
\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{\vspace*{20\p@}}{}{}%
\patchcmd{\@makeschapterhead}{\vspace*{50\p@}}{\vspace*{20\p@}}{}{}%
\makeatother


\input{config/packages}
\input{config/commands}
\input{config/colors}



%
%
%% Declare all conditional options
%\newif\if@english\@englishtrue
%\newif\if@american\@americantrue
%\newif\if@british\@britishfalse
%\newif\if@german\@germanfalse
%\newif\if@thesisdraft\@thesisdrafttrue
%\newif\if@dategiven\@dategivenfalse
%\newif\if@subtitle\@subtitlefalse
%\newif\if@matriculation\@matriculationfalse
%\newif\if@oneside\@onesidetrue
%\newif\if@printedAbstract\@printedAbstractfalse
%\newif\if@listings\@listingsfalse
%\newif\if@minted\@mintedfalse
%\newif\if@printOnline\@printOnlinefalse
%\newif\if@printPaper\@printPapertrue
%\newif\if@partnerlogo\@partnerlogofalse
%
%\def\@thesistype{\@latex@error{No \noexpand\thesistype given}\@ehc}
%
%% Thesis type
%\DeclareOption{bachelor}{\def\@thesistype{ba}}
%\DeclareOption{diplom}{{\def\@thesistype{da}}}
%\DeclareOption{master}{\def\@thesistype{ma}}
%\DeclareOption{doctorate}{\def\@thesistype{phd}}
%\DeclareOption{milestonereport}{\def\@thesistype{mire}}
%\DeclareOption{thesis=bpa}{\def\@thesistype{bpa}}
%\DeclareOption{thesis=ba}{\def\@thesistype{ba}}
%\DeclareOption{thesis=sa}{\def\@thesistype{sa}}
%\DeclareOption{thesis=da}{\def\@thesistype{da}}
%\DeclareOption{thesis=ma}{\def\@thesistype{ma}}
%\DeclareOption{thesis=phd}{\def\@thesistype{phd}}
%\DeclareOption{thesis=milestonereport}{\def\@thesistype{mire}}
%
%% Language
%\DeclareOption{english}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
%\DeclareOption{american}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
%\DeclareOption{british}{\@englishtrue\@americanfalse\@britishtrue\@germanfalse}
%\DeclareOption{german}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}
%\DeclareOption{ngerman}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}
%\DeclareOption{language=english}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
%\DeclareOption{language=american}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
%\DeclareOption{language=british}{\@englishtrue\@americanfalse\@britishtrue\@germanfalse}
%\DeclareOption{language=german}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}
%\DeclareOption{language=ngerman}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}
%
%% Print mode
%\DeclareOption{online}{\@printOnlinetrue\@printPaperfalse}
%\DeclareOption{paper}{\@printOnlinefalse\@printPapertrue}
%\DeclareOption{docmode=online}{\@printOnlinetrue\@printPaperfalse}
%\DeclareOption{docmode=paper}{\@printOnlinefalse\@printPapertrue}
%
%% Indentation
%\DeclareOption{neverindent}{\PassOptionsToPackage{\CurrentOption}{paxcommands}}
%
%% Code highlighting
%\DeclareOption{listings}{\@listingstrue\@mintedfalse}
%\DeclareOption{minted}{\@listingsfalse\@mintedtrue}
%\DeclareOption{codehighlight=listings}{\@listingstrue\@mintedfalse}
%\DeclareOption{codehighlight=minted}{\@listingsfalse\@mintedtrue}
%
%% Draft
%\DeclareOption{draft}{\@thesisdrafttrue}
%\DeclareOption{thesisdraft}{\@thesisdrafttrue}
%\DeclareOption{final}{\@thesisdraftfalse}
%
%% Oneside or twoside printing
%\PassOptionsToClass{open=right}{scrreprt}
%\PassOptionsToClass{twoside=true}{scrreprt}
%\DeclareOption{oneside}{\PassOptionsToClass{open=any}{scrreprt}\@onesidetrue}
%\DeclareOption{twoside}{\PassOptionsToClass{open=right}{scrreprt}\@onesidefalse}
%
%% Set allowed paper formats
%\DeclareOption{a4}{\PassOptionsToPackage{paper=a4}{typearea}}
%\DeclareOption{letter}{\PassOptionsToPackage{paper=letter}{typearea}}
%\DeclareOption{paper=a4}{\PassOptionsToPackage{paper=a4}{typearea}}
%\DeclareOption{paper=letter}{\PassOptionsToPackage{paper=a4}{typearea}}
%
%% Equation styles
%\DeclareOption{leqno}{\input{leqno.clo}}
%\DeclareOption{fleqn}{\input{fleqn.clo}}
%
%% And fallback option for anything not provided
%\DeclareOption*{\ClassWarning{isw}{Unknown option '\CurrentOption'}}
%
%% Default options
%\ExecuteOptions{thesis=ba,language=english,paper=a4,twoside,draft}
%% And process all options
%\ProcessOptions\relax
%
%\RequirePackage{etex}
%
%% Standard packages
%\RequirePackage{graphicx}
%\RequirePackage[american,british,ngerman]{babel}
%\RequirePackage{lmodern}
%
%\RequirePackage[english,ngerman,num]{isodate} % support for internationalization of date
%\daymonthsepgerman{}%
%\monthyearsepgerman{}{}%
%
%% Set pagesize for PDF or DVI correctly
%\PassOptionsToPackage{pagesize=auto}{typearea}
%
%% Load the komascript book class
%\LoadClass[
%    fontsize=12pt,          %  
%    DIV=13,                 % 
%    BCOR=12mm,              % 
%    listof=totoc,           % 
%    bibliography=totoc,     % 
%    parskip=half,           % 
%    chapterprefix=true,     %  
%    numbers=noenddot,       % 
%%    open=right,             % 
%    cleardoublepage=empty,  % Do not number empty pages 
%%    twoside=true,           % 
%    captions=tableheading,  % 
%    captions=nooneline,     % 
%    numbers=noendperiod,    % 
%    toc=bibliography,       % 
%%    toc=listof,            % 
%    version=last,           % 
%    abstract=on,            % 
%]{scrreprt}
%
%% Classic serif fonts for headlines
%\addtokomafont{sectioning}{\rmfamily}
%\RequirePackage[automark]{scrpage2}
%
%% Chapter have empty head
%\renewcommand*{\chapterpagestyle}{plain}
%
%% Add numbers before (level given in braces) chapter (0), section (1), subsection (2), and subsection (3)
%\setcounter{secnumdepth}{3}
%
%% Default pagestyle for begin
%\pagestyle{empty}
%
%% Include only sections (since we are working with chapters and sections) in table of contents
%\setcounter{tocdepth}{2}
%
%% Start of main Body
%\newcommand{\mainMatter}{
%    %\mainmatter
%}
%
%% Bugfix: \appendix sets tocdepth to 0, tables and figures are on 
%% depth 1, so reset tocdepth if changed in toc
%\newcounter{isw@savetocdepth}
%
%
%% At the end of the document
%\AtEndDocument{
%    % Add to TOC
%    \addtocontents{toc}{\protect\setcounter{tocdepth}{\protect\value{isw@savetocdepth}}} 
%}
%
%% Start of appendix
%\let\oldAppendix\appendix
%\renewcommand{\appendix}{
%    \oldAppendix
%    % Include only chapters in table of contents
%    \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
%}
%
%%
%% Print out thesis type
%% make local
%{
%    \def\@tmp{bpa} \ifx\@thesistype\@tmp \typeout{Thesis is Bachelor's Project Thesis} \fi
%    \def\@tmp{ba} \ifx\@thesistype\@tmp \typeout{Thesis is Bachelor's Thesis} \fi
%    \def\@tmp{sa} \ifx\@thesistype\@tmp \typeout{Thesis is Semester Thesis} \fi
%    \def\@tmp{da} \ifx\@thesistype\@tmp \typeout{Thesis is Diploma Thesis} \fi
%    \def\@tmp{ma} \ifx\@thesistype\@tmp \typeout{Thesis is Master's Thesis} \fi
%    \def\@tmp{phd} \ifx\@thesistype\@tmp \typeout{Thesis is PhD Thesis} \fi
%    \def\@tmp{mire} \ifx\@thesistype\@tmp \typeout{Thesis is Milestone Report} \fi
%}
%
%% Default values
%\def\@titlestring{\@latex@warning@no@line{No \noexpand\title given}}
%\def\@authorstring{\@latex@warning@no@line{No \noexpand\author given}}
%\def\@matriculationstring{}
%\def\@majorstring{\@latex@warning@no@line{No \noexpand\major given}}
%\def\@examinerName{\@latex@warning@no@line{No \noexpand\examiner given}}
%\def\@dateString{}
%\def\@subtitlestring{}
%\def\@partnerstring{}
%\def\@partnerLogostring{}
%\def\@departmentNameString{}
%\def\@LogoUniversity{\hfill}
%\def\@LogoDepartment{\hfill}
%\def\@dedicationname{Dedication}
%\def\@keywordsString{Keywords}
%
%% Add German specific language code
%\addto\captionsngerman{  % no blank linkes allowed!
%    \def\@supervisorstring{Betreuer}
%    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-deutsch}}
%    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-deutsch}}
%    \def\@majorpretextString{Studiengang}
%    \def\@submittedByString{vorgelegt von}
%    \def\@submittedOnString{am}
%    \def\@cooperationString{in Kooperation mit}
%    \def\@examinerString{Pr\"ufer}
%    \def\@departmentNameString{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen, Universit\"at Stuttgart, Seidenstr.~36, 70174 Stuttgart}
%    \def\@preliminaryVersionString{Vorl\"aufige Version}
%    \def\@thesistypestring{%
%        %\tmp is local
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp Bachelorprojektarbeit \fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp Bachelorarbeit\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp Studienarbeit\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp Diplomarbeit\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp Masterarbeit \fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp Dissertation\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp Milestonebericht\fi%
%    }
%    \def\@pretextString{\normalsize Ein%
%        % check if diploma, master or student thesis
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}e Bachelorprojektarbeit \fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}e Bachelorarbeit \fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}e Diplomarbeit \fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}e Masterarbeit \fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}e Doktorarbeit \fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{} Meilensteinbericht \fi%
%        zur Vorlage an der Fakult\"at zur Erlangung\\
%        des akademischen Grades %
%        %
%        %\tmp is local
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        .
%    }
%    \def\@dateString{Datum}
%    \if@dategiven\else
%        \def\@date{\today}
%    \fi
%    \def\@keywordsString{Schlagworte}
%    \renewcommand{\abstractname}{Zusammenfassung}
%    \def\@dedicationname{Widmung}
%}
%
%\addto\captionsenglish{ % no blank linkes allowed!
%    \def\@supervisorstring{Supervisor}
%    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-english}}
%    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-english}}
%    \def\@majorpretextString{Graduate Program}
%    \def\@submittedByString{presented by}
%    \def\@submittedOnString{on}
%    \def\@cooperationString{in coorporation with}
%    \def\@examinerString{Examiner}
%    \def\@departmentNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart, Germany}
%    \def\@preliminaryVersionString{Draft}
%    \def\@thesistypestring{
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor's Project Thesis\fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor's Thesis\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Student Research Project\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diploma Thesis\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master's Thesis\fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doctoral Thesis\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}Milestone Report\fi%
%        \space}
%    \def\@pretextString{\normalsize A %
%        % check if diploma, master or student thesis
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}bachelor's project thesis \fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}bachelor's thesis \fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}student thesis \fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}diploma thesis \fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}master's thesis \fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}doctoral thesis \fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}milestone report \fi%
%        presented to the faculty in partial fulfillment of \\
%        the requirements for the degree %
%        %
%        %\tmp is local
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        .
%        }
%    \def\@dateString{Date}
%    \if@dategiven\else
%    \def\@date{\today}
%    \fi
%    \renewcommand{\abstractname}{Abstract}
%    \def\@dedicationname{Dedication}
%}
%
%\addto\captionsamerican{ % no blank linkes allowed!
%    \def\@supervisorstring{Supervisor}
%    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-english}}
%    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-english}}
%    \def\@majorpretextString{Graduate Program}
%    \def\@submittedByString{presented by}
%    \def\@submittedOnString{on}
%    \def\@cooperationString{in coorporation with}
%    \def\@examinerString{Examiner}
%    \def\@departmentNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart, Germany}
%    \def\@preliminaryVersionString{Draft}
%    \def\@thesistypestring{
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor's Project Thesis\fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor's Thesis\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Student Research Project\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diploma Thesis\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master's Thesis\fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doctoral Thesis\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}Milestone Report\fi%
%        \space}
%    \def\@pretextString{\normalsize A %
%        % check if diploma, master or student thesis
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}bachelor's project thesis \fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}bachelor's thesis \fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}student thesis \fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}diploma thesis \fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}master's thesis \fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}doctoral thesis \fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}milestone report \fi%
%        presented to the faculty in partial fulfillment of \\
%        the requirements for the degree %
%        %
%        %\tmp is local
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        .
%    }
%    \def\@dateString{Date}
%    \if@dategiven\else
%        \def\@date{\today}
%    \fi
%    \renewcommand{\abstractname}{Abstract}
%    \def\@dedicationname{Dedication}
%}
%
%\addto\captionsbritsh{ % no blank linkes allowed!
%    \def\@supervisorstring{Supervisor}
%    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-english}}
%    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-english}}
%    \def\@majorpretextString{Graduate Program}
%    \def\@submittedByString{presented by}
%    \def\@submittedOnString{on}
%    \def\@cooperationString{in coorporation with}
%    \def\@examinerString{Examiner}
%    \def\@departmentNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart, Germany}
%    \def\@preliminaryVersionString{Draft}
%    \def\@thesistypestring{
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor's Project Thesis\fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor's Thesis\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Student Research Project\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diploma Thesis\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master's Thesis\fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doctoral Thesis\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}Milestone Report\fi%
%        \space}
%    \def\@pretextString{\normalsize A %
%        % check if diploma, master or student thesis
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}bachelor's project thesis \fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}bachelor's thesis \fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}student thesis \fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}diploma thesis \fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}master's thesis \fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}doctoral thesis \fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}milestone report \fi%
%        presented to the faculty in partial fulfillment of \\
%        the requirements for the degree %
%        %
%        %\tmp is local
%        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
%        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
%        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
%        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        \def\@tmp{mire}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
%        .
%    }
%    \def\@dateString{Date}
%    \if@dategiven\else
%        \def\@date{\today}
%    \fi
%    \renewcommand{\abstractname}{Abstract}
%    \def\@dedicationname{Dedication}
%}
%
%% Supervisors
%\def\@supervisorstringA{\@latex@warning@no@line{No \noexpand\supervisor given}}
%\def\@supervisorstringB{}
%\def\@supervisorstringC{}
%\def\@supervisorstringD{}
%\newcounter{@supervisors}
%\setcounter{@supervisors}{0}
%\def\supervisor#1{\stepcounter{@supervisors}%
%    \ifnum\value{@supervisors}=1
%        \def\@supervisorstringA{\mbox{#1}}
%    \fi
%    \ifnum\value{@supervisors}=2
%        \def\@supervisorstringB{,\space\mbox{#1}}
%        \addto\captionsbritish{ % no blank lines allowed!
%            \def\@supervisorstring{Supervisors}
%        }
%        \addto\captionsamerican{ % no blank lines allowed!
%            \def\@supervisorstring{Supervisors}
%        }
%    \fi
%    \ifnum\value{@supervisors}=3
%        \def\@supervisorstringC{,\space\mbox{#1}}
%    \fi
%    \ifnum\value{@supervisors}=4
%        \def\@supervisorstringD{,\space\mbox{#1}}
%    \fi
%    \ifnum\value{@supervisors}=5
%        \@latex@warning@no@line{Too many supervisors ...}
%    \fi
%}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% User commands to set title page information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\def\examiner#1{\def\@examinerName{#1}}
%\def\author#1{\def\@authorstring{#1}}
%\def\matriculation#1{\def\@matriculationstring{#1}\@matriculationtrue}
%\def\major#1{\def\@majorstring{#1}}
%\def\date#1{\def\@date{\iflanguage{english}{\isodate}{\numdate}\printdate{#1}}\@dategiventrue}
%%\def\date#1{\def\@date{\origdate\printdate{#1}}\@dategiventrue}
%\def\title#1{\def\@titlestring{#1}}
%\def\subtitle#1{\def\@subtitlestring{#1}\@subtitletrue}
%\def\partner#1{\def\@partnerstring{#1}\@partnertrue}
%\def\partnerLogo#1{\def\@partnerLogostring{#1}\@partnerlogotrue}
%\def\departmentname#1{\def\@departmentNameString{#1}}
%\def\LogoUniversity#1{\def\@LogoUniversity{#1}}
%\def\LogoUniversityheight#1{\def\@LogoUniversityHeight{#1}}
%\def\LogoDepartment#1{\def\@LogoDepartment{#1}}
%\def\LogoDepartmentheight#1{\def\@LogoDepartmentHeight{#1}}
%
%
%%%%%%%%%%%
%% MAKETITLE FOR ISW THESES
%%%%%%%%%%%
%\def\maketitle{
%    \def\categoryfont{\sffamily\itshape}
%    \thispagestyle{empty}
%    \begin{titlepage}%
%        \begin{center}
%            \begin{minipage}[b]{0.495\linewidth}
%                \if@partnerlogo%
%                \raggedright%
%                \fi%
%                \@LogoUniversity
%            \end{minipage}
%            \if@partnerlogo
%                \begin{minipage}[b]{0.495\linewidth}
%                    \raggedleft%
%                    \@partnerLogostring
%                \end{minipage}
%            \fi
%            
%            % Type of thesis
%            \vspace{1cm}
%            {\categoryfont\Large\@thesistypestring} \par
%            \vspace{0.4cm}
%            % Title
%            \begingroup
%                \LARGE\bfseries\@titlestring\hfill \par
%            \endgroup
%            % Subtitle
%            \vspace{0.4cm}
%            \large\bfseries
%            \if@subtitle
%                \@subtitlestring \par
%            \else
%                \vspace{\baselineskip}\vspace{\parskip}
%            \fi
%            \normalsize\normalfont \par
%            
%            % Vorlaeufige Version / Draft
%            \categoryfont\Huge \par
%            \if@thesisdraft
%                \@preliminaryVersionString
%            \else
%                \vspace{\baselineskip}\vspace{\parskip}
%            \fi
%            \normalsize\normalfont \par
%            
%            \vspace{0.5\baselineskip}
%            
%            \@submittedByString
%            
%            \vspace{0.5\baselineskip}
%            
%            % Author and matriculation number
%            \begingroup
%                % Author
%                {\sffamily\itshape\Large\@authorstring\mdseries \par}
%                \normalsize\normalfont \par
%                
%                % Matriculation number
%                \large\mdseries \par
%                \if@matriculation
%                    \@matriculationstring
%                \else
%                    \vspace{\baselineskip}\vspace{\parskip}
%                \fi
%            \endgroup%
%            \normalsize\normalfont\par
%            %
%            % Datum
%            \@submittedOnString
%            
%            \vspace{0.5\baselineskip}
%            %
%            {\large\@date} \par
%            \normalsize\normalfont \par
%            %
%            \vfill
%            %
%            \@pretextString
%            %
%            \vfill%
%            %
%            \begin{minipage}[t]{0.5\linewidth}
%                \flushleft
%                % Supervisor Block
%                % Examiner
%                {\footnotesize\categoryfont\@examinerString}\\
%                {\normalsize\@examinerName} \par
%                \vspace{0.3cm}
%                % Supervisor
%                {\footnotesize\categoryfont\@supervisorstring}\\
%                \@supervisorstringA\@supervisorstringB\@supervisorstringC\@supervisorstringD \par
%            \end{minipage}%
%            %
%            \begin{minipage}[t]{0.5\linewidth}
%                \flushright
%                % Graduate Programme
%                {\footnotesize\categoryfont\@majorpretextString}\\
%                \@majorstring \par
%            \end{minipage}%
%            
%            \vfill
%            %
%            \begin{minipage}[c]{0.8\linewidth}
%                \begin{flushleft}
%                    \small\@departmentNameString
%                \end{flushleft}
%            \end{minipage}%
%            \begin{minipage}[c]{0.2\linewidth}
%                \begin{flushright}
%                    \@LogoDepartment
%                \end{flushright}
%            \end{minipage}
%        \end{center}
%        \vspace*{-2.5cm}
%    \end{titlepage}
%    \if@oneside
%        \clearpage
%    \else
%        \cleardoublepage
%    \fi
%}
%
%%%%%%%%%%%
%% Abstract of the thesis
%%%%%%%%%%%
%\newenvironment{thesis-abstract}{%
%    \chapter*{\abstractname}
%    \addcontentsline{toc}{chapter}{\abstractname}
%%    \vspace{\baselineskip}\vspace{\parskip}
%    \begin{RaggedRight}
%}{%
%\end{RaggedRight}
%\if@oneside
%    \clearpage
%\else
%    \cleardoublepage
%\fi
%}
%
%%%%%%%%%%%
%% Dedication environment
%%%%%%%%%%%
%\renewenvironment{dedication}{%
%    \chapter*{\@dedicationname}
%%    \vspace{\baselineskip}\vspace{\parskip}
%    \begin{RaggedRight}
%}{%
%\end{RaggedRight}
%\if@oneside
%    \clearpage
%\else
%    \cleardoublepage
%\fi
%}
%
%%%%%%%%%%%
%% Command to set front matter specific things
%%%%%%%%%%%
%\newcommand{\frontmatter}{%
%    \if@oneside
%        \clearpage
%    \else
%        \cleardoublepage
%    \fi
%    \pagenumbering{Roman}
%}
%
%%%%%%%%%%%
%% Command to set main matter specific things
%%%%%%%%%%%
%\newcommand{\mainmatter}{%
%    \if@oneside
%        \clearpage
%    \else
%        \cleardoublepage
%    \fi
%    \pagenumbering{arabic}
%}
%
%%%%%%%%%%%
%% Code for fancy chapters heading
%%%%%%%%%%%
%\RequirePackage{fncychap}
%\makeatletter
%\ChNameVar{\normalfont\Large\scshape} % sets the style for name
%\ChNumVar{\fontsize{85}{100}\selectfont\sffamily\color{white}}
%\ChTitleVar{\normalfont\Huge\scshape\color{black}\raggedleft}
%\renewcommand{\DOCH}{%
%    \setlength{\fboxrule}{\RW}
%    \makebox[\linewidth][r]{
%        \rotatebox{90}{
%            \makebox[2cm][l]{
%                \resizebox{2.5cm}{!}{ %\fboxsep=6pt
%                    \CNV\FmN{\space\@chapapp}
%                }
%            }
%        }
%        \resizebox{!}{2.5cm}{\fboxsep=6pt
%            \CNoV\colorbox{black!40}{\thechapter}
%        }
%    }%
%    \par\nobreak
%    \vskip 0\p@
%}
%\renewcommand{\DOTI}[1]{%
%    \CTV\FmTi{#1}\par\nobreak
%    \vskip 40\p@}
%\renewcommand{\DOTIS}[1]{%
%    \CTV\FmTi{#1}\par\nobreak
%    \vskip 40\p@}
%\makeatother
%
%% Input all the packages that this class provides (keeps this file's lines less)
%\input{config/packages.tex}
%\input{config/commands.tex}
%\input{config/colors.tex}
%

\endinput
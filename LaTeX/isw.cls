\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isw}[2015/07/10 ISW LaTeX Class]

\typeout{}
\typeout{  ISW - Institute for Control Engineering of Machine Tools and Manufacturing Units, University Stuttgart}
\typeout{  Thesis Style 2015, Version 0.1.0 }
\typeout{}


\newif\if@english
\newif\if@british
\newif\if@german
\newif\if@thesisdraft
\newif\if@dategiven
\newif\if@subtitle
\newif\if@oneside
\newif\if@printedAbstract
\@printedAbstractfalse

%\def\@thesistype{}
\def\@thesistype{\@latex@error{No \noexpand\thesistype given}\@ehc}

% Thesis type
\DeclareOption{bachelor}{\def\@thesistype{ba}}
\DeclareOption{diplom}{{\def\@thesistype{da}}}
\DeclareOption{master}{\def\@thesistype{ma}}
\DeclareOption{doctorate}{\def\@thesistype{phd}}
\DeclareOption{thesis=bpa}{\def\@thesistype{bpa}}
\DeclareOption{thesis=ba}{\def\@thesistype{ba}}
\DeclareOption{thesis=sa}{\def\@t\defhesistype{sa}}
\DeclareOption{thesis=da}{\def\@thesistype{da}}
\DeclareOption{thesis=ma}{\def\@thesistype{ma}}
\DeclareOption{thesis=phd}{\def\@thesistype{phd}}

% Language
\DeclareOption{english}{\@englishtrue\@britishfalse\@germanfalse}
\DeclareOption{american}{\@englishtrue\@britishfalse\@germanfalse}
\DeclareOption{british}{\@englishfalse\@britishtrue\@germanfalse}
\DeclareOption{german}{\@germantrue\@britishfalse\@englishfalse}
\DeclareOption{ngerman}{\@germantrue\@britishfalse\@englishfalse}
\DeclareOption{language=english}{\@englishtrue\@britishfalse\@germanfalse}
\DeclareOption{language=american}{\@englishtrue\@britishfalse\@germanfalse}
\DeclareOption{language=british}{\@englishtrue\@britishtrue\@germanfalse}
\DeclareOption{language=german}{\@germantrue\@britishfalse\@englishfalse}
\DeclareOption{language=ngerman}{\@germantrue\@britishfalse\@englishfalse}

% Indentation
\DeclareOption{neverindent}{\PassOptionsToPackage{\CurrentOption}{paxcommands}}

% Draft
\DeclareOption{draft}{\@thesisdrafttrue}
\DeclareOption{thesisdraft}{\@thesisdrafttrue}

% Oneside or twoside printing
\DeclareOption{oneside}{\PassOptionsToClass{open=any}{scrreprt}\@onesidetrue}
\DeclareOption{twoside}{\PassOptionsToClass{open=right}{scrreprt}\@onesidefalse}

% Set allowed paper formats
\DeclareOption{a4}{\PassOptionsToPackage{paper=a4}{typearea}}
\DeclareOption{letter}{\PassOptionsToPackage{paper=letter}{typearea}}
\DeclareOption{paper=a4}{\PassOptionsToPackage{paper=a4}{typearea}}
\DeclareOption{paper=letter}{\PassOptionsToPackage{paper=a4}{typearea}}

% Equation styles
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}

% And fallback option for anything not provided
\DeclareOption*{\ClassWarning{isw}{Unknown option '\CurrentOption'}}

% Default options
\ExecuteOptions{thesis=ba, language=english, paper=a4, twoside}
% And process all options
\ProcessOptions\relax

% Standard packages
\RequirePackage{graphicx}
\RequirePackage[american,british,ngerman]{babel}
\RequirePackage{lmodern}

\RequirePackage[english,ngerman,num]{isodate} % support for internationalization of date
\daymonthsepgerman{}%
\monthyearsepgerman{}{}%

% Set pagesize for PDF or DVI correctly
\PassOptionsToPackage{pagesize=auto}{typearea}

% Load the komascript book class
\LoadClass[
    fontsize=12pt,			% 
    DIV=13,					% 
    BCOR=8mm,				% 
    listof=totoc,			% 
    bibliography=totoc,		% 
    parskip=half,			% 
    chapterprefix,			% 
    numbers=noenddot,		% 
    open=right,				% 
    cleardoublepage=empty,  % Do not number empty pages 
    twoside=true,			% 
    captions=tableheading,	% 
    captions=nooneline,		% 
]{scrbook}

% Classic serif fonts for headlines
\addtokomafont{sectioning}{\rmfamily}
\RequirePackage[automark]{scrpage2}

% Chapter have empty head
\renewcommand*{\chapterpagestyle}{plain}

% Default pagestyle for begin
\pagestyle{empty}

% Include only sections (since we are working with chapters and sections) in table of contents
\setcounter{tocdepth}{1}

% Start of main Body
\newcommand{\mainMatter}{
    %\mainmatter
}

% Bugfix: \appendix sets tocdepth to 0, tables and figures are on 
% depth 1, so reset tocdepth if changed in toc
\newcounter{isw@savetocdepth}


% At the beginning of the document...
\AtBeginDocument{
    % Select the proper language
    \if@german
        \selectlanguage{ngerman}
    \else
        \if@british
            \selectlanguage{british}
        \else
            \selectlanguage{american}
        \fi
    \fi
    %\cleardoubleemptypage
    %\setcounter{page}{1}
    %\pagenumbering{Roman}
    \pagenumbering{arabic}
    \pagestyle{scrheadings}
    \addtocontents{toc}{\protect\setcounter{isw@savetocdepth}{\protect\value{tocdepth}}} 
}

% At the end of the document
\AtEndDocument{
    % Add to TOC
    \addtocontents{toc}{\protect\setcounter{tocdepth}{\protect\value{isw@savetocdepth}}} 
}

% Start of appendix
\let\oldAppendix\appendix
\renewcommand{\appendix}{
    \oldAppendix
    % Include only chapters in table of contents
    \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
}

%
% Print out thesis type
% make local
{
    \def\@tmp{bpa} \ifx\@thesistype\@tmp \typeout{Thesis is Bachelor's Project Thesis} \fi
    \def\@tmp{ba} \ifx\@thesistype\@tmp \typeout{Thesis is Bachelor's Thesis} \fi
    \def\@tmp{sa} \ifx\@thesistype\@tmp \typeout{Thesis is Semester Thesis} \fi
    \def\@tmp{da} \ifx\@thesistype\@tmp \typeout{Thesis is Diploma Thesis} \fi
    \def\@tmp{ma} \ifx\@thesistype\@tmp \typeout{Thesis is Master's Thesis} \fi
    \def\@tmp{phd} \ifx\@thesistype\@tmp \typeout{Thesis is PhD Thesis} \fi
}

% Default values
\def\@titlestring{\@latex@warning@no@line{No \noexpand\title given}}
\def\@authorstring{\@latex@warning@no@line{No \noexpand\author given}}
\def\@majorstring{\@latex@warning@no@line{No \noexpand\major given}}
\def\@examinerName{\@latex@warning@no@line{No \noexpand\examiner given}}
\def\@dateString{}
\def\@subtitlestring{}
\def\@partnerstring{}
\def\@partnerLogostring{}
\def\@instituteNameString{}
\def\@RightTopLogo{\hfill}
\def\@LeftTopLogo{\hfill}


\addto\captionsngerman{  % no blank linkes allowed!
    \def\@supervisorstring{Betreuer}
    \def\@RightTopLogo{\includegraphics[height=1.1cm]{figures/logos/uni-stuttgart-deutsch}}
    %\def\@LeftTopLogo{\includegraphics[height=1.1cm]{figures/logos/institut-deutsch}}
    %\def\@majorpretextString{\vspace{2cm}im Studiengang}
    \def\@majorpretextString{\vspace{.5cm}Studiengang}
    \def\@submittedByString{vorgelegt von}
    \def\@cooperationString{in Kooperation mit}
    \def\@examinerString{Pr\"ufer}
    \def\@instituteNameString{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen, Universit\"at Stuttgart, Seidenstr.~36, 70174 Stuttgart}
    \def\@preliminaryVersionString{Vorl\"aufige Version}
    \def\@thesistypestring{%
        %\tmp is local
        \def\@tmp{bpa}\ifx\@thesistype\@tmp Bachelorprojektarbeit \fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp Bachelorarbeit\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp Studienarbeit\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp Diplomarbeit\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp Masterarbeit \fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp Dissertation\fi%
    }
    \def\@dateString{Datum}
    \if@dategiven\else
    \def\@date{\today}
    \fi
    \renewcommand{\abstractname}{Kurzfassung}
}

\addto\captionsenglish{ % no blank linkes allowed!
    \def\@supervisorstring{Supervisor}
    \def\@RightTopLogo{\includegraphics[height=1.1cm]{figures/logos/uni-stuttgart-english}}
    %\def\@LeftTopLogo{\includegraphics[height=1.1cm]{figures/logos/institut-english}}
    \def\@majorpretextString{Graduate Program}
    \def\@submittedByString{by}
    \def\@cooperationString{in coorporation with}
    \def\@examinerString{Examiner}
    \def\@instituteNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart}
    \def\@preliminaryVersionString{Draft}
    \def\@thesistypestring{\def\@tmp{sa}\ifx\@thesistype\@tmp{}Student thesis\fi%
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor's project thesis\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor's thesis\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Student research project\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diploma thesis\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master's thesis\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doctoral Thesis\fi%
        \space}
    \def\@pretextString{\normalsize A %
        % check if diploma, master or student thesis
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}bachelor's project \fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}bachelor's \fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}student \fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}diploma \fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}master's \fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}doctoral \fi%
        thesis presented to the faculty in partial fulfillment of \\
        the requirements for the degree %
        %
        %\tmp is local
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur\fi%
        \space in}
    \def\@dateString{Date}
    \if@dategiven\else
    \def\@date{\today}
    \fi
}

\addto\captionsamerican{ % no blank linkes allowed!
    \def\@supervisorstring{Supervisor}
    \def\@RightTopLogo{\includegraphics[height=1.1cm]{figures/logos/uni-stuttgart-english}}
    %\def\@LeftTopLogo{\includegraphics[height=1.1cm]{figures/logos/institut-english}}
    \def\@majorpretextString{Graduate Program}
    \def\@submittedByString{by}
    \def\@cooperationString{in coorporation with}
    \def\@examinerString{Examiner}
    \def\@instituteNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart}
    \def\@preliminaryVersionString{Draft}
    \def\@thesistypestring{\def\@tmp{sa}\ifx\@thesistype\@tmp{}Student thesis\fi%
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor's project thesis\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor's thesis\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Student research project\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diploma thesis\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master's thesis\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doctoral Thesis\fi%
        \space}
    \def\@pretextString{\normalsize A %
        % check if diploma, master or student thesis
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}bachelor's project \fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}bachelor's \fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}student \fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}diploma \fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}master's \fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}doctoral \fi%
        thesis presented to the faculty in partial fulfillment of \\
        the requirements for the degree %
        %
        %\tmp is local
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur\fi%
        \space in}
    \def\@dateString{Date}
    \if@dategiven\else
        \def\@date{\today}
    \fi
}

\addto\captionsbritsh{ % no blank linkes allowed!
    \def\@supervisorstring{Supervisor}
    \def\@RightTopLogo{\includegraphics[height=1.1cm]{figures/logos/uni-stuttgart-english}}
    %\def\@LeftTopLogo{\includegraphics[height=1.1cm]{figures/logos/institut-english}}
    \def\@majorpretextString{Graduate Program}
    \def\@submittedByString{by}
    \def\@cooperationString{in coorporation with}
    \def\@examinerString{Examiner}
    \def\@instituteNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart}
    \def\@preliminaryVersionString{Draft}
    \def\@thesistypestring{\def\@tmp{sa}\ifx\@thesistype\@tmp{}Student thesis\fi%
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor's project thesis\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor's thesis\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Student research project\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diploma thesis\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master's thesis\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doctoral Thesis\fi%
        \space}
    \def\@pretextString{\normalsize A %
        % check if diploma, master or student thesis
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}bachelor's project \fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}bachelor's \fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}student \fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}diploma \fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}master's \fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}doctoral \fi%
        thesis presented to the faculty in partial fulfillment of \\
        the requirements for the degree %
        %
        %\tmp is local
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur\fi%
        \space in}
    \def\@dateString{Date}
    \if@dategiven\else
    \def\@date{\today}
    \fi
}

% Supervisors
\def\@supervisorstringA{\@latex@warning@no@line{No \noexpand\supervisor given}}
\def\@supervisorstringB{}
\def\@supervisorstringC{}
\def\@supervisorstringD{}

\newcounter{@supervisors}
\setcounter{@supervisors}{0}
\def\supervisor#1{\stepcounter{@supervisors}%
    \ifnum\value{@supervisors}=1
        \def\@supervisorstringA{\mbox{#1}}
    \fi
    \ifnum\value{@supervisors}=2
        \def\@supervisorstringB{,\space\mbox{#1}}
        \addto\captionsbritish{ % no blank lines allowed!
            \def\@supervisorstring{Supervisors}
        }
        \addto\captionsamerican{ % no blank lines allowed!
            \def\@supervisorstring{Supervisors}
        }
    \fi
    \ifnum\value{@supervisors}=3
        \def\@supervisorstringC{,\space\mbox{#1}}
    \fi
    \ifnum\value{@supervisors}=4
        \def\@supervisorstringD{,\space\mbox{#1}}
    \fi
    \ifnum\value{@supervisors}=5
        \@latex@warning@no@line{Too many supervisors ...}
    \fi   
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User commands to set title page information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\examiner#1{\def\@examinerName{#1}}
\def\author#1{\def\@authorstring{#1}}
\def\major#1{\def\@majorstring{#1}}
\def\date#1{\def\@date{\iflanguage{english}{\isodate}{\numdate}\printdate{#1}}\@dategiventrue}
%\def\date#1{\def\@date{\origdate\printdate{#1}}\@dategiventrue}
\def\title#1{\def\@titlestring{#1}}
\def\subtitle#1{\def\@subtitlestring{#1}\@subtitletrue}
\def\partner#1{\def\@partnerstring{#1}\@partnertrue}
\def\partnerLogo#1{\def\@partnerLogostring{#1}\@partnerlogotrue}
\def\institutename#1{\def\@instituteNameString{#1}}
\def\righttoplogo#1{\def\@RightTopLogo{#1}}
\def\righttoplogoheight#1{\def\@RightTopLogoHeight{#1}}
\def\lefttoplogo#1{\def\@LeftTopLogo{#1}}
\def\lefttoplogoheight#1{\def\@LeftTopLogoHeight{#1}}


%
% MAKETITLE FOR ISYS SA/DA Thesis
%
\def\maketitle{
    \def\categoryfont{\sffamily\itshape\small}
    \thispagestyle{empty}	
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \begin{titlepage}%
        \raggedright
        %
        %
        % Grafiken am Kopf der Seite
        \vspace*{-1.8cm}
        \begin{center}
            \hspace*{-0.6cm}
            \begin{minipage}{7.8cm}
                \begin{flushleft}
                    \@LeftTopLogo
                \end{flushleft}
            \end{minipage}\hfill 
            \begin{minipage}{7.5cm}
                \begin{flushright}
                    \@RightTopLogo
                \end{flushright}
            \end{minipage}  	
            \hspace*{-1.5cm}
        \end{center}
        
        % Art der Arbeit bzw. allg. Vorspann mit Abschluss in Englisch
        \vspace{1.7cm}
        \if@subtitle\else % Zusatz
            \vspace{0.4cm}
        \fi
        {\categoryfont\Large\@thesistypestring}\par
        \vspace{0.4cm}
        % Titel und Untertitel
        %\vspace{0.8cm}
        \begingroup
        \LARGE\bfseries\@titlestring\hfill\par
        \endgroup
        \if@subtitle
            \vspace{0.4cm}
            {\large\bfseries\@subtitlestring}\par
        \else
            \vspace{1cm}
        \fi
        % Vorlaeufige Version / Draft
        \if@thesisdraft
            \begin{center}
                \categoryfont\Large
                \@preliminaryVersionString
            \end{center}
        \else
            \vspace{0.5cm}
        \fi
        % Art der Arbeit bzw. allg. Vorspann mit Abschluss in Englisch
        % Autor
        \vspace{.8cm}{\normalsize\categoryfont\@submittedByString}\\
        \normalsize\@authorstring\mdseries\par\normalsize
        
        \vfill
        
%        % Partner
%        \if@partner
%            \vspace{.5cm}
%            \begingroup
%                \normalsize{\categoryfont\@cooperationString}\strut\\
%                \if@partnerlogo
%                    \begin{tabular}[c]{@{}l}
%                        \@partnerLogostring
%                    \end{tabular}
%                \fi
%                \begingroup
%                    \normalsize
%                    \begin{tabular}[c]{@{}l@{}}
%                        \@partnerstring
%                    \end{tabular}\par
%                \endgroup
%            \endgroup
%        \fi
%        \vfill
        
        % Studiengang
        {\normalsize\categoryfont\@majorpretextString}\\
        {\@majorstring}\par
        \vspace{0.3cm}
        % Supervisor Block	
        \begingroup
        % Examiner
        \normalsize{\categoryfont\@examinerString}\\
        \@examinerName \par
        \vspace{0.3cm}
        % Supervisor
        \normalsize{\categoryfont\@supervisorstring}\\
        \@supervisorstringA\@supervisorstringB\@supervisorstringC\@supervisorstringD\par
        \endgroup
        
        
        % Datum
        \vspace{1.1cm}
        \normalsize
        {\categoryfont\@dateString}\\
        \@date\par
        \vspace{.7cm}
        % Institut
        \begin{center}\small\@instituteNameString\end{center}
        \vspace*{-2.5cm}
    \end{titlepage}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \if@oneside
        \clearpage
    \else
        \cleardoublepage
    \fi
}


%\newtheorem{thm}{Theorem}[section]
%\newtheorem{cor}[thm]{Corollar}
%\newtheorem{lem}[thm]{Lemma}
%\newtheorem{def}[thm]{Definition}

\endinput

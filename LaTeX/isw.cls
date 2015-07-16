\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isw}[2015/07/10 ISW LaTeX Class]

\typeout{}
\typeout{  ISW - Institute for Control Engineering of Machine Tools and Manufacturing Units, University Stuttgart}
\typeout{  Thesis Style 2015, Version 0.1.0 }
\typeout{}

% Declare all conditional options
\newif\if@english\@englishtrue
\newif\if@american\@americantrue
\newif\if@british\@britishfalse
\newif\if@german\@germanfalse
\newif\if@thesisdraft\@thesisdrafttrue
\newif\if@dategiven\@dategivenfalse
\newif\if@subtitle\@subtitlefalse
\newif\if@matriculation\@matriculationfalse
\newif\if@oneside\@onesidetrue
\newif\if@printedAbstract\@printedAbstractfalse
\newif\if@listings\@listingsfalse
\newif\if@minted\@mintedfalse
\newif\if@printOnline\@printOnlinefalse
\newif\if@printPaper\@printPapertrue

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
\DeclareOption{english}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
\DeclareOption{american}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
\DeclareOption{british}{\@englishtrue\@americanfalse\@britishtrue\@germanfalse}
\DeclareOption{german}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}
\DeclareOption{ngerman}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}
\DeclareOption{language=english}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
\DeclareOption{language=american}{\@englishtrue\@americantrue\@britishfalse\@germanfalse}
\DeclareOption{language=british}{\@englishtrue\@americanfalse\@britishtrue\@germanfalse}
\DeclareOption{language=german}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}
\DeclareOption{language=ngerman}{\@germantrue\@americanfalse\@britishfalse\@englishfalse}

% Print mode
\DeclareOption{online}{\@printOnlinetrue\@printPaperfalse}
\DeclareOption{paper}{\@printOnlinefalse\@printPapertrue}
\DeclareOption{docmode=online}{\@printOnlinetrue\@printPaperfalse}
\DeclareOption{docmode=paper}{\@printOnlinefalse\@printPapertrue}

% Indentation
\DeclareOption{neverindent}{\PassOptionsToPackage{\CurrentOption}{paxcommands}}

% Code highlighting
\DeclareOption{listings}{\@listingstrue\@mintedfalse}
\DeclareOption{minted}{\@listingsfalse\@mintedtrue}
\DeclareOption{codehighlight=listings}{\@listingstrue\@mintedfalse}
\DeclareOption{codehighlight=minted}{\@listingsfalse\@mintedtrue}

% Draft
\DeclareOption{draft}{\@thesisdrafttrue}
\DeclareOption{thesisdraft}{\@thesisdrafttrue}
\DeclareOption{final}{\@thesisdraftfalse}

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
\ExecuteOptions{thesis=ba,language=english,paper=a4,twoside,draft}
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
    fontsize=12pt,          %  
    DIV=13,                 % 
    BCOR=8mm,               % 
    listof=totoc,           % 
    bibliography=totoc,     % 
    parskip=half,           % 
    chapterprefix=true,     %  
    numbers=noenddot,       % 
    open=right,             % 
    cleardoublepage=empty,  % Do not number empty pages 
    twoside=true,           % 
    captions=tableheading,  % 
    captions=nooneline,     % 
    numbers=noendperiod,    % 
    toc=bibliography,       % 
%    toc=listof,            % 
    version=last,           % 
    abstract=on,            % 
]{scrreprt}

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
    \hypersetup{
        pdfauthor={\@authorstring},
        pdftitle={\@titlestring},
        pdfsubject={\@pretextString},
        pdfkeywords={},
    }
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
    \pagenumbering{Roman}
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
\def\@matriculationstring{}
\def\@majorstring{\@latex@warning@no@line{No \noexpand\major given}}
\def\@examinerName{\@latex@warning@no@line{No \noexpand\examiner given}}
\def\@dateString{}
\def\@subtitlestring{}
\def\@partnerstring{}
\def\@partnerLogostring{}
\def\@departmentNameString{}
\def\@LogoUniversity{\hfill}
\def\@LogoDepartment{\hfill}
\def\@dedicationname{Dedication}
\def\@keywordsString{Keywords}

% Add German specific language code
\addto\captionsngerman{  % no blank linkes allowed!
    \def\@supervisorstring{Betreuer}
    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-deutsch}}
    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-deutsch}}
    \def\@majorpretextString{Studiengang}
    \def\@submittedByString{vorgelegt von}
    \def\@submittedOnString{am}
    \def\@cooperationString{in Kooperation mit}
    \def\@examinerString{Pr\"ufer}
    \def\@departmentNameString{Institut f\"ur Steuerungstechnik der Werkzeugmaschinen und Fertigungseinrichtungen, Universit\"at Stuttgart, Seidenstr.~36, 70174 Stuttgart}
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
    \def\@pretextString{\normalsize Eine %
        % check if diploma, master or student thesis
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelorprojekt\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor\fi%
        arbeit zur Vorlage an der Fakult\"at zur Erlangung\\
        des akademischen Grades %
        %
        %\tmp is local
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
    }
    \def\@dateString{Datum}
    \if@dategiven\else
        \def\@date{\today}
    \fi
    \def\@keywordsString{Schlagworte}
    \renewcommand{\abstractname}{Zusammenfassung}
    \def\@dedicationname{Widmung}
}

\addto\captionsenglish{ % no blank linkes allowed!
    \def\@supervisorstring{Supervisor}
    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-english}}
    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-english}}
    \def\@majorpretextString{Graduate Program}
    \def\@submittedByString{presented by}
    \def\@submittedOnString{on}
    \def\@cooperationString{in coorporation with}
    \def\@examinerString{Examiner}
    \def\@departmentNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart, Germany}
    \def\@preliminaryVersionString{Draft}
    \def\@thesistypestring{
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
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
        }
    \def\@dateString{Date}
    \if@dategiven\else
    \def\@date{\today}
    \fi
    \renewcommand{\abstractname}{Abstract}
    \def\@dedicationname{Dedication}
}

\addto\captionsamerican{ % no blank linkes allowed!
    \def\@supervisorstring{Supervisor}
    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-english}}
    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-english}}
    \def\@majorpretextString{Graduate Program}
    \def\@submittedByString{presented by}
    \def\@submittedOnString{on}
    \def\@cooperationString{in coorporation with}
    \def\@examinerString{Examiner}
    \def\@departmentNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart, Germany}
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
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
        }
    \def\@dateString{Date}
    \if@dategiven\else
        \def\@date{\today}
    \fi
    \renewcommand{\abstractname}{Abstract}
    \def\@dedicationname{Dedication}
}

\addto\captionsbritsh{ % no blank linkes allowed!
    \def\@supervisorstring{Supervisor}
    \def\@LogoUniversity{\includegraphics[height=1.5cm, keepaspectratio=true]{images/logo/uni-stuttgart-english}}
    \def\@LogoDepartment{\includegraphics[height=2cm, keepaspectratio=true]{images/logo/department-english}}
    \def\@majorpretextString{Graduate Program}
    \def\@submittedByString{presented by}
    \def\@submittedOnString{on}
    \def\@cooperationString{in coorporation with}
    \def\@examinerString{Examiner}
    \def\@departmentNameString{Institute for Control Engineering of Machine Tools and Manufacturing Units, University of Stuttgart, Seidenstr.~36, 70174 Stuttgart, Germany}
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
        \def\@tmp{bpa}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{ba}\ifx\@thesistype\@tmp{}Bachelor of Science (B.Sc.)\fi%
        \def\@tmp{sa}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{da}\ifx\@thesistype\@tmp{}Diplom-Ingenieur (Dipl.-Ing.)\fi%
        \def\@tmp{ma}\ifx\@thesistype\@tmp{}Master of Science (M.Sc.)\fi%
        \def\@tmp{phd}\ifx\@thesistype\@tmp{}Doktor-Ingenieur (Dr.-Ing.)\fi%
    }
    \def\@dateString{Date}
    \if@dategiven\else
        \def\@date{\today}
    \fi
    \renewcommand{\abstractname}{Abstract}
    \def\@dedicationname{Dedication}
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
\def\matriculation#1{\def\@matriculationstring{#1}\@matriculationtrue}
\def\major#1{\def\@majorstring{#1}}
\def\date#1{\def\@date{\iflanguage{english}{\isodate}{\numdate}\printdate{#1}}\@dategiventrue}
%\def\date#1{\def\@date{\origdate\printdate{#1}}\@dategiventrue}
\def\title#1{\def\@titlestring{#1}}
\def\subtitle#1{\def\@subtitlestring{#1}\@subtitletrue}
\def\partner#1{\def\@partnerstring{#1}\@partnertrue}
\def\partnerLogo#1{\def\@partnerLogostring{#1}\@partnerlogotrue}
\def\departmentname#1{\def\@departmentNameString{#1}}
\def\LogoUniversity#1{\def\@LogoUniversity{#1}}
\def\LogoUniversityheight#1{\def\@LogoUniversityHeight{#1}}
\def\LogoDepartment#1{\def\@LogoDepartment{#1}}
\def\LogoDepartmentheight#1{\def\@LogoDepartmentHeight{#1}}


%%%%%%%%%%
% MAKETITLE FOR ISW THESES
%%%%%%%%%%
\def\maketitle{
    \def\categoryfont{\sffamily\itshape}
    \thispagestyle{empty}
    \begin{titlepage}%
        \begin{center}
            \@LogoUniversity
            
            % Type of thesis
            \vspace{1cm}
            {\categoryfont\Large\@thesistypestring} \par
            \vspace{0.4cm}
            % Title
            \begingroup
                \LARGE\bfseries\@titlestring\hfill \par
            \endgroup
            % Subtitle
            \vspace{0.4cm}
            \large\bfseries
            \if@subtitle
                \@subtitlestring \par
            \else
                \vspace{\baselineskip}\vspace{\parskip}
            \fi
            \normalsize\normalfont \par
            
            % Vorlaeufige Version / Draft
            \categoryfont\Huge \par
            \if@thesisdraft
                \@preliminaryVersionString
            \else
                \vspace{\baselineskip}\vspace{\parskip}
            \fi
            \normalsize\normalfont \par
            
            \vspace{0.5\baselineskip}
            
            \@submittedByString
            
            \vspace{0.5\baselineskip}
            
            % Author and matriculation number
            \begingroup
                % Author
                {\sffamily\itshape\Large\@authorstring\mdseries \par}
                \normalsize\normalfont \par
                
                % Matriculation number
                \large\mdseries \par
                \if@matriculation
                    \@matriculationstring
                \else
                    \vspace{\baselineskip}\vspace{\parskip}
                \fi
            \endgroup%
            \normalsize\normalfont\par
            %
            % Datum
            \@submittedOnString
            
            \vspace{0.5\baselineskip}
            %
            {\large\@date} \par
            \normalsize\normalfont \par
            %
            \vfill
            %
            \@pretextString
            %
            \vfill%
            %
            \begin{minipage}[t]{0.5\linewidth}
                \flushleft
                % Supervisor Block
                % Examiner
                {\footnotesize\categoryfont\@examinerString}\\
                {\normalsize\@examinerName} \par
                \vspace{0.3cm}
                % Supervisor
                {\footnotesize\categoryfont\@supervisorstring}\\
                \@supervisorstringA\@supervisorstringB\@supervisorstringC\@supervisorstringD \par
            \end{minipage}%
            %
            \begin{minipage}[t]{0.5\linewidth}
                \flushright
                % Graduate Programme
                {\footnotesize\categoryfont\@majorpretextString}\\
                \@majorstring \par
            \end{minipage}%
            
            \vfill
            %
            \begin{minipage}[c]{0.8\linewidth}
                \begin{flushleft}
                    \small\@departmentNameString
                \end{flushleft}
            \end{minipage}%
            \begin{minipage}[c]{0.2\linewidth}
                \begin{flushright}
                    \@LogoDepartment
                \end{flushright}
            \end{minipage}
        \end{center}
        \vspace*{-2.5cm}
    \end{titlepage}
    \if@oneside
        \clearpage
    \else
        \cleardoublepage
    \fi
}

%%%%%%%%%%
% Abstract of the thesis
%%%%%%%%%%
\newenvironment{thesis-abstract}{%
    \chapter*{\abstractname}
    \addcontentsline{toc}{chapter}{\abstractname}
%    \vspace{\baselineskip}\vspace{\parskip}
    \begin{RaggedRight}
}{%
\end{RaggedRight}
\if@oneside
    \clearpage
\else
    \cleardoublepage
\fi
}

%%%%%%%%%%
% Dedication environment
%%%%%%%%%%
\renewenvironment{dedication}{%
    \chapter*{\@dedicationname}
%    \vspace{\baselineskip}\vspace{\parskip}
    \begin{RaggedRight}
}{%
\end{RaggedRight}
\if@oneside
    \clearpage
\else
    \cleardoublepage
\fi
}

%%%%%%%%%%
% Command to set front matter specific things
%%%%%%%%%%
\newcommand{\frontmatter}{%
    \if@oneside
        \clearpage
    \else
        \cleardoublepage
    \fi
    \pagenumbering{Roman}
}

%%%%%%%%%%
% Command to set main matter specific things
%%%%%%%%%%
\newcommand{\mainmatter}{%
    \if@oneside
        \clearpage
    \else
        \cleardoublepage
    \fi
    \pagenumbering{arabic}
}

%%%%%%%%%%
% Code for fancy chapters heading
%%%%%%%%%%
\RequirePackage{fncychap}
\makeatletter
\ChNameVar{\normalfont\Large\scshape} % sets the style for name
\ChNumVar{\fontsize{85}{100}\selectfont\sffamily\color{white}}
\ChTitleVar{\normalfont\Huge\scshape\color{black}\raggedleft}
\renewcommand{\DOCH}{%
    \setlength{\fboxrule}{\RW}
    \makebox[\linewidth][r]{
        \rotatebox{90}{
            \makebox[2cm][l]{
                \resizebox{2.5cm}{!}{ %\fboxsep=6pt
                    \CNV\FmN{\space\@chapapp}
                }
            }
        }
        \resizebox{!}{2.5cm}{\fboxsep=6pt
            \CNoV\colorbox{black!40}{\thechapter}
        }
    }%
    \par\nobreak
    \vskip 0\p@
}
\renewcommand{\DOTI}[1]{%
    \CTV\FmTi{#1}\par\nobreak
    \vskip 40\p@}
\renewcommand{\DOTIS}[1]{%
    \CTV\FmTi{#1}\par\nobreak
    \vskip 40\p@}
\makeatother

% Input all the packages that this class provides (keeps this file's lines less)
\input{config/packages.tex}
\input{config/commands.tex}
\input{config/colors.tex}

\endinput
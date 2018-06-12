% Definition of class version and last release date
\def\fileversion{1.5.1}
\def\filedate{2018/06/12}

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

\input{common/packages-head}
\input{iswartcl/packages-head}



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
\input{common/class-options}


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

\input{common/packages-options}
\input{iswartcl/packages-options}



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

\input{common/packages-main}
\input{iswartcl/packages-main}

% Some packages from other authors may have problems with KOMA-Script. In my opinion some packages could be improved. With some packages this makes only sense, if KOMA-Script was used. With some other packages the package author has another opinion. Sometimes proposals was never answered. Package scrhack contains all those improvement proposals for other packages. This means, scrhack redefines macros of pack- ages from other authors! The redefinitions are only activated, if those packages were loaded. Users may prevent scrhack from redefining macros of individual packages.
\RequirePackage{scrhack}

\input{common/tikz-packages}
\input{iswartcl/tikz-packages}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define colors                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/colors}
\input{common/colors-hyperref}
\input{iswartcl/colors}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONFIGURE PACKAGES          												  %%
%% (needs color information)                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/packages-post}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define environments                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/environments}
\input{iswartcl/environments}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define commands                                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/commands}
\input{iswartcl/commands}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Localization                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{iswartcl/localization}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure layout                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/layout}
\input{iswartcl/layout}

\input{common/coverpage}
\input{iswartcl/titlepage}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some cleanup tasks                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\mainmatter}{}%
\let\originalmainmatter\mainmatter%
\renewcommand{\mainmatter}{%
  \input{common/mainmatter}
  \input{iswartcl/mainmatter}
}%

\ifdraft{
  \input{common/ifdraft}
  \input{iswartcl/ifdraft}
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
  \input{common/makeatletter}
  \input{iswartcl/makeatletter}
\makeatother

\AtBeginDocument{%
  \input{common/atbegindocument}
  \input{iswartcl/atbegindocument}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of file                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput

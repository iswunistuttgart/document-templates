% Definition of class version and last release date
\def\fileversion{1.0.0-dev}
\def\filedate{2016/11/22}

% Definition of the actual class interface
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{student}[\filedate\space Version \fileversion\space by Philipp Tempel <philipp.tempel@isw.uni-stuttgart.de>]

% Typeout a notice
\typeout{}
\typeout{ISW - Institute for Control Engineering of Machine Tools}
\typeout{      and Manufacturing Units, University Stuttgart}
\typeout{      Document class for student theses}
\typeout{      Version \fileversion\space(\filedate) }
\typeout{}

\input{student/packages-head}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Class Configuration                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Configure the kvoptions-package
\SetupKeyvalOptions{%
    family=thesis, %
    prefix=thesis@, %
}

% Declare debug options
\DeclareBoolOption{debug}

% Declare print and online style (complementary)
\DeclareBoolOption{print}
\DeclareComplementaryOption{online}{print}

% Declare the document type
\def\thesis@type{bachelor}
\DeclareOption{bachelor}{\def\thesis@type{bachelor}}
\DeclareOption{bachelor-description}{\def\thesis@type{description-bachelor}}
\DeclareOption{bachelor-project}{\def\thesis@type{bachelor-project}}
\DeclareOption{master}{\def\thesis@type{master}}
\DeclareOption{master-description}{\def\thesis@type{description-master}}
\DeclareOption{study}{\def\thesis@type{study}}

% Allow user to choose language
\def\thesis@lang{ngerman}
\DeclareOption{ngerman}{\def\thesis@lang{ngerman}}
\DeclareOption{german}{\def\thesis@lang{ngerman}}
\DeclareOption{english}{\def\thesis@lang{english}}


% Pass any other options not known to the scrbook package
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

% Default options
\ExecuteOptions{bachelor, ngerman, draft, a4paper, twoside, cleardoublepage=empty, open=right}

% Process options passed to the class
\ProcessKeyvalOptions{thesis}

% Process options (finally)
\ProcessOptions\relax

\wlog{thesis lang is \thesis@lang}
\wlog{thesis type is \thesis@type}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Defaults for packages used                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{student/packages-options}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Necessary Packages                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass{scrbook}

% The package is part of the Koma-Script bundle, that provides an end user interface above scrlayer, to define and manage page styles, controlling page headers and footers. The end user interface is as much compatible to that of the earlier scrpage2 package, that users should easily be able to switch from the older package to the new, more powerful, one.
\RequirePackage{scrlayer-scrpage}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Debug Packages                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debug options
\ifthesis@debug
    \usepackage{showframe}
% Non-debug options
\else
    
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load All Other Packages                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{student/packages-main}

\input{student/packages-tikz}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define colors                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{student/colors}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define environments                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{student/environments}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define commands                                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{student/commands}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Localization                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{student/localization}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure layout                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{student/layout}

%\input{student/titlepage}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some cleanup tasks                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\originalmainmatter\mainmatter%
\renewcommand{\mainmatter}{%
    \originalmainmatter%
    \arrayrulecolor{ArrayRuleColor}%
}%

% Set the overfullrule to 5pt if we are in thesisdraft mode
\ifdraft{
    \overfullrule=5pt
}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Make @ Letter and at Begin Document                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter%
    \input{student/makeatletter}
\makeatother

\AtBeginDocument{%
    \input{student/atbegindocument}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of file                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
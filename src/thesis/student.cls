% Definition of class version and last release date
\def\fileversion{0.9.0}
\def\filedate{2016/11/01}

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

%  The pack­age is a tool­box of pro­gram­ming fa­cil­i­ties geared pri­mar­ily to­wards LaTeX class and pack­age au­thors. It pro­vides LaTeX fron­tends to some of the new prim­i­tives pro­vided by e-TeX as well as some generic tools which are not strictly re­lated to e-TeX but match the pro­file of this pack­age. Note that the ini­tial ver­sions of this pack­age were re­leased un­der the name ela­tex.
% The pack­age pro­vides func­tions that seem to of­fer al­ter­na­tive ways of im­ple­ment­ing some LaTeX ker­nel com­mands; nev­er­the­less, the pack­age will not mod­ify any part of the LaTeX ker­nel. 
\RequirePackage{etoolbox}

% The package defines commands that switch according to the prevailing ‘draft’ or ‘final’ options; each command takes two arguments, the first for the ‘true’, the second for the ‘false’ case. Commands are:
%   \ifdraft determines whether we're operating in draft (‘true’) or final mode;
%   \ifoptiondraft determines whether a ‘draft’ option has been given; and
%   \ifoptionfinal determines whether a ‘final’ option has been given.
\RequirePackage{ifdraft}

% This pack­age of­fers sup­port for pack­age au­thors who want to use op­tions in key-value for­mat for their pack­age op­tions.
% The pack­age is part of the oberdiek bun­dle.
\RequirePackage{kvoptions}
\SetupKeyvalOptions{%
    family=thesis, %
    prefix=thesis@, %
}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Class Configuration                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

\input{student/packages-defaults}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Necessary Packages                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass{scrbook}

\input{student/packages-required}



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

\input{student/packages-other}

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

\addto{\captionsenglish}{%
    \input{student/localization/english}%
}

\addto{\captionsngerman}{%
    \input{student/localization/german}%
}





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
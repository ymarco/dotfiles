\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2021/10/19 Marco's homework class]


\newif\ifenglish
\DeclareOption{english}{
  \englishtrue
}
\newif\ifhebrew
\DeclareOption{hebrew}{
  \hebrewtrue
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions \relax
\LoadClass{article}

\ifenglish \RequirePackage{homework-english}\fi
\ifhebrew \RequirePackage{homework-hebrew}\fi

%\RequirePackage{xcolor}
%\RequirePackage{amsmath}                        % math envs: align, gather...
%\RequirePackage{amssymb}                        % math symbols
%\RequirePackage{mathtools}                      % overbrace, multilined
%% \RequirePackage{breqn}                              % better line breaks in math
%\RequirePackage[a4paper,margin=1.1in]{geometry} % margins setup


\newcommand{\newquestion}{%
    \@startsection%
    {section}{1}{0pt}{-1.5ex plus -1ex minus -.2ex}%
    {1ex plus .2ex}{\large\sffamily\slshape\headlinecolor}%
}
\newcommand{\newsubsubquestion}{%
    \@startsection
    {section}{1}{0pt}{-1.5ex plus -1ex minus -.2ex}%
    {1ex plus .2ex}{\large\sffamily\slshape\headlinecolor}%
}
\newcommand{\newsubquestion}{%
    \@startsection
    {section}{1}{0pt}{-1.5ex plus -1ex minus -.2ex}%
    {1ex plus .2ex}{\large\sffamily\slshape\headlinecolor}%
}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{impaTeXPoster}[2026/04/20 My Custom LaTeX Class - Combined Version]

\LoadClass{article}

% ==================================================
% PACKAGES
% ==================================================
\RequirePackage{xcolor}
\RequirePackage{xparse}
\RequirePackage[most]{tcolorbox}
\RequirePackage{multicol}
\RequirePackage{geometry}
\RequirePackage{kvoptions}
\RequirePackage{ifthen}

% ==================================================
% OPTIONS SYSTEM
% ==================================================
\SetupKeyvalOptions{
    family=impa,
    prefix=impa@
}

\DeclareStringOption[basic]{palette}
\DeclareStringOption[light]{mode}

\ProcessKeyvalOptions*

% ==================================================
% BASE COLORS & THEMES (MARIA'S SPECTRUM)
% ==================================================
\definecolor{white}{HTML}{F3F3F3}
\definecolor{black}{HTML}{000000}
\definecolor{beige}{HTML}{CCC4AF}
\definecolor{pink}{HTML}{FF8AEF}
\definecolor{orange}{HTML}{FFC555}
\definecolor{yellow}{HTML}{ECF47A}
\definecolor{green}{HTML}{BEFF88}

% PINK EXTENSION
\definecolor{pink50}{HTML}{F7BEF4}
\definecolor{pink75}{HTML}{F59FED}
\definecolor{pink100}{HTML}{FF8AEF}
\definecolor{pink200}{HTML}{F073E0}
\definecolor{pink300}{HTML}{E35DD4}
\definecolor{pink400}{HTML}{D646C7}

% YELLOW EXTENSION
\definecolor{yellow50}{HTML}{F7F7B2}
\definecolor{yellow75}{HTML}{F5F79B}
\definecolor{yellow100}{HTML}{ECF47A}
\definecolor{yellow200}{HTML}{EDF15D}
\definecolor{yellow300}{HTML}{EDEE40}
\definecolor{yellow400}{HTML}{EEEA24}

% ORANGE EXTENSION
\definecolor{orange50}{HTML}{F7D296}
\definecolor{orange75}{HTML}{F7CB80}
\definecolor{orange100}{HTML}{FFC555}
\definecolor{orange200}{HTML}{F9B74B}
\definecolor{orange300}{HTML}{F9AA41}
\definecolor{orange400}{HTML}{FCA72B}

% GREEN EXTENSION
\definecolor{green50}{HTML}{DEF7C5}
\definecolor{green75}{HTML}{D1FAAF}
\definecolor{green100}{HTML}{BDF58B}
\definecolor{green200}{HTML}{A6F865}
\definecolor{green300}{HTML}{91F340}
\definecolor{green400}{HTML}{7BEE1B}

% Functional Color Defaults
\colorlet{MainColor}{beige}
\colorlet{TextColor}{black}
\colorlet{BackgroundColor}{white}
\colorlet{MainTitle}{black}
\colorlet{TitleBackgroundColor}{beige}
\colorlet{TextBackgroundColor}{beige}

% ==================================================
% PALETTES CONFIGURATION
% ==================================================
\ifthenelse{\equal{\impa@palette}{basic}}{
    \colorlet{TitleBackgroundColor}{beige}
    \colorlet{TextBackgroundColor}{beige}
}{}

\ifthenelse{\equal{\impa@palette}{green}}{
    \colorlet{TitleBackgroundColor}{green}
    \colorlet{TextBackgroundColor}{green50}
}{}

\ifthenelse{\equal{\impa@palette}{pink}}{
    \colorlet{TitleBackgroundColor}{pink}
    \colorlet{TextBackgroundColor}{pink50}
}{}

\ifthenelse{\equal{\impa@palette}{orange}}{
    \colorlet{TitleBackgroundColor}{orange}
    \colorlet{TextBackgroundColor}{orange50}
}{}

\ifthenelse{\equal{\impa@palette}{yellow}}{
    \colorlet{TitleBackgroundColor}{yellow}
    \colorlet{TextBackgroundColor}{yellow50}
}{}

\ifthenelse{\equal{\impa@palette}{none}}{
    \colorlet{TitleBackgroundColor}{white}
    \colorlet{TextBackgroundColor}{white}
    \colorlet{MainColor}{white} 
}{}

% ==================================================
% MODE SYSTEM (DARK / LIGHT)
% ==================================================
\ifthenelse{\equal{\impa@mode}{dark}}{
    \colorlet{MainColor}{black}
    \colorlet{MainTitle}{white}
    \colorlet{BackgroundColor}{black}

    \ifthenelse{\equal{\impa@palette}{none}}{
        \colorlet{TitleBackgroundColor}{black}
        \colorlet{TextBackgroundColor}{black}
        \colorlet{TextColor}{white}
    }{
        \ifthenelse{\equal{\impa@palette}{basic}}{
            \colorlet{TitleBackgroundColor}{gray}
            \colorlet{TextBackgroundColor}{black!80}
            \colorlet{TextColor}{white}
        }{
            \colorlet{TextColor}{black}
        }
    }
}{
    % Light mode inherits palette configurations
}

\ProcessOptions\relax


\makeatletter
\newcommand{\institute}[1]{\gdef\@institute{#1}} % Define o comando \institute
\newcommand{\@institute}{} % Inicializa vazio caso o usuário não use

\renewcommand{\maketitle}{
    \begin{center}
        {\Huge\bfseries \color{MainTitle} \@title \par}
        \vspace{0.8em}
        {\Large \color{MainTitle} \@author \par}
        \vspace{0.4em}
        {\large \itshape \color{MainTitle} \@institute \par} % Exibe o instituto em itálico
        \vspace{0.4em}
        {\large \color{MainTitle} \@date \par}
    \end{center}
    \vspace{2em}
}
\makeatother


% ==================================================
% STRUCTURE & CARDS (IGOR'S IMPLEMENTATION)
% ==================================================

% Modificado para aceitar até 4 argumentos opcionais de forma segura:
% #1 = Cor de Fundo do Título (Pílula)
% #2 = Cor de Fundo da Caixa
% #3 = Cor do Texto do Título/Conteúdo Geral
% #4 = Cor do Texto específico de dentro do card (caso queira sobrescrever o #3)
% #5 = Título do card (Obrigatório)
\NewDocumentEnvironment{postercard}{
    O{TitleBackgroundColor} 
    O{TextBackgroundColor} 
    O{TextColor} 
    O{#3} 
    m
}{%
    \begin{tcolorbox}[
        enhanced,
        colback=#2,                           % Fundo da caixa
        colframe=#1,                          % Borda da caixa
        coltitle=#3,                          % Cor do texto do título
        fonttitle=\bfseries\large,
        coltext=#4,                           % Cor do texto do conteúdo
        title={#5},                           % Texto do título
        attach boxed title to top center={yshift=-3mm,yshifttext=-1mm},
        boxed title style={
            colback=#1,                       % Fundo da pílula
            arc=2mm,
            outer arc=1mm,
        },
        arc=0mm,
        boxrule=1.5pt,                        % Espessura da borda adaptada para posters
        top=4mm,
    ]%
}{%
    \end{tcolorbox}
}

% ==================================================
% DOCUMENT OVERRIDES & LAYOUT
% ==================================================
\AtBeginDocument{
    \pagecolor{BackgroundColor} 
    \color{TextColor}
    \renewcommand{\refname}{Referências}
}

% Personalização do Bloco do Título Principal
\makeatletter
\renewcommand{\maketitle}{
    \begin{center}
        {\Huge\bfseries \color{MainTitle} \@title \par}
        \vspace{1em}
        {\Large \color{MainTitle} \@author \par}
        \vspace{0.5em}
        {\large \color{MainTitle} \@date \par}
    \end{center}
    \vspace{2em}
}
\makeatother

\pagenumbering{gobble}

% Configuração das Dimensões do Poster
\setlength{\paperwidth}{210mm}
\setlength{\paperheight}{297mm}
\setlength{\textwidth}{160mm}
\setlength{\textheight}{240mm}
\setlength{\topmargin}{0pt}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}
\setlength{\headheight}{30pt}
\setlength{\headsep}{30pt}

\endinput
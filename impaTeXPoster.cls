\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{impaTeXPoster}[2026/05/21 My Custom LaTeX Class]

% ==================================================
% 1. EARLY PACKAGES
% ==================================================
\RequirePackage{kvoptions}
\RequirePackage{ifthen}
\RequirePackage{xcolor}

\DeclareVoidOption*{
    \PassOptionsToClass{\CurrentOption}{tikzposter}
}

% ==================================================
% 2. OPTIONS SYSTEM
% ==================================================
\SetupKeyvalOptions{
    family=impa,
    prefix=impa@
}

\DeclareStringOption[basic]{palette}
\DeclareStringOption[light]{mode}

\ProcessKeyvalOptions*

% ==================================================
% 3. LOAD BASE CLASS
% ==================================================
\LoadClass[a0paper,portrait]{tikzposter}

% ==================================================
% 4. LATE PACKAGES
% ==================================================
\RequirePackage{xparse}
\RequirePackage[most]{tcolorbox}

% ==================================================
% 5. COLOR DEFINITIONS (Maria's Palette)
% ==================================================
\definecolor{white}{HTML}{F3F3F3}
\definecolor{black}{HTML}{000000}
\definecolor{beige}{HTML}{CCC4AF}
\definecolor{pink}{HTML}{FF8AEF}
\definecolor{orange}{HTML}{FFC555}
\definecolor{yellow}{HTML}{ECF47A}
\definecolor{green}{HTML}{BEFF88}

% Extended Pink
\definecolor{pink50}{HTML}{F7BEF4}
\definecolor{pink75}{HTML}{F59FED}
\definecolor{pink100}{HTML}{FF8AEF}
\definecolor{pink200}{HTML}{F073E0}
\definecolor{pink300}{HTML}{E35DD4}
\definecolor{pink400}{HTML}{D646C7}

% Extended Yellow
\definecolor{yellow50}{HTML}{F7F7B2}
\definecolor{yellow75}{HTML}{F5F79B}
\definecolor{yellow100}{HTML}{ECF47A}
\definecolor{yellow200}{HTML}{EDF15D}
\definecolor{yellow300}{HTML}{EDEE40}
\definecolor{yellow400}{HTML}{EEEA24}

% Extended Orange
\definecolor{orange50}{HTML}{F7D296}
\definecolor{orange75}{HTML}{F7CB80}
\definecolor{orange100}{HTML}{FFC555}
\definecolor{orange200}{HTML}{F9B74B}
\definecolor{orange300}{HTML}{F9AA41}
\definecolor{orange400}{HTML}{FCA72B}

% Extended Green
\definecolor{green50}{HTML}{DEF7C5}
\definecolor{green75}{HTML}{D1FAAF}
\definecolor{green100}{HTML}{BDF58B}
\definecolor{green200}{HTML}{A6F865}
\definecolor{green300}{HTML}{91F340}
\definecolor{green400}{HTML}{7BEE1B}

% ==================================================
% 6. DYNAMIC PALETTE ALLOCATION
% ==================================================
% Criando variáveis internas para não dar conflito com o tikzposter
\newcommand{\dynTitleBG}{beige}
\newcommand{\dynTextBG}{beige}
\newcommand{\dynTextFG}{black}
\newcommand{\dynCanvasBG}{white}

% Lógica das paletas
\ifthenelse{\equal{\impa@palette}{basic}}{
    \renewcommand{\dynTitleBG}{beige}\renewcommand{\dynTextBG}{beige}}{}
\ifthenelse{\equal{\impa@palette}{green}}{
    \renewcommand{\dynTitleBG}{green}\renewcommand{\dynTextBG}{green50}}{}
\ifthenelse{\equal{\impa@palette}{pink}}{
    \renewcommand{\dynTitleBG}{pink}\renewcommand{\dynTextBG}{pink50}}{}
\ifthenelse{\equal{\impa@palette}{orange}}{
    \renewcommand{\dynTitleBG}{orange}\renewcommand{\dynTextBG}{orange50}}{}
\ifthenelse{\equal{\impa@palette}{yellow}}{
    \renewcommand{\dynTitleBG}{yellow}\renewcommand{\dynTextBG}{yellow50}}{}
\ifthenelse{\equal{\impa@palette}{none}}{
    \renewcommand{\dynTitleBG}{white}\renewcommand{\dynTextBG}{white}\renewcommand{\dynCanvasBG}{white}}{}

% Lógica do Modo Escuro (Dark Mode)
\ifthenelse{\equal{\impa@mode}{dark}}{
    \renewcommand{\dynCanvasBG}{black}
    \renewcommand{\dynTextFG}{white}
    \ifthenelse{\equal{\impa@palette}{none}}{
        \renewcommand{\dynTitleBG}{black}\renewcommand{\dynTextBG}{black}
    }{
        \ifthenelse{\equal{\impa@palette}{basic}}{
            \renewcommand{\dynTitleBG}{gray}\renewcommand{\dynTextBG}{black!80}
        }{
            \renewcommand{\dynTextFG}{black} % Mantém texto escuro sobre fundo colorido
        }
    }
}{}

% ==================================================
% 7. TIKZPOSTER COMPATIBILITY LAYER
% ==================================================
% Força o tikzposter a registrar e aceitar o nosso mapa de cores dinâmicas
\definecolorstyle{impaThemeColors}{}{
    \colorlet{backgroundcolor}{\dynCanvasBG}
    \colorlet{framecolor}{\dynTitleBG}
    \colorlet{titlebgcolor}{\dynTitleBG}
    \colorlet{titlefgcolor}{\dynTextFG}
    \colorlet{blocktitlebgcolor}{\dynTitleBG}
    \colorlet{blocktitlefgcolor}{\dynTextFG}
    \colorlet{blockbodybgcolor}{\dynTextBG}
    \colorlet{blockbodyfgcolor}{\dynTextFG}
}
\usetheme{Basic}
\usecolorstyle{impaThemeColors}

% ==================================================
% 8. CUSTOM ENVIRONMENTS
% ==================================================
\ExplSyntaxOn
\NewDocumentCommand{\parsepostercardcolors}{m}{
  \int_zero:N \l_tmpa_int
  \clist_map_inline:nn { #1 } {
    \int_incr:N \l_tmpa_int
    \int_case:nnF { \l_tmpa_int } {
      { 1 } { \colorlet{customTitleBG}{##1} }
      { 2 } { \colorlet{customTextBG}{##1} }
      { 3 } { \colorlet{customTextFG}{##1} }
    } { }
  }
}
\ExplSyntaxOff

\NewDocumentEnvironment{postercard}{O{} m +b}
{
    \begingroup
    \ifthenelse{\equal{#1}{}}{
        % Padrão: Usa a cor da paleta alocada
        \colorlet{blocktitlebgcolor}{\dynTitleBG}
        \colorlet{blockbodybgcolor}{\dynTextBG}
        \colorlet{blocktitlefgcolor}{\dynTextFG}
        \colorlet{blockbodyfgcolor}{\dynTextFG}
    }{
        % Customizado por vírgula
        \colorlet{customTitleBG}{\dynTitleBG}
        \colorlet{customTextBG}{\dynTextBG}
        \colorlet{customTextFG}{\dynTextFG}
        \parsepostercardcolors{#1}
        \colorlet{blocktitlebgcolor}{customTitleBG}
        \colorlet{blockbodybgcolor}{customTextBG}
        \colorlet{blocktitlefgcolor}{customTextFG}
        \colorlet{blockbodyfgcolor}{customTextFG}
    }
    \block{#2}{#3}
    \endgroup
}
{}

\AtBeginDocument{
    \renewcommand{\refname}{\vspace{-3cm}}
}

\endinput
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
% 4b. TITLE METADATA COMMANDS
% ==================================================
\RequirePackage{graphicx}

% Logo
\newcommand{\posterlogo}[1]{\def\impa@logo{#1}}
\def\impa@logo{}

% Autores e emails como listas separadas por \\
\renewcommand{\author}[1]{\def\impa@authors{#1}}
\newcommand{\authoremail}[1]{\def\impa@emails{#1}}
\def\impa@authors{}
\def\impa@emails{}

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
% 6. DYNAMIC PALETTE ALLOCATION (ESTRUTURA NOVA)
% ==================================================
% 1. Inicializa os nomes das cores com valores padrão (Fallback)
\colorlet{impaCanvas}{white}
\colorlet{impaTitleBG}{beige}
\colorlet{impaTextFG}{black}
\colorlet{impaBlockBG}{beige}
\colorlet{impaTextTitle}{black}

% 2. Aplica a paleta escolhida pelo usuário via if/else
\ifthenelse{\equal{\impa@palette}{green}}{
    \colorlet{impaTitleBG}{green}
    \colorlet{impaBlockBG}{green50}
}{
\ifthenelse{\equal{\impa@palette}{pink}}{
    \colorlet{impaTitleBG}{pink}
    \colorlet{impaBlockBG}{pink50}
}{
\ifthenelse{\equal{\impa@palette}{orange}}{
    \colorlet{impaTitleBG}{orange}
    \colorlet{impaBlockBG}{orange50}
}{
\ifthenelse{\equal{\impa@palette}{yellow}}{
    \colorlet{impaTitleBG}{yellow}
    \colorlet{impaBlockBG}{yellow50}
}{
\ifthenelse{\equal{\impa@palette}{none}}{
    \colorlet{impaCanvas}{white}
    \colorlet{impaTitleBG}{white}
    \colorlet{impaBlockBG}{white}
}{
    % Caso seja 'basic' ou qualquer outra coisa
    \colorlet{impaTitleBG}{beige}
    \colorlet{impaBlockBG}{beige}
}}}}}

% 3. Aplica a modificação do Modo Escuro (Dark Mode Override)
\ifthenelse{\equal{\impa@mode}{dark}}{
    \colorlet{impaCanvas}{black}
    \colorlet{impaTextFG}{white}
    \colorlet{impaTextTitle}{white}
    
    \ifthenelse{\equal{\impa@palette}{none}}{
        \colorlet{impaTitleBG}{black}
        \colorlet{impaBlockBG}{black}
    }{
        \ifthenelse{\equal{\impa@palette}{basic}}{
            \colorlet{impaTitleBG}{gray}
            \colorlet{impaBlockBG}{black!80}
        }{
            % Para paletas coloridas (green, pink, etc.) no modo dark:
            \colorlet{impaTextFG}{black} 
        }
    }
}{}

% ==================================================
% 7. TIKZPOSTER COMPATIBILITY LAYER
% ==================================================
% Agora sim o Tikzposter lê as cores reais mapeadas diretamente!
\definecolorstyle{impaThemeColors}{}{
    \colorlet{backgroundcolor}{impaCanvas}
    \colorlet{framecolor}{impaTitleBG}
    \colorlet{titlebgcolor}{impaTitleBG}
    \colorlet{titlefgcolor}{impaTextTitle}        
    \colorlet{blocktitlebgcolor}{impaTitleBG}
    \colorlet{blocktitlefgcolor}{impaTextFG}
    \colorlet{blockbodybgcolor}{impaBlockBG}
    \colorlet{blockbodyfgcolor}{impaTextFG}
}

\usetheme{Basic}
\usecolorstyle{impaThemeColors}
\colorlet{titlebgcolor}{impaTitleBG}
\colorlet{titlefgcolor}{impaTextTitle}

% ==================================================
% 7b. CUSTOM TITLE BLOCK
% ==================================================

\newcommand{\impa@sep}{\quad\textbullet\quad}

\newcommand{\inlinelist}[1]{%
    \def\impa@first{1}%
    \@for\impa@item:=#1\do{%
        \if\impa@first1\def\impa@first{0}\else\impa@sep\fi
        \impa@item
    }%
}

% Novo titlestyle que usa titleposbottom/titlepostop (cobre exatamente o conteúdo)
\definetitlestyle{ImpaFilled}{
    width=\paperwidth,
    roundedcorners=0,
    linewidth=0pt,
    innersep=1.5cm,
    titletotopverticalspace=0mm,
    titletoblockverticalspace=20mm,
    titlegraphictotitledistance=10pt
}{%
    \draw[draw=none,fill=titlebgcolor]
    (\titleposleft,\titleposbottom)
    rectangle
    (\titleposright,\titlepostop);%
    \draw[color=black,line width=2pt]
    (\titleposleft,\titleposbottom)
    --
    (\titleposright,\titleposbottom);%
}

\usetitlestyle{ImpaFilled}

\gdef\TP@maketitle{%
    \begin{minipage}[c]{0.75\linewidth}
        \raggedright
        {\bfseries\Huge\color{titlefgcolor}\@title\par}
        \vspace{0.6em}
        {\large\color{titlefgcolor}\inlinelist{\impa@authors}\par}
        \ifx\impa@emails\empty\else
            \vspace{0.3em}
            {\small\ttfamily\color{titlefgcolor}\inlinelist{\impa@emails}\par}
        \fi
    \end{minipage}%
    \hfill
    \begin{minipage}[c]{0.20\linewidth}
        \raggedleft
        \ifx\impa@logo\empty\else
            \includegraphics[width=\linewidth]{\impa@logo}
        \fi
    \end{minipage}%
}

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
        % Padrão: Usa a cor da paleta alocada dinamicamente
        \colorlet{blocktitlebgcolor}{impaTitleBG}
        \colorlet{blockbodybgcolor}{impaBlockBG}
        \colorlet{blocktitlefgcolor}{impaTextFG}
        \colorlet{blockbodyfgcolor}{impaTextFG}
    }{
        % Customizado por vírgula (Mapeia a partir das novas cores base)
        \colorlet{customTitleBG}{impaTitleBG}
        \colorlet{customTextBG}{impaBlockBG}
        \colorlet{customTextFG}{impaTextFG}
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

% ==================================================
% 9. FOOTER COMMAND
% ==================================================
\RequirePackage{qrcode}

\newlength{\impa@footerheight}
\newlength{\impa@footerpad}
\setlength{\impa@footerpad}{1.2cm}
\setlength{\impa@footerheight}{4.5cm}

\newcommand{\posterfooter}[2]{%
    % Fundo colorido
    \draw[draw=none, fill=impaTitleBG]
        (-0.5\textwidth, -0.5\textheight)
        rectangle
        (0.5\textwidth, {-0.5\textheight + \impa@footerheight});

    % Linha superior
    \draw[line width=1.5pt, color=black]
        (-0.5\textwidth, {-0.5\textheight + \impa@footerheight})
        -- (0.5\textwidth, {-0.5\textheight + \impa@footerheight});

    % Linha divisória vertical (75% | 25%)
    \draw[line width=1pt, color=black]
        ({0.5\textwidth - 0.22\textwidth}, {-0.5\textheight + \impa@footerheight - 0.3cm})
        -- ({0.5\textwidth - 0.22\textwidth}, {-0.5\textheight + 0.3cm});

    % Conteúdo esquerdo: referências
    \node[
        anchor=north west,
        inner sep=\impa@footerpad,
        text width={0.78\textwidth - 2\impa@footerpad},
        align=left
    ] at (-0.5\textwidth, {-0.5\textheight + \impa@footerheight}) {%
        {\color{impaTextFG}#2}%
    };

    % Conteúdo direito: QR code
    \node[anchor=center] 
        at ({0.5\textwidth - 0.11\textwidth}, {-0.5\textheight + 0.5\impa@footerheight}) {%
        \qrcode[height=3.5cm]{#1}%
    };
}

\endinput
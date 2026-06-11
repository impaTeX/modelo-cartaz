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

% Nova opção de fonte: Helvetica (sans-serif)
\RequirePackage[scaled=0.92]{helvet} 
\renewcommand{\familydefault}{\sfdefault}

% ==================================================
% 4a. FORMATAÇÃO GERAL — Margens, colunas, blocos
% ==================================================

\providecommand{\tikzposterlatexaffectionprooffalse}{}
\tikzposterlatexaffectionprooffalse

\setlength{\TP@blockverticalspace}{1.5cm}

\newlength{\impa@colspace}
\setlength{\impa@colspace}{1.2cm}

\newlength{\impa@blockinnersep}
\setlength{\impa@blockinnersep}{1.2cm}

\renewcommand{\normalsize}{%
    \fontsize{28}{36}\selectfont
}

% ==================================================
% 4b. PARÁGRAFOS E ESPAÇAMENTO (ABNT adaptado a poster)
% ==================================================

% ABNT NBR 14724 §5.3: recuo de 1,25 cm na primeira linha
% Em pôster, é aceitável trocar por espaço entre parágrafos
% (mais legível). Escolhemos espaço entre parágrafos sem recuo,
% pois é o ultilizado em pôsteres científicos.
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.6em}

% Espaçamento de lista (evitar blocos compactos demais)
\RequirePackage{enumitem}
\setlist{
    topsep    = 0.4em,
    itemsep   = 0.2em,
    parsep    = 0pt,
    leftmargin= 1.8em
}

% ==================================================
% 4c. LEGENDAS — ABNT NBR 14724 §5.8
% ==================================================
% Formato: "Figura N – Descrição" (travessão, não dois-pontos)
% Fonte: menor que o texto, negrito no rótulo
\RequirePackage{caption}
\captionsetup{
    format        = plain,
    labelsep      = endash, % " – " entre rótulo e texto
    font          = {normal}, % corpo da legenda menor
    labelfont     = {normal, bf}, % "Figura N" em negrito
    justification = centering, % centralizado
    singlelinecheck = false,
    skip          = 6pt % espaço entre figura e legenda
}
% Legendas de tabela: acima (ABNT) — lembre de colocar \caption antes de \includegraphics nas tabelas
\captionsetup[table]{position=above}
\captionsetup[figure]{position=below}

% Redefine os nomes para português (ABNT)
\AtBeginDocument{%
    \renewcommand{\figurename}{Figura}%
    \renewcommand{\tablename}{Tabela}%
}

% ==================================================
% 4d. TÍTULO DOS METADADOS
% ==================================================
\RequirePackage{graphicx}

% Logo esquerda
\newcommand{\posterlogo}[1]{\def\impa@rightlogo{#1}}
\def\impa@rightlogo{}

% Logo direita
\newcommand{\leftposterlogo}[1]{\def\impa@leftlogo{#1}}
\def\impa@leftlogo{}

% Autores e emails
\renewcommand{\author}[1]{\def\impa@authors{#1}}
\newcommand{\authoremail}[1]{\def\impa@emails{#1}}
\def\impa@authors{}
\def\impa@emails{}

% ==================================================
% 5. DEFINIÇÃO DE CORES (Paleta Maria)
% ==================================================
% COR DE TESTE — não usar em produção
\definecolor{red_dev_test}{HTML}{FF0000}

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
% 6. ALOCAÇÃO DINÂMICA DE PALETA
% ==================================================
\colorlet{impaCanvas}{white}
\colorlet{impaTitleBG}{beige}
\colorlet{impaTextFG}{black}
\colorlet{impaBlockBG}{beige}
\colorlet{impaTextTitle}{black}
\colorlet{impaBorderBlock}{black}
\colorlet{TitleColor}{black}

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
    \colorlet{impaBorderBlock}{white}
}{
    % paleta basic
    \colorlet{impaTitleBG}{beige}
    \colorlet{impaBlockBG}{beige}
}}}}}

% Override para modo escuro
\ifthenelse{\equal{\impa@mode}{dark}}{
    \colorlet{impaCanvas}{black}
    \colorlet{impaTextFG}{white}
    \colorlet{impaTextTitle}{white}
    \colorlet{impaBorderBlock}{black}
    \colorlet{TitleColor}{white}

    \ifthenelse{\equal{\impa@palette}{none}}{
        \colorlet{impaTitleBG}{black}
        \colorlet{impaBlockBG}{black}
    }{
        \ifthenelse{\equal{\impa@palette}{basic}}{
            \colorlet{impaTitleBG}{gray}
            \colorlet{impaBlockBG}{black!80}
            \colorlet{impaBorderBlock}{black!80}
        }{
            \colorlet{impaTextFG}{black}
%            \colorlet{impaTextColor}{black}
        }
    }
}{}

% ==================================================
% 7. CAMADA DE COMPATIBILIDADE TIKZPOSTER
% ==================================================
\definecolorstyle{impaThemeColors}{}{
    \colorlet{backgroundcolor}{impaCanvas}
    \colorlet{framecolor}{impaBorderBlock}
    \colorlet{titlebgcolor}{impaTitleBG}
    \colorlet{titlefgcolor}{impaTextTitle}
    \colorlet{blocktitlebgcolor}{impaTitleBG}
    \colorlet{blocktitlefgcolor}{TitleColor}
    \colorlet{blockbodybgcolor}{impaBlockBG}
    \colorlet{blockbodyfgcolor}{impaTextFG}
}

\usetheme{Basic}
\usecolorstyle{impaThemeColors}
\colorlet{titlebgcolor}{impaTitleBG}
\colorlet{titlefgcolor}{impaTextTitle}

% ==================================================
% 7b. BLOCO DE TÍTULO CUSTOMIZADO
% ==================================================
\newcommand{\impa@sep}{\quad\textbullet\quad}

\newcommand{\inlinelist}[1]{%
    \def\impa@first{1}%
    \@for\impa@item:=#1\do{%
        \if\impa@first1\def\impa@first{0}\else\impa@sep\fi
        \impa@item
    }%
}

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
\noindent
\makebox[\linewidth]{%
\begin{minipage}[c][8cm][c]{0.2\linewidth}
    \centering
    \ifx\impa@rightlogo\empty\else
        \includegraphics[height=20cm,width=15cm,keepaspectratio]{\impa@rightlogo}
    \fi
\end{minipage}%
\begin{minipage}[c][10cm][c]{0.6\linewidth}
    \centering
    {\fontsize{80}{78}\selectfont\bfseries
     \color{titlefgcolor}\@title\par}
    \vspace{0.6em}
    {\fontsize{50}{48}\selectfont
     \color{titlefgcolor}\inlinelist{\impa@authors}\par}
    \vspace{0.3em}
    {\fontsize{30}{36}\selectfont\ttfamily
     \color{titlefgcolor}\inlinelist{\impa@emails}\par}
\end{minipage}%
\begin{minipage}[c][8cm][c]{0.2\linewidth}
    \centering
    \ifx\impa@leftlogo\empty\else
        \includegraphics[height=10cm,width=15cm,keepaspectratio]{\impa@leftlogo}
    \fi
\end{minipage}%
}%
}

% ==================================================
% 8. AMBIENTES CUSTOMIZADOS
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
      { 4 } { \colorlet{customBorderBlock}{##1} }
      { 5 } { \colorlet{customTitleTextBlock}{##1} }
    } { }
  }
}
\ExplSyntaxOff

\NewDocumentEnvironment{postercard}{O{} m +b}
{
    \begingroup
    \ifthenelse{\equal{#1}{}}{
        \colorlet{blocktitlebgcolor}{impaTitleBG}
        \colorlet{blockbodybgcolor}{impaBlockBG}
        \colorlet{blocktitlefgcolor}{TitleColor}
        \colorlet{blockbodyfgcolor}{impaTextFG}
        \colorlet{framecolor}{impaBorderBlock}
    }{
        \colorlet{customTitleBG}{impaTitleBG}
        \colorlet{customTextBG}{impaBlockBG}
        \colorlet{customTextFG}{impaTextFG}
        \colorlet{customBorderBlock}{impaBorderBlock}
        \colorlet{customTitleTextBlock}{TitleColor}
        \parsepostercardcolors{#1}
        \colorlet{blocktitlebgcolor}{customTitleBG}
        \colorlet{blockbodybgcolor}{customTextBG}
        \colorlet{blocktitlefgcolor}{customTitleTextBlock}
        \colorlet{blockbodyfgcolor}{customTextFG}
        \colorlet{framecolor}{customBorderBlock}
    }
    \block{#2}{#3}
    \endgroup
}
{}

% Bloco sem borda/fundo (para figuras soltas)
\newcommand{\plainblock}[1]{
    \begingroup
    \colorlet{blockbodybgcolor}{backgroundcolor}
    \colorlet{framecolor}{backgroundcolor}
    \block{}{#1}
    \endgroup
}

% ==================================================
% 8b. COMANDO \posterfigure — figura com legenda ABNT
% ==================================================
% tikzposter NÃO suporta floats (figure, table com [H] etc.).
% Uma solução é o \captionof{figure}{...} do pacote caption,
% que formata a legenda sem precisar do ambiente float.
%
% Uso: \posterfigure{largura}{arquivo}{legenda}{label}
%
%   largura : fração de \linewidth, ex: 0.85
%   arquivo : caminho da imagem
%   legenda : texto da legenda (sem numeração manual)
%   label   : chave para \ref — use fig:nome

\NewDocumentCommand{\posterfigure}{m m m m}{%
    \begingroup
    \centering
    \includegraphics[width=#1\linewidth]{#2}\par
    \captionof{figure}{#3}\label{#4}%
    \endgroup
}

% ==================================================
% 8c. REFERÊNCIAS — ABNT NBR 6023:2018
% ==================================================
% Ordem alfabética (thebibliography já respeita a ordem manual;
% o autor deve inserir em ordem)
% Recuo de 1,25 cm
% Espaçamento simples entre linhas, linha em branco entre entradas
% Rótulo numérico oculto (ABNT usa lista sem número visível,
% mas em pôsteres o número [1] ajuda na citação — mantemos)

\AtBeginDocument{%
    % Zera o título "Referências" dentro do postercard
    % (o título do bloco já serve de cabeçalho)
    \renewcommand{\refname}{\vspace{-3cm}}%
    %
    % Estilo ABNT para thebibliography
    \renewenvironment{thebibliography}[1]{%
        \list{\@biblabel{\@arabic\c@enumiv}}{%
            \settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin by 1.25cm      % recuo ABNT
            \itemindent -1.25cm
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}
        }
        \fontsize{22}{28}\selectfont           % fonte menor nas referências
        \setlength{\itemsep}{0.2em}            % linha em branco entre entradas
        \setlength{\parsep}{0pt}%
    }{
        \endlist
    }
}

% ==================================================
% 9. RODAPÉ (posterfooter)
% ==================================================
\RequirePackage{qrcode}

\newlength{\impa@footerpad}
\setlength{\impa@footerpad}{1.2cm}

\newlength{\impa@qrsize}
\setlength{\impa@qrsize}{6cm}

% Divisão vertical: coluna do QR à direita
\newlength{\impa@footerdivision}
\setlength{\impa@footerdivision}{0.16\textwidth}

% Altura do rodapé: generosa o suficiente para 5+ referências
% Ajuste este valor se as referências ainda forem cortadas.
\newlength{\impa@footerheight}
\setlength{\impa@footerheight}{10cm}

% Largura útil da área de referências:
% total - coluna QR - 2x padding horizontal
\newlength{\impa@refwidth}
\setlength{\impa@refwidth}{\dimexpr(1\textwidth - \impa@footerdivision - 2\impa@footerpad)\relax}

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
    % Linha divisória vertical
    \draw[line width=1pt, color=black]
        ({0.5\textwidth - \impa@footerdivision},
         {-0.5\textheight + \impa@footerheight - 0.3cm})
        -- ({0.5\textwidth - \impa@footerdivision},
            {-0.5\textheight + 0.3cm});
    % Referências (esquerda) — âncora no topo para não cortar por baixo
    \node[
        anchor=north west,
        inner sep=\impa@footerpad,
        text width=\impa@refwidth,
        align=left
    ] at (-0.5\textwidth, {-0.5\textheight + \impa@footerheight})
        {{\color{impaTextFG}\fontsize{20}{26}\selectfont #2}};
    % QR code (direita)
    \node[anchor=center]
        at ({0.5\textwidth - 0.5\impa@footerdivision},
            {-0.5\textheight + 0.5\impa@footerheight})
        {\qrcode[height=\impa@qrsize]{#1}};
}

\endinput
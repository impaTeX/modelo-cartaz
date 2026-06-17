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
\RequirePackage{impaTechColors}

% ==================================================
% 6. ALOCAÇÃO DINÂMICA DE PALETA
% ==================================================
\RequirePackage{dynamicPalette}

% ==================================================
% 7. CAMADA DE COMPATIBILIDADE TIKZPOSTER
% ==================================================
\RequirePackage{TikZCompatibility}

% ==================================================
% 7b. BLOCO DE TÍTULO CUSTOMIZADO
% ==================================================
\RequirePackage{headerLayout}

% ==================================================
% 8. AMBIENTES CUSTOMIZADOS
% ==================================================
\RequirePackage{impaTexComponents}

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
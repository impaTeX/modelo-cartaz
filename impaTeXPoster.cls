\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{impaTeXPoster}[2026/04/20 My Custom LaTeX Class]
\LoadClass{article}
\RequirePackage{xcolor} %Pacote para cores
\RequirePackage{xparse} %Pacote para argumentos opcionais
\RequirePackage[most]{tcolorbox} %cria as seções
\RequirePackage{multicol} % Pacote para várias colunas
\RequirePackage{geometry} % Modifica dimensões da página

% IMPORTANTE: SE TIVER COM DÚVIDA NO CÓDIGO, FALAR COMIGO (BRUNO).
% CRIEM BRANCHS SEPARADAS 
% VAI TER MENSAGENS AO LOGO DO TEXTO, COMO SEU NOME (IGOR OU MARIA) E ALGUMA INSTRUÇÃO
% MARIA VAI TER FOCO NA ESTÉTICA, E IGOR NA ESTRUTURA
% Mantenham em inglês

% SEÇÃO 1 DEFINIÇÃO DE TEMAS E DEFINIÇÂO DAS CORES USADAS

% Definição de cores base (HEX ou RGB)
\definecolor{beige}{HTML}{CCC4AF}
\definecolor{white}{HTML}{F3F3F3}
\definecolor{black}{HTML}{000000}
\definecolor{pink}{HTML}{FF8AEF}
\definecolor{orange}{HTML}{FFC555}
\definecolor{yellow}{HTML}{ECF47A}
\definecolor{green}{HTML}{BEFF88}

% Definição de cores extendidas
% ------------------- MARIA extende o espectro de cores de acordo com as  diretrizes -----------

% Definindo paleta de cores do impatech estendida

% =========================
% PINK
% =========================
\definecolor{pink50}{HTML}{F7BEF4}
\definecolor{pink75}{HTML}{F59FED}
\definecolor{pink100}{HTML}{FF8AEF} % já definida, mas se alguém tentar usar assim vai funcionar!
\definecolor{pink200}{HTML}{F073E0}
\definecolor{pink300}{HTML}{E35DD4}
\definecolor{pink400}{HTML}{D646C7}


% =========================
% YELLOW
% =========================
\definecolor{yellow50}{HTML}{F7F7B2}
\definecolor{yellow75}{HTML}{F5F79B}
\definecolor{yellow100}{HTML}{ECF47A}
\definecolor{yellow200}{HTML}{EDF15D}
\definecolor{yellow300}{HTML}{EDEE40}
\definecolor{yellow400}{HTML}{EEEA24}

% =========================
% ORANGE
% =========================
\definecolor{orange50}{HTML}{F7D296}
\definecolor{orange75}{HTML}{F7CB80}
\definecolor{orange100}{HTML}{FFC555}
\definecolor{orange200}{HTML}{F9B74B}
\definecolor{orange300}{HTML}{F9AA41}
\definecolor{orange400}{HTML}{FCA72B}

% =========================
% GREEN
% =========================
\definecolor{green50}{HTML}{DEF7C5}
\definecolor{green75}{HTML}{D1FAAF}
\definecolor{green100}{HTML}{BDF58B}
\definecolor{green200}{HTML}{A6F865}
\definecolor{green300}{HTML}{91F340}
\definecolor{green400}{HTML}{7BEE1B}



% Cores Funcionais Padrão
\colorlet{MainColor}{beige}
\colorlet{TextColor}{black}
\colorlet{BackgroundColor}{white}
\colorlet{MainTitle}{black}

% Cores para o simplemode
\DeclareOption{simplemode}{
    \colorlet{MainColor}{white}
    \colorlet{TextColor}{black}
    \colorlet{BackgroundColor}{white}
}


\colorlet{TitleBackgroundColor}{beige} % Cor de fundo do título nas seções
\colorlet{TextBackgroundColor}{beige} % Cor de fundo do texto nas seções

\DeclareOption{minimalmode}{
    \def\minimalmodeactive{1}
    \colorlet{MainColor}{white}
    \colorlet{TextColor}{black}
    \colorlet{BackgroundColor}{white}
    \colorlet{MainColor}{white}
    \colorlet{TitleBackgroundColor}{white}
    \colorlet{TextBackgroundColor}{white} 
}

% Cores para o darkmode 
\DeclareOption{darkmode}{
    \colorlet{MainColor}{black}
    \colorlet{TextColor}{white}
    \colorlet{MainTitle}{white}
    \colorlet{BackgroundColor}{black}

    \ifnum\minimalmodeactive=1
        \colorlet{TitleBackgroundColor}{black}
        \colorlet{TextBackgroundColor}{black}
    \else
        \colorlet{TitleBackgroundColor}{gray}
        \colorlet{TextBackgroundColor}{black!80}
    \fi
}


\DeclareOption{greenmode}{
       \colorlet{TitleBackgroundColor}{green}
        \colorlet{TextBackgroundColor}{green50}
        \colorlet{TextColor}{black}
}

\DeclareOption{pinkmode}{
       \colorlet{TitleBackgroundColor}{pink}
        \colorlet{TextBackgroundColor}{pink50}
        \colorlet{TextColor}{black}
}

\DeclareOption{orangemode}{
       \colorlet{TitleBackgroundColor}{orange}
        \colorlet{TextBackgroundColor}{orange50}
        \colorlet{TextColor}{black}
}

\DeclareOption{yellowmode}{
        \colorlet{TitleBackgroundColor}{yellow}
        \colorlet{TextBackgroundColor}{yellow50}
        \colorlet{TextColor}{black}
}

\ProcessOptions\relax % Processa as options


% SEÇÃO 2 - CRIAR SEÇÕES E A ESTRUTURA BASE DAS SEÇÕES
% ----------IGOR ----------- faça as seguinte modificações



% Definição do ambiente para o time implementar
% Argumentos:
% #1 = Cor do Título (Pílula) 
% #2 = Cor do Fundo da Caixa 
% #3 = Cor do Texto e Borda   
% #4 = Título (Obrigatório)


% Estrutura de box pronto, IGOR fica a vontade para modificar
\NewDocumentEnvironment{postercard}{O{TitleBackgroundColor} O{TextBackgroundColor} O{TextColor} m}{%
    \begin{tcolorbox}[
        enhanced,
        colback=#2,           % Fundo da caixa (suave)
        colframe=#1,          % Borda da caixa (geralmente combina com a pílula)
        coltitle=#3,          % Cor do texto do título (geralmente preto ou branco)
        fonttitle=\bfseries\large,
        coltext=#3,
        title={#4},           % Texto do título
        attach boxed title to top center={yshift=-3mm,yshifttext=-1mm},
        boxed title style={
            colback=#1,       % Fundo da pílula
            arc=2mm,
            outer arc=1mm,
        },
        arc=0mm,
        boxrule=1.5pt,        % Borda um pouco mais grossa fica melhor em posters
        top=4mm,
    ]%
}{%
    \end{tcolorbox}
}

\AtBeginDocument{
    \pagecolor{BackgroundColor} % Aplica a cor da página para o darkmode funcionar
    \color{TextColor}
    \renewcommand{\refname}{Referências} % Mantém em português
}

% Personaliza o título
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

% Remove a numeração de página
\pagenumbering{gobble}

%FORMATAÇÃO MEXER DEPOIS

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
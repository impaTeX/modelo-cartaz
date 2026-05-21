\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{impaTeXPoster}[2026/04/20 My Custom LaTeX Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tikzposter}}

% Cores para o simplemode
\DeclareOption{simplemode}{
    \colorlet{MainColor}{white}
    \colorlet{TextColor}{black}
    \colorlet{BackgroundColor}{white}
    % TITLE
    \colorlet{titlefgcolor}{white}
    \colorlet{titlebgcolor}{pink}
    \colorlet{titlebordercolor}{orange}
}

% Cores para o darkmode 
\DeclareOption{darkmode}{
    \colorlet{MainColor}{black}
    \colorlet{TextColor}{white}
    \colorlet{BackgroundColor}{black}
    \colorlet{TitleBackgroundColor}{black!70}
    \colorlet{TextBackgroundColor}{black!85}
    \colorlet{titlefgcolor}{white}
    \colorlet{titlebgcolor}{black!90}
    \colorlet{titlebordercolor}{pink}
}

\ProcessOptions\relax

\LoadClass[a0paper,portrait]{tikzposter}
\usetheme{Basic}

\RequirePackage{xcolor} %Pacote para cores
\RequirePackage{xparse} %Pacote para argumentos opcionais

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

% BACKGROUND
\colorlet{backgroundcolor}{BackgroundColor}

% TITLE
\colorlet{titlefgcolor}{TextColor}
\colorlet{titlebgcolor}{MainColor}
\colorlet{titlebordercolor}{MainColor}
\colorlet{blocklinecolor}{TextColor}

% BLOCKS
\colorlet{blocktitlebgcolor}{TitleBackgroundColor}
\colorlet{blocktitlefgcolor}{TextColor}

\colorlet{blockbodybgcolor}{TextBackgroundColor}
\colorlet{blockbodyfgcolor}{TextColor}


% Estrutura de box pronto, IGOR fica a vontade para modificar
\NewDocumentEnvironment{postercard}
{O{TitleBackgroundColor} O{TextBackgroundColor} O{TextColor} O{TextColor} m +b}
{
    \begingroup

    % título
    \colorlet{blocktitlebgcolor}{#1}
    \colorlet{blocktitlefgcolor}{#3}

    % corpo
    \colorlet{blockbodybgcolor}{#2}
    \colorlet{blockbodyfgcolor}{#3}

    % borda
    \colorlet{blocklinecolor}{#4}

    \block{#5}{
        #6
    }

    \endgroup
}
{}

\AtBeginDocument{
    \color{TextColor}
    \renewcommand{\refname}{\vspace{-3cm}}
}

\endinput
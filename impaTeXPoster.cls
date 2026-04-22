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
% deixa algo do tipo \definecolor{pinkEx1}{HTML}{...}, \definecolor{pinkEx2}{HTML}{...}, etc... 
%EXEMPLO
\definecolor{pinkEx1}{HTML}{F7BEF4}
% Continue

% Cores Funcionais Padrão
\colorlet{MainColor}{beige}
\colorlet{TextColor}{black}
\colorlet{BackgroundColor}{white}

% Cores para o simplemode
\DeclareOption{simplemode}{
    \colorlet{MainColor}{white}
    \colorlet{TextColor}{black}
    \colorlet{BackgroundColor}{white}
}

\colorlet{TitleBackgroundColor}{pink} % Cor de fundo do título nas seções
\colorlet{TextBackgroundColor}{pinkEx1} % Cor de fundo do texto nas seções

% Criação de options
% -------------- Maria criar mais options ----------
% dica: siga o exemplo abaixo e faça para as outras cores (rosa, amarelo e laranja)
%\DeclareOption{allgreen}{
%   \colorlet{TitleBackgroundColor}{green}
%   \colorlet{TextBackgroundColor}{greenEx1}
%}

% Cores para o darkmode 
\DeclareOption{darkmode}{
    \colorlet{MainColor}{black}
    \colorlet{TextColor}{white}
    \colorlet{BackgroundColor}{black}
    \colorlet{TitleBackgroundColor}{gray}
    \colorlet{TextBackgroundColor}{black!80}
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
        {\Huge\bfseries \color{TextColor} \@title \par}
        \vspace{1em}
        {\Large \color{TextColor} \@author \par}
        \vspace{0.5em}
        {\large \color{TextColor} \@date \par}
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
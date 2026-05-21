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
% deixa algo do tipo \definecolor{pinkEx1}{HTML}{...}, \definecolor{pinkEx2}{HTML}{...}, etc... 
%EXEMPLO
\definecolor{pinkEx1}{HTML}{F7BEF4}
% Continue

% Cores Funcionais Padrão
\providecolor{MainColor}{named}{beige}
\providecolor{TextColor}{named}{black}
\providecolor{BackgroundColor}{named}{white}

\providecolor{TitleBackgroundColor}{named}{pink}
\providecolor{TextBackgroundColor}{named}{pinkEx1}

% Criação de options
% -------------- Maria criar mais options ----------
% dica: siga o exemplo abaixo e faça para as outras cores (rosa, amarelo e laranja)
%\DeclareOption{allgreen}{
%   \colorlet{TitleBackgroundColor}{green}
%   \colorlet{TextBackgroundColor}{greenEx1}
%}



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
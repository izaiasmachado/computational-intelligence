% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Questão 03 - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 17/10/2022

% QUESTAO03 Essa questão utiliza apenas a classe MultipleRegression
% referente a regressão múltipla.

clf('reset'); % Limpa os gráficos

%% Importa o Dataset
dataset = [
    122 139 0.115;
    114 126 0.120;
    086 090 0.105;
    134 144 0.090;
    146 163 0.100;
    107 136 0.120;
    068 061 0.105;
    117 062 0.080;
    071 041 0.100;
    098 120 0.115
];

n = length(dataset);
y = dataset(:, end);

%% Calcula os resultados da Regressão Múltipla
% Inicializar vetor do viés na primeira coluna
x = [ones(n, 1), dataset(:, 1:2)];

% Fornece dados para a Regressão
regression = MultipleRegression();
regression = regression.fit(x, y);

b = regression.coefficients;
r = regression.rSquared(x, y);

%% Imprime os Resultados da Regressão Múltipla
fprintf('===== Regressão para a Base de Dados =====\n');
printCoefficients(b);

% Imprime o Erro Quadrático Médio
fprintf('R^2: %f\n', r);
fprintf('\n');

%% Inicializa Pontos em Gráfico de Três Dimensões
x1 = x(:, 2);
x2 = x(:, 3);
plot3(x1, x2, y, '*');
title('Plano de Predição para a Base de Dados')
xlabel('x1')
ylabel('x2')
zlabel('y')

grid on;
hold on;

%% Traça a Superfície Predita no Gráfico
surfacePoints = 100;
surfaceX1 = linspace(min(x1), max(x1), surfacePoints);
surfaceX2 = linspace(min(x2), max(x2), surfacePoints);
surfaceX = [ones(surfacePoints, 1), surfaceX1', surfaceX2'];

[x1, x2] = meshgrid(surfaceX1, surfaceX2);
Y = b(1) + b(2) * x1 + b(3) * x2;
mesh(x1, x2, Y);

%% Imprime a equação do Hiperplano
function printCoefficients(b)
    fprintf('Coeficientes do Hiperplano: ');
    
    fprintf('(%f)', b(1));

    for i = 2 : length(b)
        fprintf(' + (%f) * x%d', b(i), i - 1);      
    end

    fprintf('\n');
end

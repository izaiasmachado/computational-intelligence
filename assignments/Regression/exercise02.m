% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Questão 02 - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 17/10/2022

% QUESTAO02 Essa questão, utiliza as classes PolynomialRegression e
% MultipleRegression.

clf('reset'); % Limpa os gráficos

%% Importa o dataset
dataset = importdata('aerogerador.dat');
x = dataset(:,1);
y = dataset(:,2);
degrees = 2 : 7; % Vetor com graus 2 a 7

%% Para cada grau faz a regressão, imprime no terminal e plota os resultados em um gráfico.
regressions = {};

for i = 1 : length(degrees)
    degree = degrees(i);
    regression = fitRegression(degree, x, y);
    printRegression(regression, x, y);
    regressions{i} = regression;
end

plotRegressions(regressions, degrees, x, y);

%% Realiza a regressão para um dado grau
function regression = fitRegression(degree, x, y)
    regression = PolynomialRegression(degree);
    regression = regression.fit(x, y);
end

%% Imprime os resultados de uma regressão
function printRegression(regression, x, y)
    fprintf('===== Polinômio de Grau %d =====\n', regression.degree);
    fprintf('Coeficientes do Polinômio:\n');
    printPolynomialEquation(regression);
    printRSquared(regression, x, y);
end

%% Plota todo o gráfico
function plotRegressions(regressions, degrees, x, y)
    % Plota os pontos da base de dados
    plot(x, y, '*');
    hold on;
    plotPredictions(regressions, x);
    createLegend(degrees);
end

%% Plota as linhas de predição de cada regressão
function plotPredictions(regressions, x)
    for i = 1 : length(regressions)
        regression = regressions{i};
        prediction = regression.predict(x);
        plot(x, prediction, 'LineWidth', 2); % Plota a linha predita
    end
end

%% Imprime a equação polinomial dados os coeficientes
function printPolynomialEquation(regression)
    b = regression.coefficients;
    degrees = 2 : length(b);
    reversedB = flip(degrees, 2);
    
    for i = reversedB
        fprintf('(%f) * x^%d + ', b(i), i - 1);
    end 

    fprintf('(%f)\n', b(1));
end

%% Imprime o Erro Quadrático
function printRSquared(regression, x, y)
    r = regression.rSquared(x, y);
    r_adjusted = regression.adjustedRSquared(x, y);

    fprintf('R^2: %f\n', r);
    fprintf('R^2 Ajustado: %f\n', r_adjusted);
    fprintf('\n');
end

%% Cria a legenda do gráfico
function createLegend(degrees)
    lgd = strings(1, length(degrees) + 1);
    lgd(1) = ['Pontos da Base de Dados'];

    for i = 1 : length(degrees)
        degree = i + 1;
        lgd(degree) = ['Polinômio de Grau ' + string(degree)];
    end 

    l = legend(lgd);
    l.Location = 'northwest';
end
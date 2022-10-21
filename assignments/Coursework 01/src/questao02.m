dataset = importdata('aerogerador.dat');
dataset = Nomalization().zscore(dataset);

degrees = 2 : 7; % Vetor com graus 2 a 7
x = dataset(:,1);
y = dataset(:,2);
regressions = {};

% Realiza a regressão para cada um dos graus. A instância da classe fica
% armazenada no vetor regressão.
for i = 1 : length(degrees)
    degree = degrees(i);
    regression= PolynomialRegression();
    regression = regression.fit(x, y, degree);
    regressions{i} = regression;
    printPolynom(regression);
end

regressionsGraph(regressions);

% Imprime o polinômio e seus coeficientes de avaliação
function printPolynom(regression)
    degree = regression.degree;
    fprintf('===== Polinômio de Grau %d =====\n', degree);

    fprintf('Coeficientes do Polinômio:\n');
    printPolynomialEquation(regression);

    r = regression.rSquared();
    r_adjusted = regression.adjustedRSquared();

    fprintf('R^2: %f\n', r);
    fprintf('R^2 Ajustado: %f\n', r_adjusted);
    fprintf('\n');
end 

% Imprime a equação polinomial dados os coeficientes
function printPolynomialEquation(regression)
    b = regression.coefficients;
    degree = regression.degree;

    degrees = 1 : degree;
    reversedDegrees = flip(degrees, 2);

    for i = reversedDegrees
        fprintf('(%f) * x^%d + ', b(i + 1), i);
    end 

    fprintf('(%f)\n', b(1));
end

% Monta os gráficos do Coeficiente de Avaliação e Coeficiente de Avaliação
% ajustado em função do grau do polinômio. Recebe como entrada um vetor
% coluna com as instâncias das regressões realizadas.
function regressionsGraph(regressions)
    % Inicializa os vetores
    degrees = zeros(length(regressions), 1);
    r = zeros(length(regressions), 1);
    r_adjusted = zeros(length(regressions), 1);

    % Extrai as propriedades das instâncias das classes.
    for i = 1 : length(regressions)
        regression = regressions{i};
        degrees(i) = regression.degree;
        r(i) = regression.rSquared();
        r_adjusted(i) = regression.adjustedRSquared();
    end
    
    y = degrees;
    x = [r, r_adjusted];

    % Monta o gráfico
    plot(y, x, '--o');
    title('Coeficiente de Determinação R^2 e R^2{aj} em Função do Grau do Polinômio');
    ylabel('Grau do Polinômio');
    xlabel('Coeficientes de Determinação');
    legend({'R^2','R^2_{aj}'}, 'Location','southeast');
end
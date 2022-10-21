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
dataset_norm = Nomalization().zscore(dataset);

fprintf('===== Regressão para a Base de Dados =====\n');
printMultipleRegressionResult(dataset);
fprintf('\n');

fprintf('===== Regressão para a Base de Dados Normalizada =====\n');
printMultipleRegressionResult(dataset_norm);

% Imprime o resultado da regressão múltipla: b e r.
function printMultipleRegressionResult(dataset)
    y = dataset(:, end);
    x = dataset(:, 1:2);
    
    regression = MultipleRegression();
    regression = regression.fit(x, y);
    b = regression.coefficients;
    r = regression.rSquared();
    
    printCoefficients(b);
    fprintf('R^2: %f\n', r);
end

% Imprime a equação do hiperplano
function printCoefficients(b)
    fprintf('Coeficientes do Hiperplano: ');
    for i = 1 : length(b) - 1
        fprintf('(%f) * x%d + ', b(i), i);        
    end

    fprintf('(%f) * x%d\n', b(end), length(b));
end

% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Regressão Polinomial - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 12/10/2022

classdef PolynomialRegression < MultipleRegression
    %POLYNOMIALREGRESSION Realiza a regressão polinomial
    %   É uma subclasse de regressão múltipla porque a regressão
    %   polinomial é feita de modo que cada grau do polinômio
    %   é tratado como uma nova coluna na matriz de entrada 
    %   da regressão múltipla.
    %   
    %   Além disso, é implementado um  novo coeficiente
    %   de determinação que tem como base SQe, Syy e também
    %   o grau do polinômio.
    
    properties
        degree
        p
    end
    
    methods
        function regression = PolynomialRegression(degree)
            regression = regression@MultipleRegression();
            regression.degree = degree;
            regression.p = degree + 1;
        end

        function regression = fit(regression, input, expected)
            multipleRegressionInput = regression.calculateMultipleRegressionInput(input);
            regression = fit@MultipleRegression(regression, multipleRegressionInput, expected);
        end

        function prediction = predict(regression, input)
            adjustedInput = regression.calculateMultipleRegressionInput(input);
            prediction = predict@MultipleRegression(regression, adjustedInput);
        end

        % Monta uma matriz de modo que as colunas são o input elevado ao
        % grau do polinômio que a coluna representa.
        function multipleRegressionInput = calculateMultipleRegressionInput(regression, input)
            n = length(input);
            multipleRegressionInput = zeros(n, regression.degree); % Pré-aloca a matriz

            for i = 1 : regression.p
                multipleRegressionInput(:, i) = input .^ (i - 1);
            end
        end

        function adjustedRSquared = adjustedRSquared(regression, x, y)
            regression = regression.variability(x, y);
            n = length(y);

            adjustedSQE = regression.sqe / (n - regression.p);
            adjustedSYY = regression.syy / (n - 1);
            adjustedRSquared = 1 - (adjustedSQE / adjustedSYY);
        end
    end
end


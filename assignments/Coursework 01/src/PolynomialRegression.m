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
        n
    end
    
    methods
        function regression = PolynomialRegression()
            regression = regression@MultipleRegression();
        end

        function regression = fit(regression, input, expected, degree)
            regression.n = length(input);
            regression.p = degree + 1;
            regression.input = input;
            regression.degree = degree;

            multipleRegressionInput = regression.calculateMultipleRegressionInput();
            regression = fit@MultipleRegression(regression, multipleRegressionInput, expected);
        end
        
        % Monta uma matriz de modo que as colunas são o input elevado ao
        % grau do polinômio que a coluna representa.
        function multipleRegressionInput = calculateMultipleRegressionInput(regression)
            multipleRegressionInput = zeros(regression.n, regression.degree); % Pré-aloca a matriz

            for i = 1 : regression.p
                multipleRegressionInput(:, i) = regression.input .^ (i - 1);
            end
        end

        function adjustedRSquared = adjustedRSquared(regression)
            regression = regression.variability();
            
            adjustedSQE = regression.sqe / (regression.n - regression.p);
            adjustedSYY = regression.syy / (regression.n - 1);
            adjustedRSquared = 1 - (adjustedSQE / adjustedSYY);
        end
    end
end


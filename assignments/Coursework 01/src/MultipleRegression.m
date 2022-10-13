classdef MultipleRegression
    %MULTIPLEREGRESSION Realiza a regressão múltipla
    %   Calcula os coeficientes b que determinam o hiperplano 
    %   que melhor se ajusta aos valores fornecidos de entrada
    %   e saída. Esse processo é feito pelo método de minização
    %   dos mínimos quadrados.
    %   
    %   A entrada é uma matriz com valores esperados e também 
    %   um vetor de valores esperados.
    
    properties
        input
        expected
        coefficients
        predicted
        sqe
        syy
    end
    
    methods
        function regression = MultipleRegression()
        end
        
        function regression = fit(regression, input, expected)
            regression.input = input;
            regression.expected = expected;
            
            regression.coefficients = (regression.input' * regression.input) ^ -1 * regression.input' * regression.expected;
            regression.predicted = regression.predict(input);
        end
        
        function prediction = predict(regression, input)
            prediction = input * regression.coefficients;
        end

        function regression = variability(regression)
            regression.sqe = sum((regression.expected - regression.predicted) .^ 2);
            regression.syy = sum((regression.expected - mean(regression.expected)) .^ 2);
        end

        function rSquared = rSquared(regression)
            regression = regression.variability();
            rSquared = 1 - (regression.sqe / regression.syy);
        end
    end
end


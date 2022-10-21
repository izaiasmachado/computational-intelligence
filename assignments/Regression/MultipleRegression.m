% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Regressão Múltipla - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 12/10/2022

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
        sqe
        syy
    end
    
    methods
        function regression = MultipleRegression()
        end
        
        function regression = fit(regression, input, expected)
            regression.coefficients = (input' * input) ^ -1 * input' * expected;
        end
        
        function prediction = predict(regression, input)
            prediction = input * regression.coefficients;
        end

        function regression = variability(regression, inputs, expected)
            predicted = regression.predict(inputs);
            regression.sqe = sum((expected - predicted) .^ 2);
            regression.syy = sum((expected - mean(expected)) .^ 2);
        end

        function rSquared = rSquared(regression, inputs, expected)
            regression = regression.variability(inputs, expected);
            rSquared = 1 - (regression.sqe / regression.syy);
        end
    end
end


% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Agregação - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 14/10/2022

classdef Agregation
    %AGREGATION Faz o processo de agregação
    
    properties
        implications
        outputMFs
        range
    end
    
    methods
        % Dados as implicações, as funções de pertencimento da saída e o
        % range da saída, inicializa uma agregação.
        function agregation = Agregation(implications, outputMFs, range)
            agregation.implications = implications;
            agregation.outputMFs = outputMFs;
            agregation.range = range;
        end
        
        % Calcula os valores do gráfico da saída dado os valores de entrada
        % e a quantidade de pontos que devem ser utilizados.
        function [values, output] = getOutput(agregation, inputs, pointsQuantity)
            output = [];
            values = linspace(agregation.range(1), agregation.range(2), pointsQuantity);
            n = length(agregation.outputMFs);

            for i = 1 : n
                implication = agregation.implications(i); 

                % Calcula o valor das implicações (resultado das regras)
                % para cada input.
                membership = implication.getOutput(inputs);

                % Para cada função de pertencimendo da saída traça uma
                % reta cortando o gráfico com o valor de pertencimento 
                % das implicações dado a entrada.
                outputMF = agregation.outputMFs(i);
                outputMFValues = outputMF.getOutput(values);
                outputMFValues = min(outputMFValues, membership);

                % Se os valores de saída estiverem vazios, a saída é
                % composta pelos próprios valoers da função de saída.
                if isempty(output)
                    output = outputMFValues;
                end

                %% Regra de Agregação
                % Faz o máximo entre os pontos de output e os pontos
                % calculados.
                output = max(output, outputMFValues);
            end
        end
    end
end


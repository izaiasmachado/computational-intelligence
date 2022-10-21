% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Regra - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 14/10/2022

classdef Rule
    properties
        membershipFunctions
        connection
    end
    
    methods
        % Monta uma regra dadas funções de pertencimento e um conectivo
        function rule = Rule(membershipFunctions, connection)
            rule.membershipFunctions = membershipFunctions;
            rule.connection = connection;
        end

        % Calcula o valor de saída para a regra dado os inputs
        function value = getOutput(rule, inputs)
            value = 0;
            mfs = rule.membershipFunctions;
            mfOutputs = zeros(length(mfs), 1);

            for i = 1 : length(mfs)
                mf = mfs(i);
                input = inputs(i);     
                mfOutputs(i) = mf.getOutput(input);
            end

            switch rule.connection
                case 'and'
                    %% Regra para o AND
                    value = prod(mfOutputs);
            end
        end
    end
end


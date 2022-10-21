% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Implicação - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 14/10/2022

classdef Implication    
    properties
        rules
    end
    
    methods
        % Dadas as regras inicializa uma implicação
        function implication = Implication(rules)
            implication.rules = rules;
        end
        
        % Com os inputs, calcula o valor da implicação
        function output = getOutput(implication, inputs)
            n = length(implication.rules);
            rulesOutputs = zeros(n, 1);
        
            for ruleIdx = 1 : n
                rule = implication.rules(ruleIdx);
                ruleOutput = rule.getOutput(inputs);
                rulesOutputs(ruleIdx) = ruleOutput;
            end

            %% Regra de Implicação
            output = prod(rulesOutputs);
        end
    end
end


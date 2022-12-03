% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Cruzamento (Crossover) - Trabalho 03
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 22/11/2022

classdef Crossover
    % CROSSOVER Classe para realizar o cruzamento (crossover) dados dois
    % indivíduos como pais
    
    properties
        firstParent % Primeiro Pai/Mãe
        secondParent % Segundo Pai/Mãe
    end

    methods(Static)
        function child = replaceMappedNodes(chromosome, mapping)
            % REPLACEDMAPPEDGENES Dado o mapeamento, substitui os nós
            % mapeados para serem trocados

            child = Chromosome(chromosome.nodes);

            for i = 1 : length(chromosome.nodes)
                aux = mapping(child.nodes(i));

                % Se o valor do mapeamento é 0 para um nó, isso significa
                % que ele não vai ser trocado. Caso contrário, o filho tem
                % seu nó trocado pelo valor do mapeamento feito

                if aux ~= 0
                    if mapping(aux) == child.nodes(i)
                        child.nodes(i) = mapping(child.nodes(i));
                    end
                end
            end
        end
    end
    
    methods
        function cross = Crossover(firstParent, secondParent)
            cross.firstParent = firstParent;
            cross.secondParent = secondParent;
        end

        function [firstChild, secondChild] = partialMapping(cross)
            % PARTICALMAPPING É o crossover por mapeamento parcial, que tem
            % como resultado os dois filhos do casal
            
            mapping = zeros(1, length(cross.firstParent.nodes));
            
            % Pontos de corte aleatórios
            inicio = Utils.randomNumberGenerator(1, length(mapping) - 1);
            offset = Utils.randomNumberGenerator(1, length(mapping) - inicio - 1);
            fim = inicio + offset;

            % Realiza o mapeamento dos nós dentro do ponto de corte e que
            % devem ser substituídos
            for i = inicio : fim      
                mapping(cross.firstParent.nodes(i)) = cross.secondParent.nodes(i);
                mapping(cross.secondParent.nodes(i)) = cross.firstParent.nodes(i);
            end

            % Substitui esse mapeamento para cada um dos pais, resultando
            % em um filho cada
            firstChild = cross.replaceMappedNodes(cross.firstParent, mapping);
            secondChild = cross.replaceMappedNodes(cross.secondParent, mapping);
        end
    end
end


% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe do Cromossomo - Trabalho 03
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 22/11/2022

classdef Chromosome
    % CHROMOSOME Classe que armazena os nós e os métodos do cromossomo de
    % um indivíduo
    
    properties
        nodes % Nós do cromossomo (Cidades)
        size % Quantidade de nós
    end

    methods
        function chromo = Chromosome(nodes)
            chromo.nodes = nodes;
            chromo.size = length(nodes);
        end

        function idx = getRandomNodeIndex(chromo)
            % GETRANDOMNODEINDEX Dado um cromossomo, escolhe um índice de
            % um nó de forma aleatória

            idx = Utils.randomNumberGenerator(1, chromo.size);
        end
        
        function chromo = mutate(chromo)
            % MUTATE Mutação por permutação de elementos

            % Escolhe o índice do primeiro nó de forma aleatória
            firstIdx = chromo.getRandomNodeIndex();

            % Escolhe o índice do segundo nó de forma aleatória, contanto
            % que ele seja diferente do índice do primeiro nó.
            while true
                secondIdx = chromo.getRandomNodeIndex();

                if firstIdx ~= secondIdx
                    break;
                end
            end

            % Realiza a permutação do primeiro com o segundo nó
            aux = chromo.nodes(firstIdx);
            chromo.nodes(firstIdx) = chromo.nodes(secondIdx);
            chromo.nodes(secondIdx) = aux;
        end

        function chromo = tryMutation(chromo, odds)
            % TRYMUTATION Dá uma chance de realizar uma mutação no
            % cromossomo
            % 
            % odds: Chance de mutação
            %
            % Caso um número aleatório seja menor ou igual a chance de
            % mutação, é realizada uma mutação por permutação de elementos

            if rand(1, 1) <= odds
                chromo.mutate();
            end
        end
    end
end


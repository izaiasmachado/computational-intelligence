% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe do Grafo Completo - Trabalho 03
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 02/12/2022

classdef CompleteGraph    
    % COMPLETEGRAPH Classe que encapsula métodos para o grafo k-completo do
    % problema

    properties
        matrix % Matriz de adjacência
        n % Quantidade de Vértices (Cidades)
    end
    
    methods
        function graph = CompleteGraph(matrix)
            graph.matrix = matrix;
            [graph.n, ~] = size(matrix);
        end
        
        function cost = getPathCost(graph, path)
            % GETPATHCOST Calcula o custo de um caminho do caixeiro
            % viajante.
            %
            % path: É um array com a ordem das cidades, ou seja, [1 2 3] é
            % equivalente a ir da cidade 1 para a 2 e depois para a 3.

            % Ao fim de sua jornada, o caixeiro viajante volta para primeira cidade
            path(end + 1) = path(1);

            pathSize = length(path);
            costs = zeros(1, pathSize - 1);
            
            % Calcula os custos seguindo o caminho, com base na matriz de
            % adjacência
            for i = 1 : length(costs)
                u = path(i);
                v = path(i + 1);
                w = graph.matrix(u, v);
                costs(i) = w;
            end
            
            % Soma os custos
            cost = sum(costs);
        end
    end
end


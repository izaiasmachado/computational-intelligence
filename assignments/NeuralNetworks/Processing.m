% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe para Processamento - Trabalho 02
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 09/11/2022

classdef Processing
    methods(Static)
        function X = zscore(X)
            % ZSCORE Faz a normalização de cada coluna de X de forma
            % individual utilizando o método zscore.
            [n, ~] = size(X);
            
            for i = 1 : n
                x = X(i, :);
                X(i, :) = (x - mean(x)) / std(x);
            end
        end

        function labelColumns = oneHotEnconding(labels)
            % ONEHOTENCONDING Dado uma única coluna de rótulos, retorna n
            % colunas codificadas com esses rótulos. Onde n é a quantidade
            % de rótulos únicos
            %
            %   EXEMPLO:
            %   Rótulos         A B C
            %      A     ->     1 0 0
            %      B     ->     0 1 0
            %      C     ->     0 0 1

            N = length(labels);
            uniqueLabels = unique(labels);
            labelColumns = zeros(N, length(uniqueLabels));
        
            for i = 1 : N
                for j = 1 : length(uniqueLabels)
                    labelColumns(i, j) = strcmp(labels{i}, uniqueLabels(j));
                end
            end
        end
    end
end


% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Defuzzyficação - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 14/10/2022

classdef Defuzzy
    %DEFUZZY Reúne métodos de defuzzyficação
    
    methods (Static)
        % Dado os pontos do gráfico, calcula o valor do centroide
        function centroid = calculateCentroid(x, px)
            centroid = sum(px .* x) / sum(px);
        end
    end
end


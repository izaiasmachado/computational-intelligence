% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe com Métodos de Utilidade - Trabalho 03
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 22/11/2022

classdef Utils
    methods(Static)
        % Gera um número aleatório entre o intervalo
        function number = randomNumberGenerator(start, finish)
            number = floor(rand(1, 1) .* (finish - start) + start);
        end
    end
end


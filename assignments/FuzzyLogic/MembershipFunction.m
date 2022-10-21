% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe de Função de Pertencimento - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 14/10/2022

classdef MembershipFunction
    %MEMBERSHIPFUNCTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        range
        type
        params
    end
    
    methods
        function mf = MembershipFunction(range, type, params)
            mf.range = range;
            mf.type = type;
            mf.params = params;
        end

        function output = getOutput(mf, input)
            switch mf.type
                case 'trimf'
                    output = trimf(input, mf.params);
                case 'gaussmf'
                    output = gaussmf(input, mf.params);
            end
        end
    end
end


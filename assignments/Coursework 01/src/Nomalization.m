classdef Nomalization
    %NOMALIZATION Classe estática que reúne métodos de normalização
    %   A normalização é feita de forma independente para cada coluna
    %   de um dado dataset. 
    
    methods(Static)
        %ZSCORE Realiza a normalização em colunas de uma matriz utilizando zscore.
        %   O método zscore utiliza a média e o desvio padrão para
        %   calcular a distância de um determinado valor da média
        %   em termos de desvio padrão. Essa técnica permite pode ser
        %   visualizada de forma gráfica utilizando uma curva normal.
        function zscore = zscore(x)
            zscore = (x - mean(x)) ./ std(x);
        end
    end
end


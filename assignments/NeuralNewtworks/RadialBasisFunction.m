% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe da Rede Neural RBF - Trabalho 02
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 30/10/2022

classdef RadialBasisFunction
    %RADIALBASISFUNCTION Modelo da rede neural de função de base radial

    properties
        q % Quatidade de neurônios na Camada Oculta
        C % Pesos da Camada Oculta
        M % Pesos da Camada de Saída
        sigma % Desvio padrão para os pesos da camada oculta
    end
    
    methods(Static)
        % Dado um valor u e um desvio padrão sigma, calcula o valor da
        % função sigmoide.
        function fu = sigmoid(u, sigma)
            fu = exp(-u .^ 2 / (2 * sigma .^ 2));
        end
        
        % Dado uma matriz, adiciona uma linha de -1 na primeira posição.
        function x = addBias(x)
            [~, n] = size(x);
            x = [(-1) * ones(1, n); x];
        end
    end

    methods
        function rbf = RadialBasisFunction(q)
            rbf.q = q;
        end
        
        function rbf = train(rbf, X, D)
            % TRAIN Treina a rede neural de função de base radial
            %
            % X: Dado de entrada do treino, em que toda coluna é uma
            % amostra e as linhas são as características do elemento.
            % D: Dado de saída do treino, em que toda coluna é uma amostra e
            % as linhas são o valor da saída para a amostra.
           
            % Define um valor para o desvio padrão dos pesos da camada
            % oculta
            rbf.sigma = 40;

            % Dado a quantidade de elementos de entrada, é possível gerar
            % os valores da camada oculta.
           
            [p, ~] = size(X);
            rbf = rbf.calculateHiddenLayerWeights(p);
            Z = rbf.outputHiddenLayer(X);

            % É feito o treinamento da rede dado os pesos da camada oculta
            % e o vetor de classificação para treinamento.
            rbf.M = D * Z' / (Z * Z');
        end

        function prediction = predict(rbf, X)
            % PREDICT Dado valores de entrada, a função retorna a predição
            % do modelo construido na fase de treinamento.
            
            % Alimenta a camada de saída com os valores de entrada
            Z = rbf.outputHiddenLayer(X);
            
            % Faz o produto matricial dos pesos da camada de saída (M) com o
            % processamento realizado pela camada oculta (Z).
            prediction = rbf.M * Z;
        end

        function rbf = calculateHiddenLayerWeights(rbf, p)
            % CALCULATEHIDDENLAYERWEIGHTS Pesos aleatórios são calculados
            % utilizando o desvio padrão que foi definido.
            % 
            % p: Quantidade de Colunas de Entrada (sem bias/viés).
            
            rbf.C = normrnd(0, rbf.sigma, [p, rbf.q]);
        end

        function Z = outputHiddenLayer(rbf, X)
            % OUTPUTHIDDENLAYER Dado uma entrada X, essa função retorna a saída
            % após o processamento da camada oculta para esse vetor.

            [~, n] = size(X);
            Z = zeros(rbf.q, n);

            % Percorre cada elemento da entrada
            for i = 1 : n
                % Percorre cada neurônio
                for neuronId = 1 : rbf.q
                    centroid = rbf.C(:, neuronId); % Armazena o centroid do neurônio
                    x = X(:, i); % Armazena o elemento
                    u = norm(x - centroid); % Calcula a norma da diferença entre vetor do elemento e centroid
                    fu = RadialBasisFunction.sigmoid(u, rbf.sigma); % Processa a norma pela função de ativação
                    Z(neuronId, i) = fu;
                end
            end
            
            % Z é (q, n)
            Z = RadialBasisFunction.addBias(Z); % Após adicionar o bias/viés, Z é (q + 1, n)
        end
    end
end

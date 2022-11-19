% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe para Validação - Trabalho 02
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 09/11/2022

classdef Validation
    methods(Static)
        function [X_train, Y_train, X_test, Y_test] = holdOutSamples(X, D, trainning)
            % HOLDOUTSAMPLES Dados duas matrizes X e D e um percentual para
            % treinamento. São selecionados de forma aleatória uma
            % quantidade de amostras para treinamento e o restante para
            % treino.

            [inputClasses, totalSamples] = size(X);
            [outputClasses, ~] = size(D);
        
            testingSamples = round((1 - trainning) * totalSamples);
        
            % X_train recebe X com os valores embaralhados
            shuffledSampleIndexes = randperm(length(X));
            X_train = X(:, shuffledSampleIndexes);
            Y_train = D(:, shuffledSampleIndexes);
            
            % As amostras excedentes são gradativamente retiradas de
            % X_train, Y_train e alocadas em X_test e Y_test.
            X_test = zeros(inputClasses, testingSamples);
            Y_test = zeros(outputClasses, testingSamples);
            
            for sampleId = 1 : testingSamples
                Y_test(:, sampleId) = Y_train(:, sampleId);
                X_test(:, sampleId) = X_train(:, sampleId);
                
                X_train(:, sampleId) = [];
                Y_train(:, sampleId) = [];
            end
        end
        
        function [accuracy] = measureAccuracy(Y_test, prediction)
            % MEASUREACCURACY Dadas 2 matrizes de classes, verifica se a
            % classe com maior valor na predição é igual a classe correta
            % da predição. Com isso, essa taxa de acerto é convertida na
            % acurácia dividindo os acertos pelo total.

            [~, testSamples] = size(Y_test);
        
            [~, predicted] = max(prediction);
            [~, actual] = max(Y_test);
        
            hits = predicted == actual;
            testHits = sum(hits);
            accuracy = testHits / testSamples;
        end
    end
end


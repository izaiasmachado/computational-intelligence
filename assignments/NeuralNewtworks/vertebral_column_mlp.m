% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Implementação MLP Dados Coluna Vertebral - Trabalho 02
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 09/11/2022

% Leitura do arquivo
fileID = fopen('vertebral_column_data/column_3C.dat');
C = textscan(fileID, '%f %f %f %f %f %f %s', 'Delimiter',',');

% Codifica as classes de saída
labelColumns = Processing.oneHotEnconding(C{7});
dataset = [C{1}, C{2}, C{3}, C{4}, C{5}, C{6}, labelColumns];

% Transpõe os vetores coluna para vetores linha
X = dataset(:, 1:6)';
D = dataset(:, 7:9)';

% Normaliza os dados
X = Processing.zscore(X);

% Cria o modelo da MLP com 40 neurônios na camada oculta
net = feedforwardnet(40);

% Seta o percentual de amostras para treinamento/testes para 70%/30%
trainingPercentage = 0.7;

% Seta 10 épocas
totalEpochs = 10;
accuracy = zeros(1, totalEpochs);

for epoch = 1 : totalEpochs
        % Em cada época é realizado um novo hold out

    [X_train, Y_train, X_test, Y_test] = Validation.holdOutSamples(X, D, trainingPercentage);

    % O modelo é treinado
    net = train(net, X_train, Y_train);
    
    % Uma predição é feita com os dados de teste
    prediction = net(X_test);

    % É comparado os dados de teste com a predição por meio da acurácia
    [accuracy(epoch)] = Validation.measureAccuracy(Y_test, prediction);
end

% É mostrado de forma visual os valores das acurácias para cada época e
% tambéma acurácia média.
fprintf('===== Treinamento e Teste para MLP =====\n');

for i = 1 : totalEpochs
    fprintf('Acurácia Época %d: %f\n', i, accuracy(i));
end 

fprintf('Acurácia Média: %f\n', mean(accuracy));

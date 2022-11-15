% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Implementação RBF Dados Coluna Vertebral - Trabalho 02
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 09/11/2022

% Realiza a leitura do arquivo com 3 classes
fileID = fopen('vertebral_column_data/column_3C.dat');
C = textscan(fileID, '%f %f %f %f %f %f %s', 'Delimiter',',');

% Codifica as classes de saída
labelColumns = Processing.oneHotEnconding(C{7});
dataset = [C{1}, C{2}, C{3}, C{4}, C{5}, C{6}, labelColumns];

% Transpõe os vetores linha para vetores coluna
X = dataset(:, 1:6)';
D = dataset(:, 7:9)';

% Normaliza os dados
X = Processing.zscore(X);

% Cria o modelo da RBF com 30 neurônios na camada oculta
model = RadialBasisFunction(30);

% Seta 10 épocas
totalEpochs = 10;
accuracy = zeros(1, totalEpochs);

for epoch = 1 : totalEpochs
    % Em cada época é realizado um novo hold out com 70% das amostras para
    % treino e os 30% restantes para teste
    [X_train, Y_train, X_test, Y_test] = Validation.holdOutSamples(X, D, 0.7);

    % O modelo é treinado
    model = model.train(X_train, Y_train);

    % Uma predição é feita com os dados de teste
    prediction = model.predict(X_test);

    % É comparado os dados de teste com a predição por meio da acurácia
    [accuracy(epoch)] = Validation.measureAccuracy(Y_test, prediction);
end

% É mostrado de forma visual os valores das acurácias para cada época e
% também a acurácia média
fprintf('===== Treinamento e Teste para RBF =====\n');

for i = 1 : totalEpochs
    fprintf('Acurácia Época %d: %f\n', i, accuracy(i));
end 

fprintf('Acurácia Média: %f\n', mean(accuracy));

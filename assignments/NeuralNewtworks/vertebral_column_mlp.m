fileID = fopen('vertebral_column_data/column_3C.dat');
C = textscan(fileID, '%f %f %f %f %f %f %s', 'Delimiter',',');

labelColumns = Processing.oneHotEnconding(C{7});
dataset = [C{1}, C{2}, C{3}, C{4}, C{5}, C{6}, labelColumns];

X = dataset(:, 1:6)';
D = dataset(:, 7:9)';
X = Processing.zscore(X);

model = RadialBasisFunction(30);
trainingPercentage = 0.7;
net = feedforwardnet(40);

totalEpochs = 10;

accuracy = zeros(1, totalEpochs);

for epoch = 1 : totalEpochs
    [X_train, Y_train, X_test, Y_test] = Validation.holdOutSamples(X, D, trainingPercentage);

    net = train(net, X_train, Y_train);
    prediction = net(X_test);
    [accuracy(epoch)] = Validation.measureAccuracy(Y_test, prediction);
end

fprintf('===== Treinamento e Teste da MLP =====\n');

for i = 1 : totalEpochs
    fprintf('Acurácia Época %d: %f\n', i, accuracy(i));
end 

fileID = fopen('vertebral_column_data/column_3C.dat');
C = textscan(fileID, '%f %f %f %f %f %f %s', 'Delimiter',',');

labelColumns = Utils.transformLabelsToColumns(C{7});
dataset = [C{1}, C{2}, C{3}, C{4}, C{5}, C{6}, labelColumns];

X = dataset(:, 1:6)';
D = dataset(:, 7:9)';
X = Utils.zscore(X);

model = RadialBasisFunction(30);
trainingPercentage = 0.7;
net = feedforwardnet(40);

totalEpochs = 10;

accuracy = zeros(1, totalEpochs);

for epoch = 1 : totalEpochs
    [X_train, Y_train, X_test, Y_test] = holdOutSamples(X, D, trainingPercentage);

    net = train(net, X_train, Y_train);
    prediction = net(X_test);
    [accuracy(epoch)] = validateModel(Y_test, prediction);
end

fprintf('===== Treinamento e Teste da MLP =====\n');

for i = 1 : totalEpochs
    fprintf('Acurácia Época %d: %f\n', i, accuracy(i));
end 

fprintf('Acurácia Média: %f\n', mean(accuracy));

function [accuracy] = validateModel(Y_test, prediction)
    [~, testSamples] = size(Y_test);

    [~, predictedClass] = max(prediction);
    [~, actualClass] = max(Y_test);

    hitsArr = predictedClass == actualClass;
    testHits = sum(hitsArr);
    accuracy = testHits / testSamples;
end

function [X_train, Y_train, X_test, Y_test] = holdOutSamples(X, D, trainingPercentage)
    [inputClasses, totalSamples] = size(X);
    [outputClasses, ~] = size(D);

    testingPercentage = 1 - trainingPercentage;
    quantityOfTestingSamples = round(testingPercentage * totalSamples);

    shuffledSampleIndexes = randperm(length(X));

    X_train = X(:, shuffledSampleIndexes);
    Y_train = D(:, shuffledSampleIndexes);
    
    X_test = zeros(inputClasses, quantityOfTestingSamples);
    Y_test = zeros(outputClasses, quantityOfTestingSamples);
    
    for i = 1 : quantityOfTestingSamples
        Y_test(:, i) = Y_train(:, i);
        X_test(:, i) = X_train(:, i);
        
        X_train(:, i) = [];
        Y_train(:, i) = [];
    end

end
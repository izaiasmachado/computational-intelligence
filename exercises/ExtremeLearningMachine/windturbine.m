dataset = importdata('aerogerador.dat');

X = dataset(:, 1)';
D = dataset(:, 2)';
X = zscore(X);

q = 20;
elm = ExtremeLearningMachine(q);
elm = elm.train(X, D);
prediction = elm.predict(X);

plot(X, D, '*', X, prediction, '-k');

function X = zscore(X)
    [n, ~] = size(X);
    
    for i = 1 : n
        x = X(i, :);
        X(i, :) = (x - mean(x)) / std(x);
    end
end

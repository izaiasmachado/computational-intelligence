dataset = importdata('aerogerador.dat');

x = dataset(:, 1);
y = dataset(:, 2);

X = x';
D = y';
X = zscore(X);

q = 20;
rbf = RadialBasisFunction(q, 1);
rbf = rbf.train(X, D);

y_prediction = rbf.predict(X);
plot(x, y, '*', x', y_prediction, '-k');

function X = zscore(X)
    [n, ~] = size(X);
    
    for i = 1 : n
        x = X(i, :);
        X(i, :) = (x - mean(x)) / std(x);
    end
end

dataset = importdata('aerogerador.dat');

X = dataset(:, 1)';
D = dataset(:, 2)';
X = Processing.zscore(X);

q = 20;
rbf = RadialBasisFunction(q);
rbf = rbf.train(X, D);

prediction = rbf.predict(X);
plot(X, D, '*', X, prediction, '-k');

r2 = Testing.r2(rbf, X, D);
fprintf('Erro Quadrático: %f\n', r2);

dataset = importdata('aerogerador.dat');

X = dataset(:, 1)';
D = dataset(:, 2)';
X = Processing.zscore(X);

q = 20;
elm = ExtremeLearningMachine(q);
elm = elm.train(X, D);

prediction = elm.predict(X);
plot(X, D, '*', X, prediction, '-k');

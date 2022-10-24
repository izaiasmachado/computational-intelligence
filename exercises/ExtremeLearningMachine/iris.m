fileID = fopen('iris.data');
C = textscan(fileID, '%f %f %f %f %s', 'Delimiter',',');

labelColumns = Processing.transformLabelsToColumns(C{5});
dataset = [C{1}, C{2}, C{3}, C{4}, labelColumns];

X = dataset(:, 1:4)';
D = dataset(:, 5:7)';
X = Processing.zscore(X);

q = 20;
elm = ExtremeLearningMachine(q);
accuracy = Testing.leaveOneOut(elm , X, D);
fprintf('Acurácia: %f\n', accuracy);
fileID = fopen('iris.data');
C = textscan(fileID,'%f %f %f %f %s', 'Delimiter',',');

[labelColumns, labels] = transformLabelsToColumns(C{5});
dataset = [C{1}, C{2}, C{3}, C{4}, labelColumns];

X = dataset(:, 1:4)';
D = dataset(:, 5:7)';
X = Processing.zscore(X);

q = 20;
rbf = RadialBasisFunction(q);
rbf = rbf.train(X, D);
y_prediction = rbf.predict(X(:, 101));

function [labelColumns, uniqueLabels] = transformLabelsToColumns(labels)
    N = length(labels);
    uniqueLabels = unique(labels);
    labelColumns = zeros(N, length(uniqueLabels));

    for i = 1 : N
        for j = 1 : length(uniqueLabels)
            labelColumns(i, j) = strcmp(labels{i}, uniqueLabels(j));
        end
    end
end
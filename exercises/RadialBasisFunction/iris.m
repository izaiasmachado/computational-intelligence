fileID = fopen('iris.data');
C = textscan(fileID,'%f %f %f %f %s', 'Delimiter',',');

labelColumns = transformLabelsToColumns(C{5});
[~, quantityClasses] = size(labelColumns);
dataset = [C{1}, C{2}, C{3}, C{4}, labelColumns];

x = dataset(:, 1:4);
y = dataset(:, 5:7);

X = x';
D = y';
X = zscore(X);

q = 20;
rbf = RadialBasisFunction(q, quantityClasses);
rbf = rbf.train(X, D);
y_prediction = rbf.predict(X(:, 10));

function labelColumns = transformLabelsToColumns(labels)
    N = length(labels);
    uniqueLabels = unique(labels);
    labelColumns = zeros(N, length(uniqueLabels));

    for i = 1 : N
        for j = 1 : length(uniqueLabels)
            labelColumns(i, j) = strcmp(labels{i}, uniqueLabels(j));
        end
    end
end

function X = zscore(X)
    [n, ~] = size(X);
    
    for i = 1 : n
        x = X(i, :);
        X(i, :) = (x - mean(x)) / std(x);
    end
end
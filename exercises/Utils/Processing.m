classdef Processing
    methods(Static)
        function x = addBias(x)
            [~, n] = size(x);
            x = [(-1) * ones(1, n); x];
        end

        function X = zscore(X)
            [n, ~] = size(X);
            
            for i = 1 : n
                x = X(i, :);
                X(i, :) = (x - mean(x)) / std(x);
            end
        end

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
    end
end


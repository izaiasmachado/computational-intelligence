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
    end
end


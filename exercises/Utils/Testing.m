classdef Testing
    
    methods(Static)
        function r2 = r2(model, X, D)
            predicted = model.predict(X);
            sqe = sum((D - predicted) .^ 2);
            syy = sum((D - mean(D)) .^ 2);
            r2 = 1 - (sqe / syy);
        end

        function accuracy = leaveOneOut(model, X, D)
            count = 0;
            [~, n] = size(X);
            
            for i = 1 : n
                x_train = X;
                d_train = D;

                x_test = x_train(:, i);
                d_test = d_train(:, i);
                
                x_train(:, i) = [];
                d_train(:, i) = [];

                model = model.train(x_train, d_train);
                predicted = model.predict(x_test);

                [~, target_class] = max(d_test);
                [~, predicted_class] = max(predicted);
                
                if target_class == predicted_class
                    count = count + 1;
                end
            end
            
            accuracy = count / n;
        end
    end
end


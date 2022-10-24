classdef Testing
    
    methods(Static)
        function leaveOneOut(net, X, D)
            count = 0;
            [~, n] = size(X);
            
            for i = 1 : n
                x_train = X;
                d_train = D;

                x_test = x_train(:, i);
                d_test = d_train(:, i);
                
                x_train(:, i) = [];
                d_train(:, i) = [];

                net = net.train(x_train, d_train);
                predicted = net.predict(x_test);

                [~, target_class] = max(d_test);
                [~, predicted_class] = max(predicted);
                
                if target_class == predicted_class
                    count = count + 1;
                end
            end
            
            accuracy = count / n;
            fprintf('Acurácia: %f\n', accuracy);
        end
    end
end


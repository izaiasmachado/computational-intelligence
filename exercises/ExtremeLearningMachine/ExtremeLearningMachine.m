classdef ExtremeLearningMachine
    properties
        q
        sigma
        W
        M
    end
    
    methods(Static)
        function fu = sigmoid(u, sigma)
            fu = exp(-u .^ 2 / (2 * sigma .^ 2));
        end
        
        function x = addBias(x)
            [~, n] = size(x);
            x = [(-1) * ones(1, n); x];
        end
    end

    methods
        function elm = ExtremeLearningMachine(q)
            elm.q = q;
            elm.sigma = 1;
        end
        
        function elm = train(elm, X, D)
            % Quantity Of Weight Equals the Number Of Input Features
            [p, ~] = size(X);
            elm = elm.calculateWeights(p);
            Z = elm.hiddenLayerTransformation(X);
            elm.M = D * Z' / (Z * Z');
        end

        function prediction = predict(elm, X)
            Z = elm.hiddenLayerTransformation(X);
            prediction = elm.M * Z;
        end

        function elm = calculateWeights(elm, p)
            elm.W = normrnd(0, elm.sigma, [elm.q, p + 1]);
        end

        function Z = hiddenLayerTransformation(elm, X)
            [~, n] = size(X);
            X = elm.addBias(X);
            Z = elm.W * X;
            Z = elm.sigmoid(Z, elm.sigma);
            Z = [(-1) * ones(1, n); Z];
        end
    end
end

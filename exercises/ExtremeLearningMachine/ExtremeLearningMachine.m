classdef ExtremeLearningMachine
    properties
        q
        sigma
        C
        M
    end

    methods
        function elm = ExtremeLearningMachine(q)
            elm.q = q;
            elm.sigma = 1;
        end
        
        function elm = train(elm, X, D)
            [p, ~] = size(X);
            elm = elm.calculateCentroids(p);
            Z = elm.hiddenLayerTransformation(X);
            elm.M = D * Z' / (Z * Z');
        end

        function prediction = predict(elm, X)
            Z = elm.hiddenLayerTransformation(X);
            prediction = elm.M * Z;
        end

        function elm = calculateCentroids(elm, p)
            elm.C = normrnd(0, elm.sigma, [elm.q, p + 1]);
        end

        function Z = hiddenLayerTransformation(elm, X)
            X = Processing.addBias(X);
            Z = elm.C * X;
            Z = Activation.sigmoid(Z, elm.sigma);
            Z = Processing.addBias(Z);
        end
    end
end

classdef RadialBasisFunction
    properties
        q
        sigma
        C
        M
        outputs
    end
    
    methods
        function rbf = RadialBasisFunction(q)
            rbf.q = q;
            rbf.sigma = 1;
        end
        
        function rbf = train(rbf, X, D)
            [p, ~] = size(X);
            rbf = rbf.calculateCentroids(p);
            Z = rbf.hiddenLayerTransformation(X);
            rbf.M = D * Z' / (Z * Z');
        end

        function prediction = predict(rbf, X)
            Z = rbf.hiddenLayerTransformation(X);
            prediction = rbf.M * Z;
        end

        function rbf = calculateCentroids(rbf, p)
            rbf.C = normrnd(0, rbf.sigma, [rbf.q, p + 1]);
        end

        function Z = hiddenLayerTransformation(rbf, X)
            [~, N] = size(X);
            Z = zeros(rbf.q, N);

            for i = 1 : N
                for neuronId = 1 : rbf.q
                    centroid = rbf.C(neuronId);
                    x = X(:, i);
                    u = norm(x - centroid);
                    fu = Activation.sigmoid(u, rbf.sigma);    
                    Z(neuronId, i) = fu;
                end
            end
            
            Z = Processing.addBias(Z);
        end
    end
end

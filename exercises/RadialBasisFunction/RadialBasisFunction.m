classdef RadialBasisFunction
    properties
        q
        sigma
        centroids
        M
        outputs
    end
    
    methods(Static)
        function fu = exponentialFunction(u, sigma)
            fu = exp(-u ^ 2 / (2 * sigma ^ 2));
        end
    end

    methods
        function rbf = RadialBasisFunction(q, outputs)
            rbf.q = q;
            rbf.sigma = 1;
            rbf.outputs = outputs;
            rbf.centroids = normrnd(0, rbf.sigma, [outputs, q]);
        end
        
        function rbf = train(rbf, X, D)
            Z = rbf.transformInput(X);
            rbf.M = D * Z' / (Z * Z');
        end

        function prediction = predict(rbf, X)
            Z = rbf.transformInput(X);
            prediction = rbf.M * Z;
        end

        function Z = transformInput(rbf, X)
            [~, N] = size(X);
            Z = zeros(rbf.q, N);

            for i = 1 : N
                for neuronId = 1 : rbf.q
                    centroid = rbf.centroids(neuronId);
                    x = X(:, i);
                    u = norm(x - centroid);
                    fu = rbf.exponentialFunction(u, rbf.sigma);    
                    Z(neuronId, i) = fu;
                end
            end
            
            Z = [(-1) * ones(1, N); Z];
        end
    end
end


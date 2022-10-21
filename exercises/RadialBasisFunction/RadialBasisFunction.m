classdef RadialBasisFunction
    properties
        q
        sigma
        centroids
        M
    end
    
    methods(Static)
        function fu = exponentialFunction(u, sigma)
            fu = exp(-u ^ 2 / (2 * sigma ^ 2));
        end
    end

    methods
        function rbf = RadialBasisFunction(q)
            rbf.q = q;
            rbf.sigma = 1;
            rbf.centroids = normrnd(0, rbf.sigma, [1, q]);
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
            N = length(X');
            Z = zeros(rbf.q, N);

            for i = 1 : N
                x = X(i);
                trainedNeuron = rbf.trainHiddenLayer(x);
                Z(:, i) = trainedNeuron;
            end
            
            Z = [(-1) * ones(1, N); Z];
        end

        function trainedNeuron = trainHiddenLayer(rbf, x)
            trainedNeuron = zeros(rbf.q, 1);

            for neuronId = 1 : length(trainedNeuron)
                centroid = rbf.centroids(neuronId);
                u = norm(x - centroid);
                fu = rbf.exponentialFunction(u, rbf.sigma);    
                trainedNeuron(neuronId) = fu;
            end
        end
    end
end


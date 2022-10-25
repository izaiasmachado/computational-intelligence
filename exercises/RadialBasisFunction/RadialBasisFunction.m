classdef RadialBasisFunction
    properties
        q % Neurons In Hidden Layer
        C % Hidden Layer Weights
        M % Output Layer Weights
        sigma % Neuron Standard Deviation
    end
    
    methods
        function rbf = RadialBasisFunction(q)
            rbf.q = q;
            rbf.sigma = 1;
        end
        
        function rbf = train(rbf, X, D)
            % TRAIN Train the Extreme Learning Machine Model.
            %
            % X: Input training data, where every column is an element and the lines
            % are the features.
            % D: Output training data, where every column is an element and
            % the lines are the output values.

            % Given the number of features in the databases, calculates the
            % hidden layer weights.

            [p, ~] = size(X);
            rbf = rbf.calculateHiddenLayersWeights(p);
            Z = rbf.outputHiddenLayer(X);
            rbf.M = D * Z' / (Z * Z');
        end

        function prediction = predict(rbf, X)
            % PREDICT Given values, this function returns the model
            % prediction.
            
            % Feeds the input to the hidden layer
            Z = rbf.outputHiddenLayer(X);
            
            % Does the dot product between the output of the hidden layer
            % and the weights of the output layer.
            prediction = rbf.M * Z;
        end

        function rbf = calculateHiddenLayersWeights(rbf, p)
            % CALCULATECENTROIDS Random Hidden Layers Weights, that are
            % defined using standard deviation.
            % 
            % p: Quantity of Input Classes (without bias).
            
            rbf.C = normrnd(0, rbf.sigma, [rbf.q, p + 1]);
        end

        function Z = outputHiddenLayer(rbf, X)
            % OUTPUTHIDDENLAYER Given an input vector, the return is the
            % dot product (C dot X) and this result goes in an activation
            % function.

            [~, n] = size(X);
            Z = zeros(rbf.q, n);

            for i = 1 : n
                for neuronId = 1 : rbf.q
                    centroid = rbf.C(neuronId);
                    x = X(:, i);
                    u = norm(x - centroid);
                    fu = Activation.sigmoid(u, rbf.sigma);
                    Z(neuronId, i) = fu;
                end
            end
            
            % Z is (q, n)
            Z = Processing.addBias(Z); % So with the row of bias, Z is (q + 1, n)
        end
    end
end

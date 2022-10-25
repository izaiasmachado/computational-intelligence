classdef ExtremeLearningMachine
    properties
        q % Neurons In Hidden Layer
        C % Hidden Layer Weights
        M % Output Layer Weights
        sigma % Neuron Standard Deviation
    end

    methods
        function elm = ExtremeLearningMachine(q)
            elm.q = q;
            elm.sigma = 1;
        end
        
        function elm = train(elm, X, D)
            % TRAIN Train the Extreme Learning Machine Model.
            %
            % X: Input training data, where every column is an element and the lines
            % are the features.
            % D: Output training data, where every column is an element and
            % the lines are the output values.

            % Given the number of features in the databases, calculates the
            % hidden layer weights.
            [p, ~] = size(X);
            elm = elm.calculateHiddenLayersWeights(p);
           
            % Feeds the input to the newly generated hidden layer and
            % returns the output
            Z = elm.outputHiddenLayer(X);

            % Calculated output layer weights (the actual learning).
            elm.M = D * Z' / (Z * Z');
        end

        function prediction = predict(elm, X)
            % PREDICT Given values, this function returns the model
            % prediction.
            
            % Feeds the input to the hidden layer
            Z = elm.outputHiddenLayer(X);
            
            % Does the dot product between the output of the hidden layer
            % and the weights of the output layer.
            prediction = elm.M * Z;
        end

        function elm = calculateHiddenLayersWeights(elm, p)
            % CALCULATECENTROIDS Random Hidden Layers Weights, that are
            % defined using standard deviation.
            % 
            % p: Quantity of Input Classes (without bias).
            
            elm.C = normrnd(0, elm.sigma, [elm.q, p + 1]);
        end

        function Z = outputHiddenLayer(elm, X)
            % OUTPUTHIDDENLAYER Given an input vector, the return is the
            % dot product (C dot X) and this result goes in an activation
            % function.
            
            X = Processing.addBias(X); % X is (p + 1, n)
            Z = elm.C * X; % C is (q, p + 1)
            Z = Activation.sigmoid(Z, elm.sigma);

            % So C dot X equals Z as (q, n)
            Z = Processing.addBias(Z); % So with the row of bias, Z is (q + 1, n)
        end
    end
end

classdef Validation
    methods(Static)
        function [X_train, Y_train, X_test, Y_test] = holdOutSamples(X, D, trainingPercentage)
            [inputClasses, totalSamples] = size(X);
            [outputClasses, ~] = size(D);
        
            testingPercentage = 1 - trainingPercentage;
            quantityOfTestingSamples = round(testingPercentage * totalSamples);
        
            shuffledSampleIndexes = randperm(length(X));
        
            X_train = X(:, shuffledSampleIndexes);
            Y_train = D(:, shuffledSampleIndexes);
            
            X_test = zeros(inputClasses, quantityOfTestingSamples);
            Y_test = zeros(outputClasses, quantityOfTestingSamples);
            
            for i = 1 : quantityOfTestingSamples
                Y_test(:, i) = Y_train(:, i);
                X_test(:, i) = X_train(:, i);
                
                X_train(:, i) = [];
                Y_train(:, i) = [];
            end
        end
        
        function [accuracy] = measureAccuracy(Y_test, prediction)
            [~, testSamples] = size(Y_test);
        
            [~, predictedClass] = max(prediction);
            [~, actualClass] = max(Y_test);
        
            hitsArr = predictedClass == actualClass;
            testHits = sum(hitsArr);
            accuracy = testHits / testSamples;
        end
    end
end


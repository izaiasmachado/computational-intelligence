classdef Activation
    methods(Static)
       function fu = sigmoid(u, sigma)
            fu = exp(-u .^ 2 / (2 * sigma .^ 2));
        end
    end
end


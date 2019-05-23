function res = actf(tact)
% sigmoid activation function
% tact - total activation
	%SIGMOID = @(z) 1./(1 + exp(-z));
	%res = SIGMOID(tact);
	res = 1.7159 * tanh(2/3 * tact) + 0.0001*tact;
end

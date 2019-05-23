function res = actfOld(tact)
% sigmoid activation function
% tact - total activation
	SIGMOID = @(z) 1./(1 + exp(-z));
	res = SIGMOID(tact);
end

function res = actdfOld(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!)
	res = sfvalue .* (1 - sfvalue);
end

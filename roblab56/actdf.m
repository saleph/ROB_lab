function res = actdf(tact)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!)
	%res = sfvalue .* (1 - sfvalue);
	res = 1.14393 * (sech(2/3 * tact)).^2 + 0.0001;
end

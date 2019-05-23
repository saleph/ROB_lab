function [networkOut terr] = backpropOld(tset, tslb, network, lr)
% derivative of sigmoid activation function
% tset - training set (every row represents act sample)
% tslb - column vector of labels 
% networkInit - initial layers weight matrix
% lr - learning rate

% network - layers weight matrix
% terr - total squared error of the ANN

	numLayers = numel(network) + 1;
	numLabels = columns(network{numLayers-1});
	M = rows(tset);

	% 1. Propagate input forward through the ANN
	act{1} = tset;
	for i=2:numLayers
		response{i} = [act{i-1} ones(M, 1)] * network{i-1};
		act{i} = actfOld(response{i});
	endfor

	% 2. init gradients for network
	for i=2:numLayers
		networkGrad{i-1} = zeros(size(network{i-1}));
	endfor

	% 3. Set desired output of the ANN
	desiredOut = zeros(M, numLabels);
	for i=1:M
		desiredOut(i, tslb(i)) = 1;
	endfor

	% 4. Compute gradients
	d{numLayers} = desiredOut - response{numLayers};
	for i=numLayers-1: -1: 1
		d{i} = (d{i+1} * network{i}') .* [actdfOld(act{i}) ones(M, 1)];
		d{i} = d{i}(:, 1:end-1);
		D{i} = d{i+1}' * [act{i} ones(M, 1)];
		networkGrad{i} = lr * D{i}';
	endfor

	% 5. Adjust total error
	terr = 0.5 * sum((act{numLayers}-desiredOut)(:).^2) / M;

	% 6. Apply gradients
	for i=2:numLayers
		networkOut{i-1} = network{i-1} + networkGrad{i-1};
	endfor
endfunction

function lab = anncls(tset, layersWeights)
% simple ANN classifier
% tset - data to be classified (every row represents a sample) 
% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix

% lab - classification result (index of output layer neuron with highest value)
% ATTENTION: we assume that constant value IS NOT INCLUDED in tset rows
	numLayers = numel(layersWeights) + 1;
	M = rows(tset);

	% forward prop
	act{1} = tset;
	for i=2:numLayers
		response{i} = [act{i-1} ones(M, 1)] * layersWeights{i-1};
		act{i} = actf(response{i});
	endfor

	[~, lab] = max(act{numLayers}, [], 2);
end
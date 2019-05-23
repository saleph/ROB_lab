function layers = crann(layerSize)
% generates hidden and output ANN weight matrices
% layerSize - number of neurons in the layers, cfeat at first pos, cclass at end

% ATTENTION: we assume that constant value (bias) IS NOT INCLUDED
	numLayers = numel(layerSize); % last layer is the output size
	for i=1:numLayers-1
		layers{i} = (rand(layerSize(i) + 1, layerSize(i+1)) - 0.5) / sqrt(layerSize(i) + 1);
	end
endfunction
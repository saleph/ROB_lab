function lab = cls1nn(train, x)
% 1-NN classifier
% ts training set (first column contains class labels)
% x - sample to be clasified (no label)
% lab = x's nearers neighbour label
	div_char = train(:, 2:end) - repmat(x, rows(train), 1);
	dist = sumsq(div_char, 2);
	[~, mi] = min(dist,[], 1);
	lab = train(mi, 1);
endfunction

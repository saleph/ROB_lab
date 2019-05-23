function lab = cls1nn(ts, x, mask)
% 1-NN classifier
% ts training set (first column contains class labels)
% x - sample to be clasified (no label)
% lab = x's nearers neighbour label
	div_char = ts(:, 2:end) - repmat(x, rows(ts), 1);
	dist = sumsq(div_char .* repmat(mask, rows(div_char), 1), 2);
	[~, mi] = min(dist,[], 1);
	lab = ts(mi, 1);
endfunction

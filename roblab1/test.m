function res = test(ts, mask)
% ts caly zbior
% mask maska do cech
	correct_sum = 0;
	for i = 1:rows(ts)
		sample = ts(i, :);
		curr_ts = ts(1:end != i, :);
		label = cls1nn(curr_ts, sample(1, 2:end), mask);
		correct_sum += label == sample(1, 1);
	endfor
	res = correct_sum/rows(ts);
endfunction

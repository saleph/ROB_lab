function out = bench(ts)
	masks = [
	1 0 0 0;
	0 1 0 0;
	0 0 1 0;
	0 0 0 1;
	1 1 0 0;
	1 0 1 0;
	1 0 0 1;
	0 1 1 0;
	0 1 0 1;
	0 0 1 1;
	1 1 1 0;
	1 1 0 1;
	1 0 1 1;
	0 1 1 1;
	1 1 1 1];

	for i = 1:rows(masks)
		disp(masks(i, :)), disp(test(ts, masks(i, :)))
	endfor
	out = 0;
endfunction

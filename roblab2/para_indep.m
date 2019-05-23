function para = para_indep(ts)
% Liczy parametry dla funkcji pdf_indep
% ts zbir uczcy (prbka = wiersz; w pierwszej kolumnie etykiety)
% para - struktura zawierajca parametry:
%	para.labels - etykiety klas
%	para.mu - wartoci rednie cech (wiersz na klas)
%	para.sig - odchylenia standardowe cech (wiersz na klas)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(rows(labels), columns(ts)-1);

	% tu trzeba wypeni wartoci rednie i odchylenie standardowe dla klas
  for i = 1:rows(labels);
    for j = 1:columns(ts)-1;
      para.mu(i, j) = mean(ts(ts(:, 1) == labels(i), j+1));
      para.sig(i, j) = std(ts(ts(:, 1) == labels(i), j+1));
    endfor
  endfor

end
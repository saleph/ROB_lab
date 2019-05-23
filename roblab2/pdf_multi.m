function pdf = pdf_multi(pts, para)
% Liczy funkcj gstoci prawdopodobiestwa wielowymiarowego r. normalnego
% pts zawiera punkty, dla ktrych liczy si f-cj gstoci (punkt = wiersz)
% para - struktura zawierajca parametry:
%	para.mu - wartoci rednie cech (wiersz na klas)
%	para.sig - macierze kowariancji cech (warstwa na klas)
% pdf - macierz gstoci prawdopodobiestwa
%	liczba wierszy = liczba prbek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.mu));
	
	% liczenie gstoci uproci uycie funkcji mvnpdf
  
  for i=1:rows(pts);
    for j=1:rows(para.mu);
      pdf(i, j) = mvnpdf(pts(i, :), para.mu(j, :), para.sig(:, :, j));
    endfor
  endfor
end

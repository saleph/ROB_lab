function pdf = pdf_indep(pts, para)
% Liczy funkcj gstoci prawdopodobiestwa przy zaoeniu, e cechy s niezalene
% pts zawiera punkty, dla ktrych liczy si f-cj gstoci (punkt = wiersz, bez etykiety!)
% para - struktura zawierajca parametry:
%	para.mu - wartoci rednie cech (wiersz na klas)
%	para.sig - odchylenia standardowe cech (wiersz na klas)
% pdf - macierz gstoci prawdopodobiestwa
%	liczba wierszy = liczba prbek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wic go alokuj
	pdf = zeros(rows(pts), rows(para.mu));

	% tu trzeba policzy warto funkcji gstoci
	% jako iloczyn gstoci jednowymiarowych
  
  for i=1:rows(pts);
    for j=1:rows(para.mu);
      pdf(i, j) = prod(normpdf(pts(i, :), para.mu(j, :), para.sig(j, :)));
    endfor
  endfor
end
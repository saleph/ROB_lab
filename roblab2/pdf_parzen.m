function pdf = pdf_parzen(pts, para)
% Aproksymuje warto gstoci prawdopodobiestwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla ktrych liczy si f-cj gstoci (punkt = wiersz)
% para - struktura zawierajca parametry:
%	para.samples - tablica komrek zawierajca prbki z poszczeglnych klas
%	para.parzenw - szeroko okna Parzena
% pdf - macierz gstoci prawdopodobiestwa
%	liczba wierszy = liczba prbek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.samples));
	
	% przy liczeniu gstoci warto zastanowi si
	% nad kolejnoci oblicze (ptli)
  
  for j=1:rows(para.samples)
    j
    hn = para.parzenw / sqrt(rows(para.samples{j}));
    for i=1:rows(pts)
      normparts = zeros(rows(para.samples{j}), 1);
      for k=1:rows(para.samples{j})
        normparts(k, 1) = prod(normpdf(para.samples{j}(k, :), pts(i, :), hn));
      endfor
      pdf(i, j) = mean(normparts);
    endfor
  endfor
end

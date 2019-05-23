function rds = reduce(ds, parts)
% Funkcja redukcji liczby pr�bek poszczeg�lnych klas w zbiorze ds
% ds - zbi�r danych do redukcji; pierwsza kolumna zawiera etykiet�
% parts - wierszowy wektor wsp�czynnik�w redukcji dla poszczeg�lnych klas

	labels = unique(ds(:,1));
	if rows(labels) ~= columns(parts)
		error("Liczba klas nie zgadza sie z liczba wsp. redukcji.");
	end

	if max(parts) > 1 || min(parts) < 0
		error("Niewlasciwe wspolczynniki redukcji.");
	end
	
	rds = [];
	for i=1:rows(labels);
		entriesOfThisClass = ds(ds(:, 1) == labels(i, 1), :);
		numToKeep = round(parts(i) * rows(entriesOfThisClass));
		indexes = randperm(rows(entriesOfThisClass), numToKeep);
		rds = [rds; entriesOfThisClass(indexes, :)];
	endfor
end
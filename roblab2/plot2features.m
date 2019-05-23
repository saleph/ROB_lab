function plot2features(tset, f1, f2)
	% rysuje punkty zbioru tset na dwuwymiarowym wykresie
	%  u�ywaj�c cech o indeksach f1 i f2
	% pierwsza kolumna tset zawiera etykiet�

	% parametry rysowania poszczeg�lnych klas (ograniczone do 8)
	pattern(1,:) = "ks";
	pattern(2,:) = "rd";
	pattern(3,:) = "mv";
	pattern(4,:) = "b^";
	pattern(5,:) = "kd";
	pattern(6,:) = "r^";
	pattern(7,:) = "mh";
	pattern(8,:) = "bd";
	
	res = tset(:, [f1, f2]);
	
	% wydobycie wszystkich etykiet pojawiaj�cych si� w tset
	labels = unique(tset(:,1));
	
	% utworzenie okna wykresu i zablokowanie usuwania zawarto�ci
	figure;
	hold on;
  
	for i=1:size(labels,1)
		idx = tset(:,1) == labels(i);
		plot(res(idx,1), res(idx,2), pattern(i,:));
    axis([0 0.003 0 0.003], "square");
	end
	hold off;
end

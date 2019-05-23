load train.txt
load test.txt


% PKT 1 ========================================================================
for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end

size(train)
size(test)
labels = unique(train(:,1))
unique(test(:,1))
[labels'; sum(train(:,1) == labels')]


% PKT 2 ========================================================================
[mean(train); median(train)]
hist(train(:,1))
plot2features(train, 4, 6)

[mv midx] = max(train)

midx = 186
train(midx-1:midx+1, :)
size(train)
train(midx, :) = [];
size(train)

[mv midx] = min(train)
midx = 641
train(midx-1:midx+1, :)
size(train)
train(midx, :) = [];
size(train)


% PKT 3 ======================================================================== 
first_idx = 3;
second_idx = 4;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);


pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 

base_ercf = zeros(1,3);
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
base_ercf


% PKT 4 ======================================================================== 
parts = [0.1 0.25 0.5];
rep_cnt = 5;
pkt4verify(train, test, parts, rep_cnt)


% PKT 5 ======================================================================== 
parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
parzen_res = pkt5verify(train, test, parzen_widths)

[parzen_widths; parzen_res]
semilogx(parzen_widths, parzen_res)


% PKT 6 ======================================================================== 
apriori = [0.165 0.085 0.085 0.165 0.165 0.085 0.085 0.165];
parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0];

repcnt = 5
base_ercf_5rep = zeros(repcnt,3);
cxfmRes_5rep = {};
for i=1:repcnt;
	i
	classificationRes = pkt6verify(train, test, apriori, parts);
	base_ercf_5rep(i, 1) = mean(classificationRes(:, 1) != classificationRes(:, 2));
	base_ercf_5rep(i, 2) = mean(classificationRes(:, 1) != classificationRes(:, 3));
	base_ercf_5rep(i, 3) = mean(classificationRes(:, 1) != classificationRes(:, 4));
	cxfmRes_5rep{1, i} = confMx(classificationRes(:, 1), classificationRes(:, 2));
	cxfmRes_5rep{2, i} = confMx(classificationRes(:, 1), classificationRes(:, 3));
	cxfmRes_5rep{3, i} = confMx(classificationRes(:, 1), classificationRes(:, 4));
endfor
base_ercf_5rep
cxfmRes_5rep

% dodatkowy test dla pełnych zbiorów
classificationResEquals = pkt6verify(train, test, repmat(0.165, 1, 8), repmat(1.0, 1, 8));
cxfmRes = {};
cxfmRes{1} = confMx(classificationResEquals(:, 1), classificationResEquals(:, 2));
cxfmRes{2} = confMx(classificationResEquals(:, 1), classificationResEquals(:, 3));
cxfmRes{3} = confMx(classificationResEquals(:, 1), classificationResEquals(:, 4));
cxfmRes


% PKT 7 ======================================================================== 
std(train(:,2:end))
plot2features(train, 3, 4)

% odchylenia per klasa
valuesPerClass = zeros(8, 5);
for i=1:8;
	valuesPerClass(i, 1) = i;
	valuesPerClass(i, 2:3) = mean(train(train(:, 1) == i, 2:end));
	valuesPerClass(i, 4:5) = std(train(train(:, 1) == i, 2:end));
end
valuesPerClass
% normalizacja NIE potrzebna (róznica std ~ 3,2%)

classResult = closestnncls(train, test);
mean(classResult != test(:,1))
confMx(test(:, 1), classResult(:, 1))
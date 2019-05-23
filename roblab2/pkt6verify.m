function classificationRes = pkt6verify(train, test, apriori, parts)

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 

reducedTest = reduce(test, parts);
size(test)
size(reducedTest)

classificationRes = zeros(rows(reducedTest), 4);
classificationRes(:, 1) = reducedTest(:, 1);
classificationRes(:, 2) = bayescls(reducedTest(:,2:end), @pdf_indep, pdfindep_para, apriori);
classificationRes(:, 3) = bayescls(reducedTest(:,2:end), @pdf_multi, pdfmulti_para, apriori);
classificationRes(:, 4) = bayescls(reducedTest(:,2:end), @pdf_parzen, pdfparzen_para, apriori);

end
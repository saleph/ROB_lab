function partsResult = pkt4verify(train, test, parts, rep_cnt)

    partsResult = {};
    for i=1:columns(parts);
        ercf = zeros(3, rep_cnt);
        for j=1:rep_cnt;
            j
            reducedTrain = reduce(train, repmat(parts(i), 1, 8));
            pdfindep_para = para_indep(reducedTrain);
            pdfmulti_para = para_multi(reducedTrain);
            pdfparzen_para = para_parzen(reducedTrain, 0.001); 
            ercf(1, j) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
            ercf(2, j) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
            ercf(3, j) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
        endfor
        partsResult{1, i} = parts(i);
        partsResult{2, i}(1, :) = [min(ercf(1, :)), max(ercf(1, :)), mean(ercf(1, :)), std(ercf(1, :))];
        partsResult{2, i}(2, :) = [min(ercf(2, :)), max(ercf(2, :)), mean(ercf(2, :)), std(ercf(2, :))];
        partsResult{2, i}(3, :) = [min(ercf(3, :)), max(ercf(3, :)), mean(ercf(3, :)), std(ercf(3, :))];
    endfor
end
    
function parzen_res = pkt5verify(train, test, widths)
    parzen_res = zeros(1, columns(widths));

    for i=1:columns(widths);
        widths(i)
        pdfparzen_para = para_parzen(train, widths(i)); 
        parzen_res(i) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
    endfor
end
function decv = closestnncls(train, test)

for i=1:rows(test);
    decv(i, 1) = cls1nn(train, test(i, 2:end));
endfor
end
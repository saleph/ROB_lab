% implement actf & check it on a graph
x = -5:0.01:5;
figure;
hold on;
plot(x, actf(x));
plot(x, actdf(actf(x)));
hold off;

% implement backprop 
% it makes sense to start with a really small dataset
load tiny.txt;
tlab = tiny(:,1);
tvec = tiny(:,2:end);

% improvements testing
% shuffle
M = rows(tvec);
idx = randperm(M);
tvec = tvec(idx,:);
tlab = tlab(idx,:);
% normalize
mn = mean(tvec);
sd = std(tvec);
sd(sd==0) = 1;
tvec = bsxfun(@minus,tvec,mn);
tvec = bsxfun(@rdivide,tvec,sd);
mn = mean(tstv);
sd = std(tstv);
sd(sd==0) = 1;
tstv = bsxfun(@minus,tstv,mn);
tstv = bsxfun(@rdivide,tstv,sd);

% new crann version
network = crann([columns(tvec) 4 3 2])

[network terr] = backprop(tvec, tlab, network, 0.01, 0);
clsRes = anncls(tvec, network);
cfmx = confMx(tlab, clsRes);
errcf = compErrors(cfmx)

% =========================================================
% ANN TRAINING
% reference implementation
[networkHistory trrep] = ann_trainingOld(0.1, [100 100], 50);
[_ ep] = max(trrep(:, 5));
clsResTrain = annclsOld(tvec, networkHistory{ep});
cfmxTrain = confMx(tlab, clsResTrain)
clsResTest = annclsOld(tstv, networkHistory{ep});
cfmxTest = confMx(tstl, clsResTest)
cfmxTest - (cfmxTrain ./ 6)

% improved implementation
[networkHistory trrep] = ann_training(0.0005, [100 100], 50);
[_ ep] = max(trrep(:, 5));
clsResTrain = anncls(tvec, networkHistory{ep});
cfmxTrain = confMx(tlab, clsResTrain)
clsResTest = anncls(tstv, networkHistory{ep});
cfmxTest = confMx(tstl, clsResTest)
cfmxTest - (cfmxTrain ./ 6)

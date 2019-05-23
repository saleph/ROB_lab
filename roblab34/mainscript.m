% mainscript is rather short this time

% primary component count
comp_count = 80; 

[tvec tlab tstv tstl] = readSets(); 

% let's look at the first digit in the training set
%imshow(1-reshape(tvec(1,:), 28, 28)');

% let's check labels in both sets
[unique(tlab)'; unique(tstl)']

% compute and perform PCA transformation
[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% let's shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

% To successfully prepare ensemble you have to implement perceptron function
% I would use 10 first zeros and 10 fisrt ones 
% and only 2 first primary components
% It'll allow printing of intermediate results in perceptron function

%
% YOUR CODE GOES HERE - testing of the perceptron function

% najpierw wybrac kilkanascie 0 i 1 - powinno zawsze
% potem wszystkie 0 i 1 - powinne z ułamkiem skut. trafiac
% potem na trudnej parze pobawic sie wspolczynnikiem uczenia
% napisać jawnie GLOSOWANIE JEDNOGLOSNE
% KLASYCZNY KLASYFIKATOR PERCEPTRONOWY
% JAK MODYFIKOWAĆ STALA UCZENIA
% dwa punkty to praktycznie 2 zdania 
% jaki klasyfikator chcialbym poprawic - koniecznie z macierza pomylek
clsNo = 10;
classes = [1:clsNo];
classesRepresentation = repmat(100, 1, clsNo);
attribNo = 10;
clear *PreTest;
[tvecPreTest tlabPreTest tstvPreTest tstlPreTest] = pretestvecgen(classes, classesRepresentation, attribNo, tvec, tlab, tstv, tstl);
ovoPreTest = trainOVOensamble(tvecPreTest, tlabPreTest, @perceptron);
% check your ensemble on train set
clabPreTest = unamvoting(tvecPreTest, ovoPreTest);
 cfmxPreTest = confMx(tlabPreTest, clabPreTest);
compErrors(cfmxPreTest)

% repeat on test set
clabPreTest = unamvoting(tstvPreTest, ovoPreTest);
cfmxPreTest = confMx(tstlPreTest, clabPreTest);
compErrors(cfmxPreTest)

% training of the whole ensemble
ovo = trainOVOensamble(tvec, tlab, @perceptron);

% check your ensemble on train set
clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)

%
% YOUR CODE GOES HERE
% =========== classifires correctness analysis for training set ===========
classifiersErrorTrain = classifiersError(tvec, tlab, ovo);
% classifiers error rates
classifiersErrorTrain([1 3], :)

classifiersErrorRatesTrain = [classifiersErrorTrain{3, :}]';
[_ posWorstTrain] = max(classifiersErrorRatesTrain, [], 1);
% worst classifier
classifiersErrorTrain(:, posWorstTrain)


% =========== classifires correctness analysis for test set ===========
classifiersErrorTest = classifiersError(tstv, tstl, ovo);
% classifiers error rates
classifiersErrorTest([1 3], :)

classifiersErrorRatesTest = [classifiersErrorTest{3, :}]';
[_ posWorstTest] = max(classifiersErrorRatesTest, [], 1);
% worst classifier
classifiersErrorTest(:, posWorstTest)


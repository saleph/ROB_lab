function [sepplane posmiss negmiss] = perceptron(pclass, nclass)
% Computes separating plane (linear classifier) using
% perceptron method.
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% posmiss - number (coefficient) of misclassified samples of pclass
% negmiss - number (coefficient) of misclassified samples of nclass

  sepplane = rand(1, columns(pclass) + 1) - 0.5;
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples
  tset = [ ones(nPos, 1) pclass; -ones(nNeg, 1) -nclass];

  i = 1;
  do 
	%%% YOUR CODE GOES HERE %%%
	%% You should:
	%% 1. Check which samples are misclassified (boolean column vector)
	%% 2. Compute separating plane correction 
	%%		This is sum of misclassfied samples coordinate times learning rate 
	%% 3. Modify solution (i.e. sepplane)
    misclassifiedIndexes = (sepplane*tset') < 0;
    if (sum(misclassifiedIndexes) == 0)
        break;
    endif;
    sumOfMisscorrections = sum(tset(misclassifiedIndexes, :), 1);
    %correctionFactor = 1.0*log10(i+10)/i;
    % correctionFactor = 1.0/sqrt(i/20);
    % correctionFactor = 1.0/i;
    correctionFactor = 1.0/sqrt(i);
    sepplane += correctionFactor*sumOfMisscorrections;
	++i;
  until i > 200;

  %%% YOUR CODE GOES HERE %%%
  %% You should:
  %% 1. Compute the numbers (coefficients) of misclassified positive 
  %%    and negative samples
  misclassifiedIndexes = (sepplane*tset') < 0;
  posmiss = sum(misclassifiedIndexes(1:nPos))/nPos;
  negmiss = sum(misclassifiedIndexes(nPos+1:nPos+nNeg))/nNeg;

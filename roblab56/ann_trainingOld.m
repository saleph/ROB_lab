function [networkHistory trReport] = ann_trainingOld(learningRate, noHiddenNeurons, noEpochs)

[tvec tlab tstv tstl] = readSets(); 
tlab += 1;
tstl += 1;

rand();
%rndstate = rand("state");
%save rndstate.txt rndstate;
load rndstate.txt;
rand("state", rndstate);

network = crann([columns(tvec) noHiddenNeurons numel(unique(tlab))]);
trainCorrect = zeros(1, noEpochs);
testCorrect = zeros(1, noEpochs);
trReport = [];
for epoch=1:noEpochs
	tic();
	terr = 0;
	for i=1:rows(tvec)
		[network terrN] = backpropOld(tvec(i, :), tlab(i, :), network, learningRate);,
		terr += terrN;
	end
	terr /= rows(tvec);
	clsRes = annclsOld(tvec, network);
	cfmx = confMx(tlab, clsRes);
	errcf = compErrors(cfmx);
	trainCorrect(epoch) = 1-errcf(2);

	clsRes = annclsOld(tstv, network);
	cfmx = confMx(tstl, clsRes);
	errcf2 = compErrors(cfmx);
	testCorrect(epoch) = 1-errcf2(2);
	epochTime = toc();
	disp([epoch epochTime terr trainCorrect(epoch) testCorrect(epoch)])
	trReport = [trReport; epoch epochTime terr trainCorrect(epoch) testCorrect(epoch)];
	fflush(stdout);
	networkHistory{epoch} = network;
endfor

end
%    1.00000   30.17691    0.24450    0.25180
%    2.00000   31.12491    0.18698    0.19960
%    3.00000   30.59097    0.16920    0.18040
%    4.00000   31.06386    0.15950    0.17210
%    5.00000   31.75206    0.15330    0.16730
%    6.00000   31.43731    0.14855    0.16370
%    7.00000   30.46351    0.14465    0.16060
%    8.00000   31.29037    0.14105    0.15740
%    9.00000   29.81666    0.13807    0.15500
%   10.00000   30.81062    0.13545    0.15190
%   11.00000   30.55734    0.13315    0.14940
%   12.00000   30.46908    0.13075    0.14740
%   13.00000   31.10582    0.12840    0.14600
%   14.00000   29.73761    0.12680    0.14480
%   15.00000   30.82240    0.12515    0.14270
%   16.00000   30.02360    0.12365    0.14240
%   17.00000   30.73690    0.12255    0.14180
%   18.00000   30.78330    0.12130    0.13950
%   19.00000   31.14686    0.12017    0.13950
%   20.00000   30.51724    0.11885    0.13780
%   21.00000   29.88146    0.11757    0.13700
%   22.00000   29.70980    0.11617    0.13550
%   23.00000   30.46397    0.11545    0.13490
%   24.00000   29.59985    0.11452    0.13420
%   25.00000   34.53386    0.11352    0.13380
%   26.00000   32.01237    0.11250    0.13340
%   27.00000   30.97313    0.11183    0.13350
%   28.00000   30.97853    0.11083    0.13260
%   29.00000   30.84983    0.10990    0.13220
%   30.00000   31.27375    0.10902    0.13130
%   31.00000   30.80349    0.10815    0.13080
%   32.00000   31.26564    0.10735    0.13020
%   33.00000   31.23966    0.10663    0.12970
%   34.00000   30.70864    0.10580    0.12910
%   35.00000   30.95621    0.10498    0.12870
%   36.00000   31.24288    0.10432    0.12860
%   37.00000   31.13424    0.10360    0.12830
%   38.00000   31.02594    0.10293    0.12810
%   39.00000   31.24091    0.10208    0.12770
%   40.00000   31.09970    0.10145    0.12710
%   41.00000   30.74089    0.10092    0.12650
%   42.00000   30.90121    0.10035    0.12600
%   43.00000   31.69269    0.09975    0.12620
%   44.00000   30.99791    0.09928    0.12620
%   45.00000   29.46367    0.09872    0.12630
%   46.00000   33.66796    0.09823    0.12620
%   47.00000   30.64872    0.09767    0.12620
%   48.00000   32.40927    0.09720    0.12590
%   49.00000   33.03308    0.09675    0.12610
%   50.00000   31.08195    0.09617    0.12580

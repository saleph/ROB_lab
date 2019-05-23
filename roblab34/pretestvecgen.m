function [tvecPreTest tlabPreTest tstvPreTest tstlPreTest] = pretestvecgen(classes, classesRepresentation, attribNo, tvec, tlab, tstv, tstl)
	tvecPreTest = [];
    tlabPreTest = [];
    tstvPreTest = [];
    tstlPreTest = [];

	for i=1:columns(classes);
        classLabel = classes(i);
        classRepr = classesRepresentation(i);

        indexes = tlab == classLabel;
        tvecPreTest = [ tvecPreTest; tvec(indexes, 1:attribNo)(1:classRepr, :) ];
        tlabPreTest = [ tlabPreTest; tlab(indexes, 1)(1:classRepr, :) ];
        
        indexes = tstl == classLabel;
        tstvPreTest = [ tstvPreTest; tstv(indexes, 1:attribNo)(1:classRepr, :) ];
        tstlPreTest = [ tstlPreTest; tstl(indexes, 1)(1:classRepr, :) ];
	endfor
end
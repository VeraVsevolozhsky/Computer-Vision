function [X] = DIMRjalphaA(X,outparams);

[X] = outnormalizeDataX(X,outparams.normXparams);
X = outparams.D*X;

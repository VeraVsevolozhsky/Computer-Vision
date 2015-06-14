function [X,outparams] = DIMRnormalize(X,y,inparams)

%inparams is not used!
[X,normXparams] = OHCLSVERoutnormalizeDataX(X);
outparams.normXparams = normXparams;

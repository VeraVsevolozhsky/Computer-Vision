function [X,outparams] = DIMRjalpha(X,y,inparams);

if nargin<3
  inparams.normparams = [];
  inparams.jalphaparams.supervised = 0;
end

if nargin<2,
  y = [];
end

warning off; 
addpath ~/jalpha
warning on;

[X,normXparams] = OHCLSVERoutnormalizeDataX(X,[],inparams.normparams);
outparams.normXparams = normXparams;

alpha = JAlpha(X,inparams.jalphaparams,y);
outparams.alpha = alpha;
D = speye(length(alpha));
ii = find(D(:));
D(ii) = sqrt(abs(alpha));
outparams.D = D;
X = D*X;

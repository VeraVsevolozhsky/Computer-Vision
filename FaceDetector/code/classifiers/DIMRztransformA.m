function [X] = DIMRztransformA(X,outparams)

ns = size(X,2);
normXweights = outparams.normXparams;
X = X - normXweights(:,1)*ones(1,ns);
tmp = speye(size(normXweights,1));
tmp(find(tmp)) = normXweights(:,2);
X = tmp*X;


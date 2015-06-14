function [X,outparams] = DIMRztransform(X,y,inparams)

%inparams is not used!
%y is not used!
nf = size(X,1);
ns = size(X,2);

normXweights = zeros(nf,2);
normXweights(:,2) = 1;
outstd = sqrt(2);
normXweights(:,1) = (sum(X')')./ns; %mean
normXweights(:,2) = std(X,[],2);
normXweights(:,2) = 1./(normXweights(:,2)+~normXweights(:,2));
X = X - normXweights(:,1)*ones(1,ns);
tmp = speye(size(normXweights,1));
tmp(find(tmp)) = normXweights(:,2);
X = tmp*X;

outparams.normXparams = normXweights;

function [X,outparams] = DIMRpca(X,y,inparams)

if nargin<3,
  inparams.npcs = -1;
end

uniquey = unique(y);
nc = length(uniquey);
ns = size(X,2);

if inparams.npcs<=0
  npcs = ns-nc;
else
  npcs = inparams.npcs;
end

meanX = mean(X')';
X = X - meanX*ones(1,size(X,2));

[PC,S] = svds(X,npcs);
X = PC'*X;

outparams.meanX = meanX;
outparams.W = PC;
outparams.S = S;
outparams.npcs = npcs;



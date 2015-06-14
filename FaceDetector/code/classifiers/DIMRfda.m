function [X,outparams] = DIMRfda(X,y,inparams)

if nargin<3,
  inparams.PREPCA = 0;
  inparams.REGULARIZATIONCONSTANT = .01;
  inparams.numdims = -1;
end

uniquey = unique(y);
nc = length(uniquey);
ns = size(X,2);

if inparams.numdims<=0
  numdims = nc -1;
else
  numdims = inparams.numdims;
end



if(inparams.PREPCA)
    %first take first N-c PCA dimensions
    npcs = ns-nc;
    [PC,S,V] = svds(X,npcs);
    X = PC'*X;
end
nf = size(X,1);


muData = mean(X,2);
%zmX = X - muData*ones(1,ns);
Sb = zeros(nf);
Sw = zeros(nf);
%compute between class scatter and within class scatter
%loop over classes
for i = 1:nc
    which_in_c = find(y == uniquey(i));
    n_in_c = length(which_in_c);
    mu_of_c = mean(X(:,which_in_c),2);
    dif_of_mu = (mu_of_c) - (muData);
    Sb = Sb + (1 / n_in_c) * (dif_of_mu) * (dif_of_mu)';
    ZXc = X(:,which_in_c) - mu_of_c*ones(1,n_in_c);
    Sw = Sw + ZXc*ZXc';
end

%minSw = min(min(Sw));
maxeig = eigs(Sw,1);
Sw = Sw + inparams.REGULARIZATIONCONSTANT * eye(size(Sw))*maxeig;
Sw = (Sw + Sw')/2;
optsnotalky.disp = 0;
[Wfish,lambfish] = eigs(Sb,Sw,numdims,'LM',optsnotalky);
if inparams.PREPCA,
  W = PC * Wfish;
  for i = 1:size(W,2), W(:,i) = W(:,i) / norm(W(:,i));  end
else
  W = Wfish;
end

%fprintf('in fda normalize the columns of W to have unit norm\n');

X = Wfish'*X;

outparams.W = W;
outparams.lambfish = lambfish;
outparams.maxeig = maxeig;



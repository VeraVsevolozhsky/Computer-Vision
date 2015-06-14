function [x,Model] = DIMRrca(X,y,inparams)

inparams.REGULARIZATIONCONSTANT = .01;

uniquey = unique(y);
nc = length(uniquey);
ns = size(X,2);
nf = size(X,1);

muData = mean(X,2);
Sw = zeros(nf);
%compute between class scatter and within class scatter
%loop over classes
for i = 1:nc
    which_in_c = find(y == uniquey(i));
    n_in_c = length(which_in_c);
    mu_of_c = mean(X(:,which_in_c),2);
    ZXc = X(:,which_in_c) - mu_of_c*ones(1,n_in_c);
    Sw = Sw + ZXc*ZXc';
end

optsnotalky.disp = 0;
maxeig = eigs(Sw,1,'LM',optsnotalky);
Sw = Sw + inparams.REGULARIZATIONCONSTANT * eye(size(Sw))*maxeig;
Sw = (Sw + Sw')/2;

if nf<=4000,
  Wfish = sqrtm(Sw);
  Wfish = inv(Wfish);
else
  [tmp,Wfish] = sqrtmiter(Sw);
end
w = Wfish;
x = Wfish'*X;

Model.w = w;

function [Y,Z] = sqrtmiter(A);

Y = A;
Z = eye(size(A,1));

for i = 1:5,
  fprintf('I');
  prevY = Y;
  Y = 0.5*(Y+inv(Z));
  Z = 0.5*(Z+inv(prevY));
end

fprintf('\n');

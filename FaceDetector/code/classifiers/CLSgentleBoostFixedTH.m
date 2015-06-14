function Model = CLSgentleBoostFixedTH(X,y,sPARAMS);

if nargin<3
  sPARAMS.Nrounds = 100;
end

Nrounds = sPARAMS.Nrounds;
if length(Nrounds) == 1,
  Nrounds = [Nrounds Nrounds];
end

uniquey = unique(y);
if length(uniquey)==1
  uniquey = [0 1];
end

Model.uniquey = uniquey;
Model.Nrounds = Nrounds;
warning off MATLAB:divideByZero
Model.classifier = ...
    gentleBoostInsistFixedTH(X,2*(y~=uniquey(1))'-1,Nrounds);
warning on MATLAB:divideByZero
fprintf('\n');

function [Model] = CLSknncls(X,y,sPARAMS);

if nargin<3
  sPARAMS.k = ceil(length(y)/10);
end

if ~isfield(sPARAMS,'deg')
  sPARAMS.deg = 2;
end

Model.k = sPARAMS.k;
Model.deg = sPARAMS.deg;
Model.trainX = X;
Model.trainy = y;
Model.secondstagecls = sPARAMS.secondstagecls;

if isfield(sPARAMS,'numindeces')
  Model.numindeces = sPARAMS.numindeces;
else
  Model.numindeces = inf;
end


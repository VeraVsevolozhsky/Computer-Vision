function [Model] = CLSmmlr(X,y,sPARAMS);

if nargin<3
  sPARAMS.th = 0;
end

Model.trainX = X;
Model.trainy = y;
Model.sPARAMS = sPARAMS;


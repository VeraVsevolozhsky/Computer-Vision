function Model = CLSgentleBoostTree(X,y,sPARAMS);

if nargin<3
  sPARAMS.Nrounds = 100;
  sPARAMS.R = 0;
  sPARAMS.T = 0;
else
  if ~isfield(sPARAMS,'R');
    sPARAMS.R = 0;
  end
  if ~isfield(sPARAMS,'T');
    sPARAMS.T = 0;
  end
end

Nrounds = sPARAMS.Nrounds(1);

%uniquey = unique(y);

if ~sPARAMS.R & ~sPARAMS.T,
  Model.classifier = gentleBoostTree(X,y,Nrounds);
else
  error('Tree: unknown R or T option');
end  
fprintf('\n');

%featuresused = zeros(Nrounds(1),1);
%for i =1:Nrounds, featuresused(i) = ...
%    Model.classifier(i).featureNdx; end;
%Model.featuresused = featuresused;

%Model.uniquey = uniquey;
Model.Nrounds = Nrounds;
Model.R = sPARAMS.R;
Model.T = sPARAMS.T;

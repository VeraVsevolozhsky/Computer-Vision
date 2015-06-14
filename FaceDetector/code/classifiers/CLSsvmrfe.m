function Model = CLSsvmrfe(X0,y,sPARAMS);
% SVM-RFE (SVM-Recursive Feature Elimination)
% from "Gene Selection for Cancer Classification using Support
% Vector Machines", Guyon 2002.

sPARAMSosusvm.classfunc = 'CLSosusvm';
sPARAMSosusvm.C = 1;
if (isfield(sPARAMS,'TERMINATIONEPSILON') & sPARAMS.TERMINATIONEPSILON>0)
  sPARAMSosusvm.KERNEL = 0.1
  sPARAMSosusvm.TERMINATIONEPSILON = sPARAMS.TERMINATIONEPSILON;
else
  sPARAMSosusvm.KERNEL = 0;
end


if (not(isfield(sPARAMS, 'eliminations')))
  sPARAMS.eliminations = 1;
end

% Initialize
% Subset of surviving features
[nfeat,nexamp] = size(X0);
s = 1:nfeat;
% Feature ranked list
r = [];

% Repeat until s = []
while (length(s) > sPARAMS.feature_limit)
  % Restrict training examples to good feature indices
  X = X0(s,:);
  
  % Train the classifier
  model = CLSosusvm(X,y,sPARAMSosusvm);
  
  % Compute the weight vector of dimension length(s)
  w = model.SVs*model.AlphaY';

  % Compute the ranking criteria
  c = w.^2;
  
  if 0
    % Find the feature with smallest ranking criterion
    [tmp,f] = min(c);
    
    % Update feature ranked list
    r = [s(f),r];
    
    % Eliminate the feature with smallest ranking criterion
    %s = s([1:f-1, f+1:end]);
    s(f) = [];
  else
    [sc,si] = sort(c,'ascend');
    eliminate = min(sPARAMS.eliminations, length(s) - sPARAMS.feature_limit);
    ei = si(1:eliminate);
    r = [s(ei), r];
    s(ei) = [];
  end
end
% Output
% Feature ranked list r

X = X0(s,:);
%Model.s = s;
Model.featuresused = s;
Model.SVM_Model = CLSosusvm(X,y,sPARAMSosusvm);
Model.rfeParameters = sPARAMS;

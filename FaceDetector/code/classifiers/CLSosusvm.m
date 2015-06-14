function Model = CLSosusvm(Xtrain,Ytrain,sPARAMS);
addpath osusvm
Ytrain = Ytrain';
if nargin<3
  SETPARAMS = 1;
elseif isempty(sPARAMS)
  SETPARAMS = 1;
else
  SETPARAMS = 0;
end

if SETPARAMS
  sPARAMS.KERNEL = 0;
  sPARAMS.C = 1;
end

switch sPARAMS.KERNEL,
  case 0,
    [AlphaY, SVs, Bias, Parameters, nSV, nLabel] = ...
	LinearSVC(Xtrain, Ytrain, sPARAMS.C);
  case 1,
    [AlphaY, SVs, Bias, Parameters, nSV, nLabel] = ...
	PolySVC(Xtrain, Ytrain, sPARAMS.DEGREE, sPARAMS.C, 1,0);
  case 2,
    [AlphaY, SVs, Bias, Parameters, nSV, nLabel] = ...
	PolySVC(Xtrain, Ytrain, sPARAMS.DEGREE, sPARAMS.C, 1,sPARAMS.COEF);
  case 3,
    [AlphaY, SVs, Bias, Parameters, nSV, nLabel] = ...
	RbfSVC(Xtrain, Ytrain, sPARAMS.GAMMA, sPARAMS.C);
  case 0.1,
    'EARLY TERMINATION'
    [AlphaY, SVs, Bias, Parameters, nSV, nLabel] = ...
	LinearSVCearlyTermination(Xtrain, Ytrain, sPARAMS.C,sPARAMS.TERMINATIONEPSILON);
    
end

Model.AlphaY = AlphaY;
Model.SVs = SVs;
Model.Bias = Bias;
Model.Parameters = Parameters;
Model.nSV = nSV;
Model.nLabel = nLabel;
Model.sPARAMS = sPARAMS;


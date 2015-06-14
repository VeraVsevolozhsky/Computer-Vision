function Model = REGosusvm(Xtrain,Ytrain,sPARAMS);

Ytrain = Ytrain';
if nargin<3
  sPARAMS.KERNEL = 0;
  sPARAMS.epsilon = 0.1;
  sPARAMS.C = 1;
end
%epsilon svm
PARAMS = [0 1 1 1 1 40 1.0000e-03 3 0.0220 0.1000 1];
PARAMS(10) = sPARAMS.epsilon;
PARANS(5) = sPARAMS.C;
PARAMS(1) = sPARAMS.KERNEL;

%%KERNELS ARE BY OSUSVM DEFUALT
switch sPARAMS.KERNEL,
  case 0,
  case 1,
    PARAMS(3) =  sPARAMS.GAMMA;
    PARAMS(4) =  sPARAMS.COEF;
    PARAMS(2) =  sPARAMS.DEGREE;
  case 2,
    PARAMS(3) =  sPARAMS.GAMMA;    
  case 3,
    PARAMS(3) =  sPARAMS.GAMMA;
    PARAMS(4) =  sPARAMS.COEF;
end

[AlphaY,SVs,Bias,Parameters,nSV,nLabel] = SVMTrain(Xtrain, Ytrain, PARAMS);
Model.AlphaY = AlphaY;
Model.SVs = SVs;
Model.Bias = Bias;
Model.Parameters = Parameters;
Model.PARAMS = PARAMS; %should be same as previous...
Model.nSV = nSV;
Model.nLabel = nLabel;
Model.sPARAMS = sPARAMS;


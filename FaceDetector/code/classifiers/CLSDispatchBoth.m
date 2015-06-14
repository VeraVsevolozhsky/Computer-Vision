function [errrate,Model,ry,weights,sROC] = CLSDispatchBoth(X1,y1,ModelsPARAMS,X2,y2)
%note: not using real cls interface, no CLSDispatchBothC
%used to run both training and testing

%errs is a vector of all cv results
TRASDUCTIVE = 0;
if isfield(ModelsPARAMS,'T'),
  TRASDUCTIVE = ModelsPARAMS.T,
end

if TRASDUCTIVE
  ModelsPARAMS.classfierparams.uX = X2;
  if TRASDUCTIVE==2
    ModelsPARAMS.classfierparams.uy = [];
  end
end

command = sprintf('Model = %s(X1,y1,ModelsPARAMS.classfierparams);',ModelsPARAMS.classfierparams.classfunc);
eval(command);

if nargin>3,
  command = sprintf('[ry,weights] = %sC(X2,Model);',ModelsPARAMS.classfierparams.classfunc);
  eval(command);
  if size(ry,2)>size(ry,1),
    ry = ry';
    weights = weights';
  end
  errrate = mean(y2~=ry);
else
  errrate = -1;
  ry = [];
  weights = [];
end

if nargin>4
  sROC = ROCetc(weights,y2);
end

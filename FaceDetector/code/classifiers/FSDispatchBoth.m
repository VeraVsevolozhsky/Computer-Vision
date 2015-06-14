function [pX1,pX2] = FSDispatchBoth(X1,y1,FSPARAMS,X2);

if isempty(FSPARAMS)
  pX1 = X1;
  pX2 = X2;
else
  command = sprintf('[pX1,FSModel] = %s(X1,y1,FSPARAMS);',FSPARAMS.fsfunc);
  eval(command);
  command = sprintf('pX2 = %sA(X2,FSModel);',FSPARAMS.fsfunc);
  eval(command);
end

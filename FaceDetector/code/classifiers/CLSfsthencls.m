function [Model] = CLSfsthencls(X1,y1,FSPARAMS);

nmethods = length(FSPARAMS.cmethods);
Model.cmodels = cell(nmethods,1);

for i = 1:nmethods-1
  command = sprintf('[X1,Model.cmodels{i}] = %s(X1,y1,FSPARAMS.cmethods{i});',FSPARAMS.cmethods{i}.fsfunc);
  eval(command);
  Model.cmodels{i}.fsfunc = FSPARAMS.cmethods{i}.fsfunc;
end

command = sprintf('Model.cmodels{nmethods} = %s(X1,y1,FSPARAMS.cmethods{nmethods});',FSPARAMS.cmethods{nmethods}.classfunc);
eval(command);
Model.cmodels{nmethods}.classfunc = FSPARAMS.cmethods{nmethods}.classfunc;

function [ry,weights] = CLSfsthenclsC(X,Model);

nmethods = length(Model.cmodels);

for i = 1:nmethods-1
  command = sprintf('X = %sA(X,Model.cmodels{i});',Model.cmodels{i}.fsfunc);
  eval(command);
end

command = sprintf('[ry,weights] = %sC(X,Model.cmodels{nmethods});',Model.cmodels{nmethods}.classfunc);
eval(command);
if size(ry,2)>size(ry,1),
  ry = ry';
  weights = weights';
end

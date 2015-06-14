function [y,h] = CLSadaBoostC(X,Model);

h = zeros(size(X,2),1);
for i = 1:length(Model.cModels),
  [Cx,Fx] = adaBoostClassifier(X,Model.cModels{i});
  h = h + Model.alpha(i) * Cx;
end

y = sign(h);

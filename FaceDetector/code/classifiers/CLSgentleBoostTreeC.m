function [labels,weights] = CLSgentleBoostTreeC(X,Model);

[Cx,Fx] = strongGentleClassifierTree(X,Model.classifier); 
weights = Fx;
labels = Cx;
%labels = Model.uniquey(Cx);

function [labels,weights] = CLSgentleBoostFixedTHC(X,Model);

[Cx,Fx] = strongGentleClassifierFixedTH(X,Model.classifier); 
weights = Fx;
Cx = sign(Fx-eps);
Cx = (Cx+3)/2;
labels = Model.uniquey(Cx);

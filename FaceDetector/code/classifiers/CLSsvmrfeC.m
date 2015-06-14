function [labels, weights]= CLSsvmrfeC(X0, Model);
% SVM-RFE (SVM-Recursive Feature Elimination)
% from "Gene Selection for Cancer Classification using Support
% Vector Machines", Guyon 2002.

X = X0(Model.featuresused,:);
[labels, weights] = CLSosusvmC(X, Model.SVM_Model);

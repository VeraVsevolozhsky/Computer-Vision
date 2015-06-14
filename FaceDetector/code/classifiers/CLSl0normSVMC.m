function [labels, weights]= CLSl0normSVMC(X, Model);
% l0-norm SVM
% from "An Introduction to Variable and Feature Selection"
% by Guyon and Elisseeff (p. 1169)

[nfeat,nexamp] = size(X);
%Xscaled = X(Model.features_used,:) .* repmat(Model.feature_scale, [1,nexamp]);
Xscaled = X(Model.featuresused,:);
[labels, weights] = CLSlibsvmC(Xscaled, Model.SVM_Model);

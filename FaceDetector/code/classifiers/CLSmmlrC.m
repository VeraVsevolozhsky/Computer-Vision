function [labels,weights] = CLSmmlrC(X,Model);

%Inputs:
%Model.sPARAMS.th
%Model.trainX 
%Model.trainy 
trainX = Model.trainX;
trainy = Model.trainy;

f = zeros(size(trainX,1),1);
A = (-trainX*spdiag(sign(trainy)))';
b = -Model.sPARAMS.th * ones(size(trainX,2),1);
labels = zeros(size(X,2),1);
weights = zeros(size(X,2),1);

for i = 1:size(X,2),
  x = X(:,i);
  H = -rand(50,50);%-x*x';
  w = quadprog(H,f,A,b);
  weights(i) = w'*x;
end

labels = sign(weights);

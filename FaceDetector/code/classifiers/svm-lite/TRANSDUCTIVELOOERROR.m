function [errorrate,predictions] = TRANSDUCTIVELOOERROR(X,y);

X = X';
nexamples = length(y);
predictions = zeros(nexamples,1);

for i = 1:nexamples,
  usey = y;
  usey(i) = 0;
  model = svmlearn(X,usey,'-t 0 -z c -c 0.5');
  [err , onepred ] = svmclassify(X(i,:),1,model)
  predictions(i) = sign(onepred);
end

errorrate = mean(predictions~=y);
return
  
X = eye(10);
y = [1 1 1 1 1 -1 -1 -1 -1 -1]';
y([10]) = 0;
model = svmlearn(X,y,'-t 0 -z c -c 0.5');
[err , predictions ] = svmclassify(X,y,model)

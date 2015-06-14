function [errorrate,predictions] = LOOERROR(X,y);

X = X';
nexamples = length(y);
predictions = zeros(nexamples,1);

for i = 1:nexamples,
  usey = [y(1:i-1);y(i+1:end)];
  useX = [X(1:i-1,:);X(i+1:end,:)];
  model = svmlearn(useX,usey,'-t 0 -z c -c 0.5');
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

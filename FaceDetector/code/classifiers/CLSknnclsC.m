function [labels,weights,firstindeces] = CLSknnclsC(X,Model);

if isfield(Model,'deg')
  deg = Model.deg;
else 
  deg = 2;
end

len1 = size(X,2);
len2 = size(Model.trainX,2);
if deg==2
  X2 = sum((X).^2,1);
  Z2 = sum((Model.trainX).^2,1);
  distance = (repmat(Z2,len1,1)+repmat(X2',1,len2)-2*X'*Model.trainX)';
else
  distance = zeros(len2,len1);
  for i = 1:len1,
    for j = 1:len2,
      distance(j,i) = sum(abs(X(:,i)-Model.trainX(:,j)).^deg);
    end
  end
end

[sorted,index] = sort(distance);
yy = Model.trainy(index);

for i = 1:len1,
  fprintf('Query number:%d\n',i);
  tmpy = yy(1:Model.k,i);
  if sum(abs(tmpy-tmpy(1)))==0
    labels(i) = tmpy(1);
    weights(i) = inf;
  else
    tmpX = Model.trainX(:,index(1:Model.k,i));
    [donotuse,tmpModel,tmpry,tmpweights] = CLSDispatchBoth(tmpX,tmpy,Model.secondstagecls,X(:,i),1)
    labels(i) = tmpry;
    weights(i) = tmpweights;
  end
end

if nargout>2
  numindeces = min(size(sorted,1),Model.numindeces);
  firstindeces = yy(1:numindeces,:)';
end

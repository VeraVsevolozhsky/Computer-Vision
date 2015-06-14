function [m_train, r] = FEATpearson(m_train, label, inparam)

XposTrain = m_train(:,find(label==1));
XnegTrain = m_train(:,find(label==-1));

%XposTrain=XposTrain(find(XposTrain(:,1)~=0),:);
%XnegTrain=XnegTrain(find(XnegTrain(:,1)~=0),:);

XposTrain = XposTrain(:, 1:min(size(XposTrain, 2), size(XnegTrain, 2)));
XnegTrain = XnegTrain(:, 1:min(size(XposTrain, 2), size(XnegTrain, 2)));

for i=1:size(XposTrain,1)
    r.select(i)=nancorrcoef(XposTrain(i,:), XnegTrain(i,:));
end;

[y, index] = sort(-abs(r.select));
index = index(1:floor(size(m_train, 1)*inparam.rank));
m_train = m_train(index,:);

r.rank = inparam.rank;
r.index = index; 
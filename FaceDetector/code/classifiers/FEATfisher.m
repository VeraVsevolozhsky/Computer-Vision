function [m_train, F] = FEATfisher(m_train, label, inparam)

XposTrain = m_train(:,find(label==1));
XnegTrain = m_train(:,find(label==-1));

for i=1:size(XposTrain, 1),
    mean_pos=mean(XposTrain(i,:));
    mean_neg=mean(XnegTrain(i,:));
    std_pos=std(XposTrain(i,:));
    std_neg=std(XnegTrain(i,:));
    F.select(i)=abs((mean_pos-mean_neg)/(std_pos+std_neg));
end;

[y, index] = sort(-abs(F.select));
if inparam.rank>0
  nfeatures = floor(size(m_train, 1)*inparam.rank);
else
  nfeatures = abs(inparam.rank);
end
index = index(1:nfeatures);

m_train = m_train(index,:);
F.rank = nfeatures;
F.index = index;

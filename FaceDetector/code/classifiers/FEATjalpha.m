function [m_train, param] = FEATjalpha(m_train, label, inparam)   %j-alpha
%j-alpha algorithm

%XposTrain = M(find(label==1),:);
%XnegTrain = M(find(label==-1),:);
%Hpos=(XposTrain'*XposTrain).^2;

H=(m_train*m_train').^2;
param.alpha=zeros(size(m_train,2),1);
[param.alpha,d]=eigs(H,1);

%[alpha(:,2),d]=eigs(Hneg,1);

param.alpha=param.alpha';
m_train=(diag(sqrt(abs(param.alpha)))*m_train);
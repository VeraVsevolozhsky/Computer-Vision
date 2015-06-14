function [w,beta] = myGetHPInfoFromcModel(Model)
%function [w,beta] = myGetHPInfoFromcModel(Model)
%
%for models returned by libsvm this returns a vector representing the division hyperplane.
%
w = zeros(size(Model.SVs,2),1);
w = Model.sv_coef' * Model.SVs;
x = Model.SVs(1,:);
[yempl,yemp] = CLSlibsvmC(x',Model);
beta = Model.rho;
HandClassify(1) = w(:)'*x(:)+beta;
HandClassify(2) = -w(:)'*x(:)+beta;
HandClassify(3) = w(:)'*x(:)-beta;
HandClassify(4) = -w(:)'*x(:)-beta;
d = HandClassify - yemp;
[m,mi] = min(abs(HandClassify - yemp));
if(abs(m/yemp) > .00001)
  warning(['****************classification much different from hyperplane: is it really linear kernel?************' ...
	num2str([m,yemp,m/yemp])]);
end
switch mi
  case 1
    w = w;
    beta = beta;
  case 2
    w = -w;
    beta = beta;
  case 3
    w = w;
    beta = -beta;
  case 4
    w = -w;
    beta = -beta;
end


% function [w,beta] = myGetHPInfoFromcModel(Model,X,Y)
% 
% %for models returned by libsvm this returns a vector representing the division hyperplane.
% 
% w = Model.sv_coef' * Model.SVs;
% beta = Model.rho;
% 
% HandClassify(1) = sum(sign(w*X+beta) == Y');
% HandClassify(2) = sum(sign(-w*X+beta)==Y');
% HandClassify(3) = sum(sign(w*X-beta)==Y');
% HandClassify(4) = sum(sign(-w*X-beta)==Y');
% 
% [m,mi] = max(HandClassify);
% switch mi
%   case 1
%     w = w;
%     beta = beta;
%   case 2
%     w = -w;
%     beta = beta;
%   case 3
%     w = w;
%     beta = -beta;
%   case 4
%     w = -w;
%     beta = -beta;
% end

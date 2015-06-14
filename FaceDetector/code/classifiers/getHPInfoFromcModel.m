function [M,v] = getHPInfoFromcModel(cModel,name);

if strcmp(name,'sPARAMSCVonevsallsvm')
  nf = size(cModel.cclass{1}.SVs,2);
  M = zeros(nf,cModel.numc);
  for i = 1:cModel.numc,
    [M(:,i),v(i)] = inlineLIBSVMhyperplane(cModel.cclass{i});
  end
else
  M = [];
  v = [];
end


function [w,beta] = inlineLIBSVMhyperplane(Model)
%function [w,beta] = LIBSVMhyperplane(Model)
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

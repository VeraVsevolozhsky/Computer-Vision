function [Model,looerr] = CLSsvmlight(Xtrain,Ytrain,sPARAMS);
addpath svm-lite
%warning('are you sure you want to use svmlight?')
Xtrain = Xtrain';
if size(Xtrain,1)~=size(Ytrain,1)
  error('size mismatch for svm light');
end

if nargin<3
  SETPARAMS = 1;
elseif isempty(sPARAMS)
  SETPARAMS = 1;
else
  SETPARAMS = 0;
end

if SETPARAMS
  sPARAMS.KERNEL = 0;
  sPARAMS.C = 1;
end

if ~isfield(sPARAMS,'posweight')
  sPARAMS.posweight = -1;
end

basicstring = ['-z c -# 500 '];
if sPARAMS.C>=0,
  cstring = ['-c ' num2str(sPARAMS.C) ' '];
else
  cstring = '';
end

if nargout>1
  loostring = '-x 1 ';
else
  loostring = '-x 0 ';
end

if sPARAMS.posweight>=0,
  weightstring = ['-j ' num2str(sPARAMS.posweight) ' '];
else
  weightstring = '';
end

switch sPARAMS.KERNEL,
  case 0, %linear
    kernelstring = '-t 0 ';
  case 1, %poly with no const
    kernelstring = ['-t 1 -s 1 -r 0 -d ' num2str(sPARAMS.DEGREE) ' '];
  case 2, %poly
    kernelstring = ['-t 1 -s 1 -r ' num2str(sPARAMS.COEF) ' -d ' num2str(sPARAMS.DEGREE) ' '];
  case 3, %rbf
    kernelstring = ['-t 2 -g ' num2str(sPARAMS.GAMMA) ' '];
end

paramstring = [basicstring cstring loostring kernelstring weightstring];
Model = svmlearn(Xtrain,Ytrain,paramstring);
Model.paramstring = paramstring;

looerr = Model.loo_error;

if isfield(sPARAMS,'saveflag'),
  r = 10; 
  save(sPARAMS.saveflag,'r');
end

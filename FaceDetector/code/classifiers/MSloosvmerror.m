function [loomeanerr,successrate,errs] = MSloosvmerror(X,Y,C,K)
%C is the parameter of svm/svc.m
%successrate is the ratio of good svm runs
%errs is a vector

if isempty(X),
  [U,S] = svd(K); %K = U*S*U';
  X = sqrt(S)*U';
  tmp = X'*X;
  normf = sqrt(max(tmp(:)))*100;
  norm(tmp-K)
end

if nargin<3
  C = -1000; %unreasonable value
end

addpath('svmfu');
posind = find(Y>0);
negind = find(Y<=0);
SVMFUTrainUsedForLOO(X(:,posind)', X(:,negind)', C, 1, 20000, ...
    'tmpsvmfiles/tmpsvmfuoutput','tmpsvmfiles/looresults');
fid = fopen('tmpsvmfiles/looresults');
errs = zeros(length(Y),1);
for ii = 1:length(Y),
  %A = char(fread(fid))';
  %numerrors = length(strfind(A,'LOO-ERROR'));
  errs(ii) = length(strfind(char(fgetl(fid)),'LOO-ERROR'));
end
numerrors = sum(errs);
loomeanerr = numerrors/length(Y);
successrate = 1;

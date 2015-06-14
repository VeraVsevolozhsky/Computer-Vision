function [cvmeannerr,successrate,errs,RAND] = MScrossvalidationerror(X,Y,K,ModelsPARAMS,RAND)
%C is the parameter of svm/svc.m
%successrate is the ratio of good svm runs
%errs is a vector of all cv results

if isempty(ModelsPARAMS.splitratio) & ...
      strcmp(ModelsPARAMS.classfierparams.classfunc,'svmfu')
  DISP('LOO with svmfu')
  [cvmeannerr,successrate,errs] = MSloosvmerror([],Y,ModelsPARAMS.classfierparams.C,K);
  return;
end

if isempty(X) & ~isstruct(K),
  [U,S] = svd(K); %K = U*S*U';
  X = sqrt(S)*U';
  tmp = X'*X;
%  normf = sqrt(max(tmp(:)))*100;
  norm(tmp-K)
end

if nargin<3
  C = -1000; %unreasonable value
end

splitratio = ModelsPARAMS.splitratio;
nrepeats = ModelsPARAMS.nrepeats;

ns = length(Y);

LOOFLAG = isempty(splitratio);
if ~isempty(splitratio)
  ntraining = floor(ns*splitratio(1)/100);
  ntesting = ceil(ns*splitratio(2)/100);
else
  ntraining = ns-1;
  ntesting = 1;
  nrepeats = ns;
end

successrate = 1;

if ~LOOFLAG
  if nargin<5
    RAND = rand(ns,nrepeats);
  end
end

errs = zeros(nrepeats,1);
for ii = 1:nrepeats,
  clear Model;
  if ~LOOFLAG
%    [tmp,sorti] = sort(rand(ns,1));
    [tmp,sorti] = sort(RAND(:,ii));
    trainingi = sorti(1:ntraining);
    testingi = sorti(ntraining+(1:ntesting));
  else
    disp('Other LOO')
    trainingi = setdiff((1:ns)',ii);
    testingi  = ii;
  end
  if isstruct(K),
    X = getXfromStructKinlineT(K,trainingi,testingi);
  end
  command = sprintf('Model = %s(X(:,trainingi),Y(trainingi),ModelsPARAMS.classfierparams);',ModelsPARAMS.classfierparams.classfunc);
  eval(command);
  command = sprintf('[ry,weights] = %sC(X(:,testingi),Model);',ModelsPARAMS.classfierparams.classfunc);
  eval(command);
  errs(ii) = mean(Y(testingi)~=ry);
end

cvmeannerr = mean(errs);
successrate = 1;

function X = getXfromStructKinlineT(K,trainingi,testingi);

Model = K.Model;
tmpX  = K.tmpX;
tmpy  = K.tmpy;


if Model.sPARAMS.JALPHA,
  'RUNNING WITH JALPHA'
  alpha = jalphaClinical(tmpX(:,[trainingi; ...
	length(tmpy)]),tmpy([trainingi; length(tmpy)]),Model.JALPHAopts);
  DD = speye(size(tmpX,1));
  DD(find(DD)) = alpha;
  tmpX = tmpX(:,1:end-1);
  K = tmpX'*DD*tmpX;
  [U,S] = svd(K); %K = U*S*U';
  X = sqrt(S)*U';
  tmp = X'*X;
  %  normf = sqrt(max(tmp(:)))*100;
  norm(tmp-K)
elseif Model.sPARAMS.FDA,
  'tempering with LDA'
  lengthtmpy = floor(length(trainingi));
  tmptmpX = [tmpX(:,trainingi) tmpX(:,end)*ones(1,lengthtmpy)];
  tmptmpy = [tmpy(trainingi); tmpy(end)*ones(lengthtmpy,1)];
  [tmpXtrain,outparams] = DIMRfda(tmptmpX,tmptmpy,Model.FDAopts);
  X = outparams.W'*tmpX(:,1:end-1);
%  tmpX = tmpX(:,1:length(tmpy));
%  K = tmpX'*tmpX;
elseif Model.sPARAMS.BORNSET,
  tmpX = DIMRbornset(tmpX,tmpy);
  K = tmpX'*tmpX;
elseif Model.sPARAMS.SIMPLEADD,
  addset = find(tmpy(1:end-1)==tmpy(end));
  subset = find(tmpy(1:end-1)~=tmpy(end));
  addset = intersect(addset,trainingi);
  subset = intersect(subset,trainingi);
  tmpX(:,addset) = (tmpX(:,addset) + ...
      tmpX(:,end)*ones(1,length(addset))/10)./(1+1/10);
  tmpX(:,subset) = (tmpX(:,subset) - ...
      tmpX(:,end)*ones(1,length(subset))/10)./(1+1/10);
  X = tmpX;
elseif Model.sPARAMS.BOOSTING,
  m = CLSboosting(tmpX,tmpy);
  tmpX = tmpX(unique(m.featuresused),:);
  K = tmpX'*tmpX;
end 


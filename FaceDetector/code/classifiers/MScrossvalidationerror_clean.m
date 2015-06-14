function [cvmeannerr,successrate,errs,RAND,cModels,mY,cX] = MScrossvalidationerror_clean(X,Y,ModelsPARAMS,RAND,cX,FSPARAMS)
%FS chashing (cX and FSPARAMS) will only work correctly if RAND did not change!
%cX contains for each repeat one column of FS training and one column of FS training

if nargin<5
  cX = [];
end
if nargin<6
  FSPARAMS = [];
end

DOFS = ~isempty(FSPARAMS);
DOFSACTIVE = DOFS .* isempty(cX);

DEBUG = 0;
if DEBUG,
  global TESTX;
  global TESTY;
  disp('MScrossvalidationerror_clean:: NOT SO CLEAN');
end

%successrate is the ratio of good svm runs
%errs is a vector of all cv results

splitratio = ModelsPARAMS.splitratio;
TRASDUCTIVE = 0;
if isfield(ModelsPARAMS,'T'),
  TRASDUCTIVE = ModelsPARAMS.T,
end

ns = length(Y);

LOOFLAG = isempty(splitratio);
if ~isempty(splitratio)
  ntraining = floor(ns*splitratio(1)/100);
  ntesting = ceil(ns*splitratio(2)/100);
  nrepeats = ModelsPARAMS.nrepeats;
else
  ntraining = ns-1;
  ntesting = 1;
  nrepeats = ns;
end



fprintf(1,'MScrossvalidation::Ntraining:%d, Ntesting: %d, Nrepeats: %d\n',ntraining, ntesting, nrepeats);

successrate = 1;

if ~LOOFLAG
  if nargin<4
    RAND = rand(ns,nrepeats);
    'rerandomizing'
  elseif isempty(RAND),
    RAND = rand(ns,nrepeats);
    'rerandomizing'
  else
    RAND = RAND(1:ns,1:nrepeats);
  end
end

mY = [];
errs = zeros(nrepeats,1);
if DOFSACTIVE,
  cX = cell(nrepeats,2);
  '**redoing Feature Selection**';
end

for ii = 1:nrepeats,
  clear Model;
  if ~LOOFLAG
    [tmp,sorti] = sort(RAND(:,ii));
    trainingi = sorti(1:ntraining);
    testingi = sorti(ntraining+(1:ntesting));
  else
    %disp('Other LOO')
    trainingi = setdiff((1:ns)',ii);
    testingi  = ii;
  end
  ModelsPARAMS.classfierparams.trainingi = trainingi;
  if TRASDUCTIVE
    ModelsPARAMS.classfierparams.uX = X(:,testingi);
    if TRASDUCTIVE==2
      ModelsPARAMS.classfierparams.uy = [];
    end
  end
  if DEBUG,
    TESTX = X(:,testingi);
    TESTY = Y(testingi);
  end



  if ~DOFS
    command = sprintf('Model = %s(X(:,trainingi),Y(trainingi),ModelsPARAMS.classfierparams);',ModelsPARAMS.classfierparams.classfunc);
    eval(command);
    tmptestX = X(:,testingi);
  else %DOFS    
    if DOFSACTIVE
      [cX{ii,1},cX{ii,2}] = FSDispatchBoth(X(:,trainingi),Y(trainingi),FSPARAMS,X(:,testingi));
    end
    command = sprintf('Model = %s(cX{ii,1},Y(trainingi),ModelsPARAMS.classfierparams);',ModelsPARAMS.classfierparams.classfunc);
    eval(command);
    tmptestX = cX{ii,2};

  end
  
  if isempty(Model)
    errs(ii) = -1;
    cModels{ii} = [];
    ry = zeros(length(testingi),1);
    mY = [mY, ry];
  else %model is not empty
    command = sprintf('[ry,weights] = %sC(tmptestX,Model);',ModelsPARAMS.classfierparams.classfunc);
    eval(command);
    if size(ry,2)>size(ry,1),
      ry = ry';
    end
    errs(ii) = mean(Y(testingi)~=ry);
    cModels{ii} = Model;
    mY = [mY, ry];
  end
  if DOFSACTIVE & nargout<7
    cX = cell(nrepeats,2);
  end
end

goodi = find(errs>-1);
cvmeannerr = mean(errs(goodi));
successrate = length(goodi)/length(errs);

function Model = MULTonevsall(X,y,sPARAMS);


if nargin<3
  sPARAMS.CLASSIFIERNAME = 'CLSlibsvm';
  sPARAMS.CLASSIFIERsPARAMS.KERNEL = 0;
  sPARAMS.CLASSIFIERsPARAMS.C = 1;
end
  
if ~isfield(sPARAMS,'subsample')
  sPARAMS.subsample = 0;
end

if ~isfield(sPARAMS,'balance')
  sPARAMS.balance = 0;
end

if sPARAMS.balance
  'BALANCING'
end
  
uniquey = unique(y);
numc = length(uniquey);
cclass = cell(numc,1);

%disp('this file may be corrupted...')


for i = 1:numc,
  if (mod(i,30)==0)
    fprintf('packing...');
    pack;
    fprintf('done.\n');
  end
  
  if 0
    fid = fopen([num2str(i) '.tmp'],'w');
    fprintf(fid,'asdf');
    fclose(fid);
  end
  if 0 & i==40 | i==79  
    cclass{i} = cclass{i-1};
  else
    tmpy = 2*(y==uniquey(i))-1;
    if sPARAMS.subsample,
      indp = find(tmpy==1);
      indn = find(tmpy<1);
      indn = indn(1:sPARAMS.subsample:end);
      ind = [indp;indn];
    else
      ind = 1:length(tmpy);
    end
    fprintf(1,'(%s)',num2str(i));
    if sPARAMS.balance,
      sPARAMS.CLASSIFIERsPARAMS.posweight = ...
	  1/sum(tmpy(ind)<0)*sum(tmpy(ind)>0);%took 1/ since sucked
      tmpy = (tmpy==-1);
    end
    if strcmp('CLSlibsvm',sPARAMS.CLASSIFIERNAME');
      evalc(['tModel = ' sPARAMS.CLASSIFIERNAME ...
	    '(X(:,ind),tmpy(ind),sPARAMS.CLASSIFIERsPARAMS);']);
    else
      eval(['tModel = ' sPARAMS.CLASSIFIERNAME ...
	    '(X(:,ind),tmpy(ind),sPARAMS.CLASSIFIERsPARAMS);']);
    end
    cclass{i} = tModel;
  end
end

Model.uniquey = uniquey;
Model.numc = numc;
Model.cclass = cclass;
Model.sPARAMS = sPARAMS;

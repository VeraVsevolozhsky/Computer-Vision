function Model = MULTallpairs(X,y,sPARAMS);

if nargin<3
  sPARAMS.CLASSIFIERNAME = 'CLSosusvm';
  sPARAMS.CLASSIFIERsPARAMS.KERNEL = 0;
  sPARAMS.CLASSIFIERsPARAMS.C = 1;
end

if isempty(sPARAMS)
  Model = [];
  return;
end

%warning('corrupted');

uniquey = unique(y);
numc = length(uniquey);
cclass = cell(numc,numc);

for i = 1:numc,
  for j = (i+1):numc,
    if 0
      fid = fopen([num2str(i) '_' num2str(j) '.tmp'],'w');
      fprintf(fid,'asdf');
      fclose(fid);
    end
    if 0 & (j==43 | j == 82 | j==80)
      cclass{i,j} = cclass{1,2};
    else
      fprintf(1,'(%d,%d)',i,j);
      goodi = find(ismember(y,[uniquey(i), uniquey(j)]));
      tmpX = X(:,goodi);
      tmpy = y(goodi);
      tmpy = 2*(tmpy==uniquey(i))-1;
      eval(['tModel = ' sPARAMS.CLASSIFIERNAME '(tmpX,tmpy,sPARAMS.CLASSIFIERsPARAMS);']);
      if 1 
	cclass{i,j} = tModel;
      else
	fprintf('SRAK');
      end
    end
  end
end

Model.uniquey = uniquey;
Model.numc = numc;
Model.cclass = cclass;
Model.sPARAMS = sPARAMS;
  

function [lab,mmax,FM] = MULTallpairsC(X,Model);

if isempty(Model),
  lab = [];
  mmax = [];
  FM = [];
  return;
end
  
cclass = Model.cclass;
numc = Model.numc;
uniquey = Model.uniquey;

FM = zeros(size(X,2),numc);

for i = 1:numc,
  for j = (i+1):numc,
    [i j]
    if ~isempty(cclass{i,j})
      eval(['[Cx,Fx] = ' Model.sPARAMS.CLASSIFIERNAME ...
	    'C(X,cclass{i,j});']);
      FM(:,i) = FM(:,i) + (Cx==1);
      FM(:,j) = FM(:,j) + (Cx~=1);
    else 
      'empty'
    end
  end
end

FM = FM./(numc*(numc-1)/2);
[mmax,lab] = max(FM,[],2);
lab = uniquey(lab);

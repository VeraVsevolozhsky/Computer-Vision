function [lab,mmax,FM,CM] = MULTonevsallC(X,Model);

cclass = Model.cclass;
numc = Model.numc;
uniquey = Model.uniquey;

FM = zeros(size(X,2),numc);
CM = zeros(size(X,2),numc);

for i = 1:numc,
  fprintf(1,'(%s)',num2str(i));
  evalc(['[Cx,Fx] = ' Model.sPARAMS.CLASSIFIERNAME 'C(X,cclass{i});']);
  if Model.sPARAMS.balance,
    Cx = (Cx==0)*2-1;
  end
  if size(Fx,1)~=size(Cx,1) | size(Fx,2)~=size(Cx,2),
    Fx = Fx';
  end
  tmp = (sign(Cx)==sign(Fx));
  if mean(tmp)<.5
    Fx = -Fx;
  end
  CM(:,i) = Cx;
  FM(:,i) = Fx;
end
[mmax,lab] = max(FM,[],2);
lab = uniquey(lab);

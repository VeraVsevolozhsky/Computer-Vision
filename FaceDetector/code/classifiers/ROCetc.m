function [stSoStat] = ROCetc(o,labels)

[sotedo,sind] = sort(o);
slab = labels(sind);
n = length(o);
np = sum(labels>0);
nn = sum(labels<0);

stSoStat.labels = labels;
stSoStat.o = o;
stSoStat.np = np;
stSoStat.nn = nn;
stSoStat.n = n;

stSoStat.tp = zeros(n,1);
stSoStat.tn = zeros(n,1);
stSoStat.fp = zeros(n,1);
stSoStat.fn = zeros(n,1);
stSoStat.nr = zeros(n,1);

for i = n:-1:0,
	stSoStat.tp(i+1) = sum(slab(i+1:end)>0);
	stSoStat.fp(i+1) = sum(slab(i+1:end)<=0);
	stSoStat.tn(i+1) = sum(slab(1:i)<0);
	stSoStat.fn(i+1) = sum(slab(1:i)>=0);
	stSoStat.nr(i+1) = n-i;
end

if np
  stSoStat.recall = stSoStat.tp ./ np;
else
  stSoStat.recall = ones(n+1,1);
end

stSoStat.precision = [stSoStat.tp(1:n) ./ stSoStat.nr(1:n);1];

stSoStat.normfp = stSoStat.fp./nn;

stSoStat.auc = auc(stSoStat.normfp,stSoStat.recall);

[minn,ii] = min(abs(stSoStat.fp/nn - stSoStat.fn/np));

stSoStat.errorateq = (stSoStat.fp(ii) + stSoStat.fn(ii))/n;
return

pos = o(find(labels>0));
neg = o(find(labels<=0));
[tmpFP,tmpTP, stSoStat.auc2, stSoStat.errSame, stSoStat.err0FP] = get_roc_ZER(pos,neg);
% to plon an roc plot(stSoStat.fp/stSoStat.nn,stSoStat.tp/stSoStat.np)

function [FP, TP, roc, errSame, err0FP] = get_roc_ZER(pos,neg)

%Thresh      = linspace(max(neg)+.00001, min(neg)-0.00001, 5000);
Thresh       = sort(-neg);
Thresh       = -Thresh;
Thresh       = [Thresh(1)+0.01; Thresh; Thresh(end)-0.01]';
distf        = repmat(pos', length(Thresh), 1);
Thr          = repmat(Thresh', 1, length(pos));

tp           = sum(distf >= Thr, 2);
TP           = tp / length(pos);

distnf       = repmat(neg', length(Thresh), 1);
Thr          = repmat(Thresh', 1, length(neg));
fp           = sum(distnf >= Thr, 2);
FP           = fp / length(neg);

roc          = trapz(FP, TP);

[v,I]        = min(abs((1-TP)-FP));
errSame      = (fp(I)+(length(pos)-tp(I)))/(length(pos)+length(neg));

err0FP       = 1-TP(1);

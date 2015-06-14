function X = DIMRpcaA(X,outparams)

X = X - outparams.meanX*ones(1,size(X,2));

X = outparams.W'*X;





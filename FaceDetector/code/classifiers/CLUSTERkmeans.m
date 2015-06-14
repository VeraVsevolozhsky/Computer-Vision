function [Labels,REPRESENTATIVES] = CLUSTERkmeans(P,params);

params = updateparams(params, 'makeschur',0,'kernel',0,'nc',2,'nrounds',10);

[m,n] = size(P);

if (params.makeschur)
   A = P'*P;
   [U,T] = schur(A);
   P = U*sqrt(T);
elseif (params.kernel)
   [U,T] = schur(P);
   P = U*sqrt(T);
end

if 0
  [centers,clusters,errors,ind] = somkmeans(P',params.nc,params.nrounds); 
  Labels = clusters{params.nc};
else
  [Labels,C,SUMD,D] = kmeans(P',params.nc, 'Maxiter', params.nrounds, ...
      'EmptyAction', 'singleton'); 
  if nargout>1
    REPRESENTATIVES = zeros(size(D,2),1);
    for i = 1:size(D,2);
      [minv,mini] = min(D(:,i));
      REPRESENTATIVES(i) = mini;
    end
  end
end

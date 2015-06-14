function K = normalizeKernelMatrix(K,type);

if type==0,
  return;
else,  
  d = sum(K);
  maxd = max(d);
  if type==1,
    D = diag(d);
    K = maxd*eye(size(K)) + K - D;
  elseif type==2,
    D = diag(1./sqrt(d));
    K = D*K*D;
  end
end


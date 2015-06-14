function D = spdiag(d)

D = speye(length(d));
i = find(D);
D(i) = d;

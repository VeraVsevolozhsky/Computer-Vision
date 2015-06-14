function K = computeKernelMatrix(X,name,params,X2);

if ~isstr(name)
  switch name
    case 0
      name = 'linear';
    case 1
      name = 'poly';
      if isempty(params)
	params = 1;
      end
    case 2,
      name = 'inhomopoly';
    case 3
      name = 'gaussian';
      if isempty(params)
	params = 1;
      end
  end
end

if nargin<4
  X2 = X;
end

switch lower(name)
  case{'linear','poly','inhomopoly'},
    K = X'*X2;
    switch lower(name)
      case 'poly'
	K = K.^params(1);
      case 'inhomopoly'
	K = (K + params(1)).^params(2);
    end
  case{'gaussian'}
    K = X'*X2;
    K1 = ones(size(X2,2),1)*sum(X.^2);
    K2 = ones(size(X,2),1)*sum(X2.^2);
    K = K1' - 2*K + K2;
    K = exp(-K./(2*params(1)^2));
end

    

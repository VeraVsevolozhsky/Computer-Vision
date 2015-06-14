function Model = CLSl0normSVM(X,y,sPARAMS);
% l0-norm SVM
% from "An Introduction to Variable and Feature Selection"
% by Guyon and Elisseeff (p. 1169)

sPARAMSsvm.classfunc = 'CLSlibsvm';
sPARAMSsvm.C = 1;
sPARAMSsvm.KERNEL = 0;

DEBUG = 0;
DEBUGINFO.w = [];

if (not(isfield(sPARAMS, 'tolerance')))
  sPARAMS.tolerance = 1e-4;
end

if (not(isfield(sPARAMS, 'feature_limit')))
  sPARAMS.feature_limit = 1/4;
end

if sPARAMS.feature_limit<1,
  sPARAMS.feature_limit = max(floor(size(X,1)*sPARAMS.feature_limit),1);
end

if (not(isfield(sPARAMS, 'feature_scale_thresh')))
  sPARAMS.feature_scale_thresh = 0;
end

if (not(isfield(sPARAMS, 'maxnrounds')))
  sPARAMS.maxnrounds = inf;
end

change = +inf;

[nfeat,nexamp] = size(X);
feature_scale = ones(nfeat,1);
Model.iterations = 0;

feature_scale = ones(nfeat,1);

if (nfeat > sPARAMS.feature_limit)
  for i = 1:sPARAMS.maxnrounds,
    Xscaled = spdiag(feature_scale)*X; %% X .* repmat(feature_scale, [1,nexamp]);
    
    % 1. Train a regular linear SVM (using l1-norm or l2-norm regularization):
    SVMMODEL = CLSlibsvm(Xscaled,y,sPARAMSsvm);
    Model.iterations = Model.iterations + 1;
    
    % 2. Re-scale the input variables by multiplying them by the
    % absolute values of the components of the weight vector w obtained:
    w = SVMMODEL.SVs'*SVMMODEL.sv_coef;
    if DEBUG
      DEBUGINFO.w = [DEBUGINFO.w ,w];
    end
    w = mean(abs(w),2);
    feature_scale_save = feature_scale;
    
    feature_scale = feature_scale .* w; %removed unncessasary abs()
    
    % 3. Iterate the first 2 steps until convergence:
    change = norm(feature_scale - feature_scale_save)
    if (change < sPARAMS.tolerance | Model.iterations > 3)
      break;
    end
  end
end

%temp = feature_scale(find(feature_scale > 1e-6));
[ss, si] = sort(feature_scale, 'descend');

goodi = find(ss > sPARAMS.feature_scale_thresh);
ss = ss(goodi);
si = si(goodi);

range = min(sPARAMS.feature_limit, length(si));
Model.featuresused = si(1:range);
Model.feature_scale = ss(1:range);

%Xscaled = X(Model.features_used,:) .* repmat(Model.feature_scale, [1,nexamp]);
Xscaled = X(Model.featuresused,:);
Model.SVM_Model = CLSlibsvm(Xscaled,y,sPARAMSsvm);
Model.l0normParameters = sPARAMS;
Model.totalnumfeatures = nfeat;
Model.DEBUGINFO = DEBUGINFO;

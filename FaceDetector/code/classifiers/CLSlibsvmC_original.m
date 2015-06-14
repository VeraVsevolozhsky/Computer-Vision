function [Labels]= CLSlibsvmC(Samples, Model);
%this windows version is does not return decisionvalues
% [predic_label,acc]= svmpredict(ones(size(Samples,2),1),Samples',Model);
[predic_label,acc]= svmpredict(ones(size(Samples,2),1),Samples',Model , '-b 0');
keyboard
Labels  = predic_label(:,1);
if (size(predic_label,2)>1)
  DecisionValue = predic_label(:,2);
end



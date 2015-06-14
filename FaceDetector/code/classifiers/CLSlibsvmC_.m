function [Labels, DecisionValue]= CLSlibsvmC(Samples, Model);

[predic_label,acc,DecisionValue]= svmpredict(ones(size(Samples,2),1),Samples',Model);
Labels  = predic_label(:,1);
if (size(predic_label,2)>1)
  DecisionValue = predic_label(:,2);
end

if sign(DecisionValue(1))~=sign(Labels(1))
  DecisionValue = -DecisionValue;
end


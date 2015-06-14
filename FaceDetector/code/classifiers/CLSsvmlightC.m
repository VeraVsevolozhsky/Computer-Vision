function [Labels, DecisionValue]= CLSsvmlightC(Samples, Model);

[tmp, DecisionValue]= svmclassify(Samples',ones(size(Samples,2),1),Model);
Labels  = sign(DecisionValue);


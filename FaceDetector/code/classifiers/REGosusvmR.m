function [Labels, DecisionValue]= REGosusvmR(Samples, Model);

[Labels, DecisionValue]= SVMClass(Samples, Model.AlphaY, ...
                                  Model.SVs, Model.Bias, ...
				  Model.Parameters, Model.nSV, Model.nLables);
Labels = Labels';
DecisionValue = DecisionValue';

function [Labels, DecisionValue]= CLSosusvmC(Samples, Model);

[Labels, DecisionValue]= SVMClass(Samples, Model.AlphaY, ...
                                  Model.SVs, Model.Bias, ...
				  Model.Parameters, Model.nSV, Model.nLabel);
Labels = Labels';
DecisionValue = DecisionValue';

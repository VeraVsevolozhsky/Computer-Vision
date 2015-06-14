function [ry,weights] = CLSwrapperFSC(X2,Model);

command = sprintf('nX2 = %sA(X2,Model.dimrOutParams);',Model.ModelsPARAMS.dimrparams.dimrfunc);
eval(command);

command = sprintf('[ry,weights] = %sC(nX2,Model.clsModel);',Model.ModelsPARAMS.classfierparams.classfunc);
eval(command);

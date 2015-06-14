function Model = CLSwrapperFS(X1,y1,ModelsPARAMS)

command = sprintf('[nX1,dimrOutParams] = %s(X1,y1,ModelsPARAMS.dimrparams);',ModelsPARAMS.dimrparams.dimrfunc);
eval(command);
Model.dimrOutParams = dimrOutParams;

command = sprintf('clsModel = %s(nX1,y1,ModelsPARAMS.classfierparams);',ModelsPARAMS.classfierparams.classfunc);
eval(command);
Model.clsModel = clsModel;

Model.ModelsPARAMS = ModelsPARAMS;

return
%an example
sPARAMsFSwilcoxonOSUSVM.classfierparams.classfunc = 'CLSosusvm';
sPARAMsFSwilcoxonOSUSVM.classfierparams.KERNEL = 0;
sPARAMsFSwilcoxonOSUSVM.classfierparams.C = 1;
sPARAMsFSwilcoxonOSUSVM.dimrparams.dimrfunc = 'FSwilcoxon';
sPARAMsFSwilcoxonOSUSVM.dimrparams.nselect = 100;


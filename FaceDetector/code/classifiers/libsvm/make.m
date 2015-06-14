% This make.m is used under Windows

mex -O -c svm.cpp
mex -O -c svm_model_matlab.c

if strcmp(computer,'PCWIN')
    mex -O svmtrain.c svm.obj svm_model_matlab.obj
    mex -O svmpredict.c svm.obj svm_model_matlab.obj
else
    mex -O svmtrain.c svm.o svm_model_matlab.o
    mex -O svmpredict.c svm.o svm_model_matlab.o
end
    

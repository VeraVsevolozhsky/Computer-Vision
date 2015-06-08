%Main function
function [IntrPoints]= SURF(I)
close all;
disp('Step1: Caclulate integral image.')
integralIm    = integralImage(I);
thresh = 2000;
disp('Step2: Caclulate Hessian matrix.')
hesMatrix    = HessianMatrix(integralIm, thresh); 
disp('Step3: Perform Non Maximum Supression.')
[IntrPoints] = NonMaxSupression(hesMatrix);
save('IntrPoints.mat', 'IntrPoints');
disp('Step4: Get Descriptor.')
[IntrPoints] = GetDescriptor(integralIm, IntrPoints);
disp('Step5: Draw interesting points and its dominant orientations.')
DrawSurfPoints(I, IntrPoints);
% disp('Step6: Prepare features.')
% descFeatures = GetDescriptorFeatures(integralIm, IntrPoints);

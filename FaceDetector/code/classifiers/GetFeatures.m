function featuresVec = GetFeatures(intIm, x1,y1,x2,y2)
featureA    = GetFeatureA(intIm,x1,y1,x2,y2);
featureB    = GetFeatureB(intIm,x1,y1,x2,y2);
featureC    = GetFeatureC(intIm,x1,y1,x2,y2);
featureD    = GetFeatureD(intIm,x1,y1,x2,y2);
featuresVec = [featureA(:)'; featureB(:)'; featureC(:)'; featureD(:)'];






%function featuresVec = GetFeatures(integralIm)
% % features = [];
% % for iterationNum = 1:200
%    %Generate value from the uniform distribution on the interval [a, b] -  r = a + (b-a).*rand(1);        
% %    [x1,y1,x2,y2] = GetXYRand(2,8,12,16);
% featureA    = GetFeatureA(integralIm,x1,y1,x2,y2);
% featureB    = GetFeatureB(integralIm,x1,y1,x2,y2);
% featureC    = GetFeatureC(integralIm,x1,y1,x2,y2);
% featureD    = GetFeatureD(integralIm,x1,y1,x2,y2);
% featuresVec = [featureA; featureB; featureC; featureD];
% % features    = [features featuresVec];
% % end
% 
% 








 

function featuresVec = GetFeatures(intIm, x1,y1,x2,y2)
featureA    = GetFeatureA(intIm,x1,y1,x2,y2);
featureB    = GetFeatureB(intIm,x1,y1,x2,y2);
featureC    = GetFeatureC(intIm,x1,y1,x2,y2);
featureD    = GetFeatureD(intIm,x1,y1,x2,y2);
featuresVec = [featureA(:)'; featureB(:)'; featureC(:)'; featureD(:)'];

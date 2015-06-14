function featureBValue = GetFeatureB(integralIm,x1, y1, x2, y2)
middlePoint = round((y2-y1)/2) + y1;
point2 = integralIm(middlePoint, x2,:)  - integralIm(middlePoint, x1,:)  - integralIm(y1, x2,:)  + integralIm(y1, x1,:); 
point4 = integralIm(y2, x2,:)  - integralIm(y2, x1,:)  - integralIm(middlePoint, x2,:)  + integralIm(middlePoint, x1,:);            
featureBValue = point2 - point4;

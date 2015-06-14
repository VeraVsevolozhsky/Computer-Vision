function featureAValue = GetFeatureA(intIm, x1, y1, x2, y2)
middlePoint = round((x2-x1)/2)+x1;
point3 =  intIm(y2,middlePoint,:)  - intIm(y2,x1,:) - intIm(y1,middlePoint,:) + intIm(y1,x1,:);
point4 =  intIm(y2, x2,:)    - intIm(y2,middlePoint,: ) - intIm(y1, x2,:)    + intIm(y1,middlePoint,:);
featureAValue = point4 - point3;


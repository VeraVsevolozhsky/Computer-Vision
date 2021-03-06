function featureDValue = GetFeatureD(integralIm,x1, y1, x2, y2)
midPointX=round((x2-x1)/2)+x1;
midPointY=round((y2-y1)/2)+y1;

point1 =  integralIm(midPointY, midPointX,:) - ...
          integralIm(midPointY, x1,:) - ...
          integralIm(y1, midPointX,:) + ...
          integralIm(y1, x1,:);
point2 =  integralIm(midPointY, x2,:) - ...
          integralIm(midPointY, midPointX,:) - ...
          integralIm(y1, x2,:) + ...
          integralIm(y1, midPointX,:);
      
point3 =  integralIm(y2, midPointX,:) - ...
          integralIm(y2, x1,:) - ...
          integralIm(midPointY, midPointX,:) + ...
          integralIm(midPointY, x1,:);
point4 =  integralIm(y2, x2,:) - ...
          integralIm(y2,midPointX ,:) - ...
          integralIm(midPointY, x2,:) + ...
          integralIm(midPointY, midPointX,:);
featureDValue = (point2 + point3) - (point1 + point4);

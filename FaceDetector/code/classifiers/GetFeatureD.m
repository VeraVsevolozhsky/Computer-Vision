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





















% %create rectangle kernel - type D (consists of four rectangles)
% deltaX = x2-x1;
% deltaY = y2-y1;
% rectD =             [x1         y1;
%                     x1+deltaX/2 y1;
%                     x2          y1;
%                     x1          y1+deltaY/2;
%                     x1+deltaX/2 y1+deltaY/2;
%                     x2          y1+deltaY/2;
%                     x1          y2;
%                     x1+deltaX/2 y2;
%                     x2          y2];
% rectD = rectD';
% featureD = round(rectD);

































% function featureDValue = GetFeatureD(integralIm, x1, y1, x2, y2)
% %create rectangle kernel - type D
% rectD =             [x1        y1;
%                     x1+x2/2    y1;
%                     x1+x2      y1;
%                     x1         y1+y2/2;
%                     x1+x2/2    y1+y2/2;
%                     x1+x2      y1+y2;
%                     x1         y1+y2;
%                     x1+x2/2    y1+y2;
%                     x1+x2      y1+y2];
% rectD = rectD';
% rectD = round(rectD);
% % visualizzaFeatures(rectD, integralIm);
% x = unique(rectD(1,:));
% y = unique(rectD(2,:));
% point1 = integralIm(y(2), x(2))   - ...
%          integralIm(y(2)-1, x(1)) - ...
%          integralIm(y(1), x(2)-1) + ...
%          integralIm(y(1)-1, x(1)-1);
% point2 = integralIm(y(2), x(3))   - ...
%          integralIm(y(2)-1, x(2)) - ...
%          integralIm(y(1), x(3)-1) + ...
%          integralIm(y(1)-1, x(2)-1);
% point3 = integralIm(y(3), x(2))   - ...
%          integralIm(y(3)-1, x(1)) - ...
%          integralIm(y(2), x(2)-1) + ...
%          integralIm(y(2)-1, x(1)-1);
% point4 = integralIm(y(3), x(3))   - ...
%          integralIm(y(3)-1, x(2)) - ...
%          integralIm(y(2), x(3)-1) + ...
%          integralIm(y(2)-1, x(2)-1);
% featureDValue = (point2 + point3) - (point1 + point4);
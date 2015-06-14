function  featureCValue = GetFeatureC(integralIm,x1, y1, x2, y2)
midPoint1 = round((x2-x1)/3)+x1;
midPoint2 = round((x2-x1)*(2/3))+x1;

point2      = integralIm(y2, midPoint1,:) - ...
              integralIm(y2, x1,:) - ...
              integralIm(y1,midPoint1,: ) + ...
              integralIm(y1 ,x1,:);
              
midPoint = integralIm(y2, midPoint2,:)   - ...
                        integralIm(y2, midPoint1,:) - ...
                        integralIm(y1, midPoint2,:) + ...
                        integralIm(y1, midPoint1,:);

point4      = integralIm(y2, x2,:) - ...
              integralIm(y2, midPoint2,:) - ...
              integralIm(y1, x2,:) + ...
                        integralIm(y1, midPoint2,:);    
featureCValue = midPoint - (point2 + point4);



























% %create rectangle kernel - type C (consists of 3 vertical rectangles)
% delta = x2-x1;
% rectC = [x1               y1;
%          x1 + delta/3     y1;
%          x1 + (2/3)*delta y1;
%          x2               y1; 
%          x1               y2;
%          x1 + delta/3     y2;
%          x1 + (2/3)*delta y2;
%          x2               y2];
%      
%      
%      
% %      rectC = [x1  y1;
% %          x1 + x2/3      y1;
% %          x1 + (2/3)*x2  y1;
% %          x1 + x2        y1; 
% %          x1             y1+y2;
% %          x1 + x2/3      y1+y2;
% %          x1 + (2/3)*x2  y1+y2;
% %          x1+x2          y1+y2 ];
% rectC = rectC';
% featureC = round(rectC);
% % visualizzaFeatures(rectC, integralIm);



































% function  featureCValue = GetFeatureC(integralIm, x1, y1, x2, y2)
% %create rectangle kernel - type C
% rectC = [x1  y1;
%          x1 + x2/3      y1;
%          x1 + (2/3)*x2  y1;
%          x1 + x2        y1; 
%          x1             y1+y2;
%          x1 + x2/3      y1+y2;
%          x1 + (2/3)*x2  y1+y2;
%          x1+x2          y1+y2 ];
% rectC = rectC';
% rectC = round(rectC);
% % visualizzaFeatures(rectC, integralIm);
% x = unique(rectC(1,:));
% y = unique(rectC(2,:));     
% point3      = integralIm(y(2), x(2))   - ...
%               integralIm(y(2)-1, x(1)) - ...
%               integralIm(y(1), x(2)-1) + ...
%               integralIm(y(1)-1, x(1)-1);
%               
% pointMiddle = integralIm(y(2), x(3))   - ...
%               integralIm(y(2)-1, x(2)) - ...
%               integralIm(y(1), x(3)-1) + ...
%               integralIm(y(1)-1, x(2)-1);
% 
% point4      = integralIm(y(2), x(4))   - ...
%              integralIm(y(2)-1, x(3)) - ...
%              integralIm(y(1), x(3)-1) + ...
%              integralIm(y(1)-1, x(3)-1);
%     
% featureCValue = pointMiddle - (point3 + point4);
%             
%      
% 

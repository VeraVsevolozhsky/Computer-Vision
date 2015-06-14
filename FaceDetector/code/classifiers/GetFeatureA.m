function featureAValue = GetFeatureA(intIm, x1, y1, x2, y2)
middlePoint = round((x2-x1)/2)+x1;

point3 =  intIm(y2,middlePoint,:)  - intIm(y2,x1,:) - intIm(y1,middlePoint,:) + intIm(y1,x1,:);
point4 =  intIm(y2, x2,:)    - intIm(y2,middlePoint,: ) - intIm(y1, x2,:)    + intIm(y1,middlePoint,:);
featureAValue = point4 - point3;






















%create rectangle kernel - type A (consists of two vertical rectangles)
% delta = x2-x1;
% rectA = [x1              y1;
%          x1 + delta/2    y1;
%          x2              y1;
%          x1              y2;
%          x1 + delta/2    y2;
%          x2              y2];
% 
% 
% 
% % rectA = [x1                y1      ;
% %          x1 + x2/2         y1      ;
% %          x1 + x2           y1      ;
% %          x1                y1 + y2 ;
% %          x1 + x2/2         y1 + y2 ;
% %          x1 + x2           y1 + y2 ];
% rectA = rectA';             
% % visualizzaFeatures(rectA, integralIm);
% featureA = round(rectA);
% 
% 
% 





















% function featureAValue = GetFeatureA(integralIm, x1, y1, x2, y2)
% %create rectangle kernel - type A
% rectA = [x1                y1      ;
%          x1 + x2/2         y1      ;
%          x1 + x2           y1      ;
%          x1                y1 + y2 ;
%          x1 + x2/2         y1 + y2 ;
%          x1 + x2           y1 + y2 ];
% rectA = rectA';             
% % visualizzaFeatures(rectA, integralIm);
% rectA = round(rectA);
% x = unique(rectA(1,:));
% y = unique(rectA(2,:));
% point3 = integralIm(y(2), x(2)) - ...
%      integralIm(y(2)-1, x(1))   - ...
%      integralIm(y(1), x(2)-1)   + ...
%      integralIm(y(1)-1, x(1)-1);
% point4 = integralIm(y(2), x(3)) - ...
%      integralIm(y(2)-1, x(2))   - ...
%      integralIm(y(1), x(3)-1)   + ...
%      integralIm(y(1)-1, x(2)-1);
% featureAValue = point4 - point3;
% 
% 


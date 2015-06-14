function featureBValue = GetFeatureB(integralIm,x1, y1, x2, y2)
middlePoint = round((y2-y1)/2) + y1;
point2 = integralIm(middlePoint, x2,:)  - integralIm(middlePoint, x1,:)  - integralIm(y1, x2,:)  + integralIm(y1, x1,:); 
point4 = integralIm(y2, x2,:)  - integralIm(y2, x1,:)  - integralIm(middlePoint, x2,:)  + integralIm(middlePoint, x1,:);            
featureBValue = point2 - point4;













% %create rectangle kernel - type B (consists of two horizontal rectangles)
% delta = y2-y1;
% rectB = [x1       y1;
%          x1       y1 + delta/2;
%          x1       y2;
%          x2       y1;
%          x2       y1 + delta/2;
%          x2       y2];
%      
% % rectB = [x1       y1       ;
% %          x1       y1 + y2/2;
% %          x1       y1 + y2  ;
% %          x1 + x2  y1       ;
% %          x1 + x2  y1 + y2/2;
% %          x1 + x2  y1 + y2  ];
% rectB = rectB';
% featureB = round(rectB);
% visualizzaFeatures(rectB, integralIm);





































% function featureBValue = GetFeatureB(integralIm, x1, y1, x2, y2)
% %create rectangle kernel - type B 
% rectB = [x1       y1       ;
%          x1       y1 + y2/2;
%          x1       y1 + y2  ;
%          x1 + x2  y1       ;
%          x1 + x2  y1 + y2/2;
%          x1 + x2  y1 + y2  ];
% rectB = rectB';
% rectB = round(rectB);
% % visualizzaFeatures(rectB, integralIm);
% x = unique(rectB(1,:));
% y = unique(rectB(2,:));
% point3 = integralIm(y(2), x(2))   - ...
%          integralIm(y(2)-1, x(1)) - ...
%          integralIm(y(1), x(2)-1) + ...
%          integralIm(y(1)-1, x(1)-1); 
% point4 = integralIm(y(3), x(2))   - ...
%          integralIm(y(3)-1, x(1)) - ...
%          integralIm(y(2), x(2)-1) + ...
%          integralIm(y(2)-1, x(1)-1);            
% featureBValue = point4 - point3;
%             

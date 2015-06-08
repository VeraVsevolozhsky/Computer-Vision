function DrawSurfPoints(I, IntrPoints)
imshow(I); 
hold on;
plot(IntrPoints(:,2), IntrPoints(:,1), 'rs', 'MarkerFaceColor','g','MarkerSize',3,'MarkerEdgeColor','k')
% plot(IntrPoints(:,2), IntrPoints(:,1), 'r*');
for i = 1 : length(IntrPoints)
    y                     =  IntrPoints(i,1);   % row
    x                     =  IntrPoints(i,2);   % column
    scale                 =  IntrPoints(i,3);   % scale
    dominantOrientation   =  IntrPoints(i,4);   % angle
    radius =  ((9 / 1.2) * scale) / 3;     
    dx = radius * cos(dominantOrientation);
    dy = radius * sin(dominantOrientation);       
    line([x x+dx], [y y+dy], 'Color', 'r');   
    circle([x y], radius, 100,'r'); %3rd party
end
hold off
title(sprintf('%d points have been selected',length(IntrPoints)));
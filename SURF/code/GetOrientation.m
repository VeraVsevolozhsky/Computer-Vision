%This function calculates  dominant orientation for interesting point
%Input  -  struct of Haar wavelet response around interesting point
%Output -  dominant orientation (longest gradient)
function [dominantOrientation] = GetOrientation(structHaarResponse)
dominantOrientation = 0;
maxGradientMagnitude = 0;
for ang1 = 0 : 0.1 : 2*pi
    sumDx = 0; sumDy = 0;
    %consider pi/3=60 degree area
    ang2 = ang1 + pi/3;
    %treat overflow case (e.g. if ang1 = 350 degrees then ang2=50 degrees)
    if(ang2 > 2*pi)
       ang2 = ang1 - 5*pi/3; 
    end    
    %go over Haar response struct values and calculate maximum gradient magnitude
    %and its orientation
    for j=1:length(structHaarResponse)        
        angle = structHaarResponse(j).angle;
        %check whether the angle in the sliding orientation window ( angle1 <angle < angle1+60 degrees)
        if(ang1 < ang2 && angle > ang1 && angle < ang2)
           sumDx = sumDx + structHaarResponse(j).dx;
           sumDy = sumDy + structHaarResponse(j).dy; 
        %otherwise - treat the overflow case mentioned above
        else if (ang2 < ang1 && ((angle > 0 && angle < ang2) || (angle > ang1 && angle < 2*pi)))
                 sumDx = sumDx + structHaarResponse(j).dx;
                 sumDy = sumDy + structHaarResponse(j).dy;
             end    
        end
    end
    magnitude = sumDx^2 + sumDy^2;
    if (magnitude > maxGradientMagnitude) 
        %update maximum gradient magnitude   
        maxGradientMagnitude = magnitude; 
        %calculate dominant orientation
        dominantOrientation = CalcAngle(sumDx, sumDy);
    end    
end


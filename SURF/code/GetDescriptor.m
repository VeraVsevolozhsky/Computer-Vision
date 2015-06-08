%This function creates Description of interesting points found in the image
%Input  - integral image(integralIm); set of interesting points(intrPoints)
%Output - updated interesting points(intrPoints) set with dominant orientation(angle)
function [intrPoints] = GetDescriptor(integralIm, intrPoints)
for idx = 1 : length(intrPoints)
    row                  = intrPoints(idx,1);   %row 
    col                  = intrPoints(idx,2);   %column
    scale                = intrPoints(idx,3);   %scale
    %calculate Haar response(e.g. calculate gradient approximation - dx,dy)
    structHaarResponse   = CalculateHaarResponse(integralIm, col, row, scale);
    dominantOrientation  = GetOrientation(structHaarResponse);   
    intrPoints(idx,4)    = dominantOrientation;
    % TBD - calculate features of length 64 each vector
    % descriptorVector    = CreateDescriptor(IntIm, x, y, scale, orientation);
end

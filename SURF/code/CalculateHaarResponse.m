%This function scans the area around interesting point (-6*scale....+6*scale in 4 directions)
%and calculates Haar wavelets response
%Input - integral image(integralIm); interesting point para.{col,row,scale}
function structHaarResponse = CalculateHaarResponse(integralIm, col, row, scale)
idx = 1;
%scan 6*scale area(in 4 directions) around interesting point
for i = -6*scale : scale: 6* scale    %  columns
    for j = -6*scale :scale: 6*scale  %  rows
       if(i^2 + j^2 <36*(scale^2))
             %The responses are weighted with a Gaussian centered at the interest point.
             g     = Gaussian(i,j,2.5*scale);       
             %side length of window around interesting point is 4*scale
             dx    = g*HaarResponseX(integralIm, row+j, col+i, 4*scale);
             dy    = g*HaarResponseY(integralIm, row+j, col+i, 4*scale);
             angle = CalcAngle(dx,dy);
             %store gradient parameters (dx,dy,arctan{dy/dx}-angle of the gradient)
             structHaarResponse(idx).dx    = dx;
             structHaarResponse(idx).dy    = dy;
             structHaarResponse(idx).angle = angle ;  
             idx = idx +1;
       end
    end
end

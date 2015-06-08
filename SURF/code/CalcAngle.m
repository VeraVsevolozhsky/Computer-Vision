function angle = CalcAngle(dx,dy)
% angle=atan2(y,x)

if(dx >= 0 && dy >= 0)
    angle=atan(dy/dx);
else if (dx < 0 && dy >= 0)
    angle=pi-atan(-dy/dx) ;
else if(dx < 0 && dy < 0)
    angle = pi + atan(dy/dx);
else if(dx >= 0 && dy < 0)
    angle = 2*pi - atan(-dy/dx);
else   angle=0;
     end
     end
     end
end
         
           

       
          
          



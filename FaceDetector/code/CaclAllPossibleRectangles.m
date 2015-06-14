function StructPoints = CaclAllPossibleRectangles(isRectPrepared)  
close all;
y = 24;
x = 24;
if(~isRectPrepared)
   
    idx = 1;
    for sy = 1:y  
            for sx=1:x
                for j=1:y-sy
                    for i=1:x-sx
                         StructPoints(idx).x1 = i;
                         StructPoints(idx).y1 = j;
                         StructPoints(idx).x2 = i+sx;
                         StructPoints(idx).y2 = j+sy; 
                         idx = idx+1;                                   
                    end
                end
            end 
    end
else
    load 'StructPoints.mat';
end        
[n,m] = size(StructPoints);
randPoints = randi(m,250,1);
StructPoints  = StructPoints(randPoints);
hold on  
rectangle('position', [0 0  x y], 'FaceColor','white');
for i = 1:length(randPoints)
    rectangle('Position',[StructPoints(i).x1 StructPoints(i).y1 ...
                          StructPoints(i).x2-StructPoints(i).x1 ...
                          StructPoints(i).y2-StructPoints(i).y1],'FaceColor','red')
    pause(0.02)  
end

hold off









% for sy=1:floor(y/2)   
%         for sx=1:floor(x/2)
%             for j=2:y-(2*sy)
%                 for i=2:x-(2*sx)
%                      StructPoints(idx).x1 = i;
%                      StructPoints(idx).y1 = j;
%                      StructPoints(idx).x2 = i+sx;
%                      StructPoints(idx).y2 = j+sy; 
%                      idx = idx+1;
%                 end
%             end
%         end 
%   end
%         
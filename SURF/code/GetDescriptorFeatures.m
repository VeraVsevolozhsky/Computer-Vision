function  descFeatures = GetDescriptorFeatures(integralIm, intrPoints)
%Preallocating descriptor features matrix
descFeatures = [];
%go over all points
[n,~] = size(intrPoints);
for  pointNum =  1 : n
     Y       =  intrPoints(pointNum,1);  %row
     X       =  intrPoints(pointNum,2);  %col
     scale   =  intrPoints(pointNum,3);  %scale
     cosOfOrientation = cos(intrPoints(pointNum,4));
     sinOfOrientation = sin(intrPoints(pointNum,4));
     idx=1;
     featuresVec = zeros(1,64);
     %devide rectangle. arount interesting point into 16 parts
     for i = -10:5:9
         for j = -10:5:9
          dx=0;dy=0;absDx=0;absDy=0;
          %sample 25  points in each sub-rectangle
          for y = i : i + 4      % rows
              for x = j : j + 4  % col       
                %got (k,l) point coordinates in the rotated axis according to the
                %longest gradient angle            
                
                %%TBD - check rotation calculation & Gaussian                
                %rotX = x*cos(theta)-y*sin(theta)
                rotX = round(X + scale*(x*cosOfOrientation - y*sinOfOrientation));
                %rotX = x*sin(theta)+y*cos(theta)
                rotY = round(Y + scale*(x*sinOfOrientation + y*cosOfOrientation));                
                %weight with gaussian in the current interesting point(X,Y)
                %g   = Gaussian(x * scale, y * scale, 3.3 * scale);
                
                %calculate Haar response in current point (x,y)
                rotdx  = HaarResponseX(integralIm, rotY, rotX, 2 * scale);
                rotdy  = HaarResponseY(integralIm, rotY, rotX, 2 * scale); 
                             
                %sum dx,dy, absolute values of dx & dy
                dx    = dx    + rotdx;        dy    = dy    + rotdy;
                absDx = absDx + abs(rotdx);   absDy = absDy + abs(rotdy);                           
              end
          end   
          %25  sample points contributes 4 param. to feature vector
          featuresVec(idx)   = dx;
          featuresVec(idx+1) = dy;
          featuresVec(idx+2) = absDx;
          featuresVec(idx+3) = absDy;
          idx = idx + 4;       
         end
     end  
      %normalize 1x64 features vector
      featuresVec  = normalizeVector(featuresVec);
      descFeatures = [descFeatures featuresVec'];    
end






           


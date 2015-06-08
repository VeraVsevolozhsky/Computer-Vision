function descriptorVector = CreateDescriptor(IntIm, x, y, scale, orientation)
co = cos(x);
si = sin(y);
count = 1;
for i = -10:5:10
   for j = -10:5:10
       dx=0;dy=0;mdx=0;mdy=0; 
       
        for k = i:(i + 5)
            for l = j:(j + 5)
               
                sample_x = round(x + (-l*scale*si + k*scale*co));
                sample_y = round(y + (l * scale * co + k * scale * si));
                g = Gaussian(k * scale, l * scale, 3.3 * scale);                            
                                
                rx = g * HaarResponseX(IntIm, sample_y, sample_x, 2 * scale);
                ry = g * HaarResponseY(IntIm, sample_y, sample_x, 2 * scale);
                                              
                rrx = -rx*si + ry*co;
                rry = rx*co + ry*si;
                dx = dx + rrx;
                dy = dy + rry;
                mdx = mdx + abs(rrx);
                mdy = mdy + abs(rry);               
                
                
            end
        end
        
        descriptorVector(count).dx = dx;
        descriptorVector(count).dy = dy;
        descriptorVector(count).mdx = mdx;
        descriptorVector(count).mdy = mdy;
        count = count + 1 ;
                    
       
   end
end


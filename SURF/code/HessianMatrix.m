%This function calculates Hessian matrix values (Hessian = [ Dxx Dxy;Dxy Dyy ] )
%and Hessian approx. determinant (Dxx*Dyy - 0.81Dxy*Dxy)
function DetHes = HessianMatrix(IntegralIm, threshold)  
inx = 1;
[imH,imW] = size(IntegralIm);
%Preallocating for speed
convolvedIm = zeros(imH,imW,4);
%in this exercise we use 1 octave with scales belong to {9 15 21 27} set
for scale = 9:6:27       
     for y=1:imH
        for x=1:imW
            convolvedIm(y,x,inx)   = getDxx(IntegralIm, y, x, scale) ;
            convolvedIm(y,x,inx+1) = getDyy(IntegralIm, y, x, scale) ;
            convolvedIm(y,x,inx+2) = getDxy(IntegralIm, y, x, scale) ;
        end       
    end   
    inx = inx + 3;     
end
DetHes = convolvedIm(:,:,1:3:end).*convolvedIm(:,:,2:3:end) - 0.81*convolvedIm(:,:,3:3:end).^2;
%remove all values less then zero
DetHes(DetHes<=threshold) = 0;




































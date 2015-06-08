%This function calculates integral image (cumulative sum of the elements of I matrix)
%Input  - image(I)
%Output - integral image(integralIm)
function integralIm = integralImage(I)
integralIm = cumsum(cumsum(im2double(I)),2);
%display integral image
% mIntensity = max(max(integralIm));
% imshow(integralIm./mIntensity);figure;

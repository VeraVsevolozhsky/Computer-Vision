function integralIm = integralImage(img)
integralIm = cumsum(cumsum(im2double(img)),2);
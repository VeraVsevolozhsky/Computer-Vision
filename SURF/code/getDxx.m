function Dxx=getDxx(IntIm,y,x,filtersize)
y;
x;
filtersize;
center = (filtersize - 1) / 2;
lobe_H = filtersize / 3;
lobe_W = 5 + 4 * (filtersize - 9) / 6;
y1 = y - center;
y4 = y + center;
y2 = y - center + lobe_H;
y3 = y + center - lobe_H;
x1 = x - (lobe_W - 1) / 2;
x2 = x + (lobe_W - 1) / 2;
Dxx = -getIntegralSquare(IntIm, x1, y2, x2, y3) * 3 + ... %black zone
       getIntegralSquare(IntIm, x1, y1, x2, y4);          %all zone=white+black zone(weight=1 for all zone)   
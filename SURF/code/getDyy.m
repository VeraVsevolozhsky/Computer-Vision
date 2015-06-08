function Dyy = getDyy(IntIm, y, x, filtersize)
center = (filtersize - 1) / 2;
rec_H  = filtersize / 3;
rec_W  = 5 + 4 * (filtersize - 9) / 6;

x1 = x - center;
x4 = x + center;
x2 = x - center + rec_H;
x3 = x + center - rec_H;
y1 = y - (rec_W - 1) / 2;
y2 = y + (rec_W - 1) / 2;

%(white+black+white)- 3*black zone = white -2*black+white zone
Dyy = -getIntegralSquare(IntIm,x2, y1, x3, y2) * 3 +...  %black zone with weight=3
       getIntegralSquare(IntIm, x1, y1, x4, y2);         %white + black zone(all zone with weight=1)
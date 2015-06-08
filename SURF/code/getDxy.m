function Dxy = getDxy(IntIm, y, x, filtersize)
recSize = filtersize / 3;
x1 = x - recSize;
x4 = x + recSize;
x2 = x - 1;
x3 = x + 1;
y1 = y - recSize;
y4 = y + recSize;
y2 = y - 1;
y3 = y + 1;

Dxy=-getIntegralSquare(IntIm, x3, y1, x4, y2) - getIntegralSquare(IntIm, x1, y3, x2, y4)+ ...  %black zone
     getIntegralSquare(IntIm, x1, y1, x2, y2) + getIntegralSquare(IntIm, x3, y3, x4, y4);      %white zone
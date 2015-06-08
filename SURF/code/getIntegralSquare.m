function val = getIntegralSquare(IntIm ,colA, rowA, colD, rowD)
[H,W] = size(IntIm);
if (( colA>1&&rowA >1) && (colD <= H&&rowD <=W))    
    A = IntIm(colA, rowA);
    D = IntIm(colD, rowD);
    B = IntIm(colA, rowD);
    C = IntIm(colD, rowA);
    val = A + D - (C + B);
else
    val=0;
end


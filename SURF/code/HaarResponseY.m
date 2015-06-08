function dy=HaarResponseY(IntIm, row, col, scale)
r1 = row - scale/2;c1 = col - scale/2;
midCol = col;
r3 = row + scale/2;c3 = col + scale/2;
dy = getIntegralSquare(IntIm, midCol, r1, c3, r3)-...  %white area
     getIntegralSquare(IntIm ,c1, r1, midCol, r3);     %black area

end



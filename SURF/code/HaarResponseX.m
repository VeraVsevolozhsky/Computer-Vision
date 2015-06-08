function dx=HaarResponseX(IntIm, row, col, scale)
r1 = row - scale/2;c1 = col - scale/2;
midRow = row;
r3 = row + scale/2;c3 = col + scale/2;
dx =  -getIntegralSquare(IntIm,c1, r1, c3, midRow) + ...   % black area
       getIntegralSquare(IntIm,c1, midRow, c3, r3);        % white area

end





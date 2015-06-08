%This function performs non-max suppression
%To do this each pixel in the scale-space is compared to its 26 neighbours, comprised
%of the 8 points(3x3 area) in the native scale and the 9 in each of the scales above
%and below.

%Input  - approx. determinant of Hessian matrix
%Output - interesting points 
function [IntrPoints] = NonMaxSupression(HesMatrix)
%find maximum in 3x3 area in the native scale
area = strel('square',3) ;
localMaxInEachScale = imdilate(HesMatrix,area);
%alternative - local max in 3x3 area in the native scale can be calculated using Max filter: localMaxInEachScale = ordfilt2(HesMatrix,9,ones(3,3))
[n,m,numOfScales]=size(localMaxInEachScale);
%find maximum in each of the scales above and below.
localMaxOfMaxInEachScale(:,:,1)           = max(localMaxInEachScale(:,:,1:2),[],3);
localMaxOfMaxInEachScale(:,:,numOfScales) = max(localMaxInEachScale(:,:,end-1:end),[],3);
for i=2:numOfScales-1
    localMaxOfMaxInEachScale(:,:,i)       = max(localMaxInEachScale(:,:,i-1:i+1),[],3);
end
disp('store interesting points')
IntrPoints = [];idx=1;
for j =1:numOfScales
    ind = find((HesMatrix(:,:,j)~=0) & (HesMatrix(:,:,j)==localMaxOfMaxInEachScale(:,:,j)));
    [row, col] = ind2sub([n m],ind);
    scale = round(((9 + (j-1) * 6) * 1.2 / 9)); % TBD - to check this formula
    intrPointsCoord = [row col repmat(scale, length(row), 1)];
    IntrPoints      = [IntrPoints; intrPointsCoord];    
    end
end


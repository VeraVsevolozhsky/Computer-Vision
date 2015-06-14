function [sampleSet, labels, featureRecPoints] = FeatureExtraction(positiveExamples, negativeExamples)
[~,~,numOfPositiveExamples] = size(positiveExamples);
[~,~,numOfNegativeExamples] = size(negativeExamples);
sampleSet = [];
numberOfCycles   = 250;
sizeOfSample     = 24;
tic;
disp('compute integral image');
intFaces    = integralImage(positiveExamples);
intNonFaces = integralImage(negativeExamples);
toc;
tic;
featureRecPoints = CaclAllPossibleRectangles(1);
for i = 1 : numberOfCycles
   x1 = featureRecPoints(i).x1;y1 = featureRecPoints(i).y1;
   x2 = featureRecPoints(i).x2;y2 = featureRecPoints(i).y2;
   positiveFeatures = GetFeatures(intFaces,x1,y1,x2,y2); 
   negativeFeatures = GetFeatures(intNonFaces,x1,y1,x2,y2); 
   sampleSet = [sampleSet; positiveFeatures negativeFeatures];  
end
toc;
disp('compute features from integral image');
labels    = [ones(1, numOfPositiveExamples) zeros(1, numOfNegativeExamples)];



















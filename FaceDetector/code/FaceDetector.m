function [model, rectangles] = FaceDetector(isTrainingComplete,isRectSaved)
close all;
%read data from image DB
addpath 'C:\Documents and Settings\vera\My Documents\MATLAB\FaceDetector\data';
addpath 'C:\Documents and Settings\vera\My Documents\MATLAB\FaceDetector\code\classifiers';
addpath 'C:\Documents and Settings\vera\My Documents\MATLAB\FaceDetector\code\classifiers\boosting';
addpath 'C:\Documents and Settings\vera\My Documents\MATLAB\FaceDetector\data\testPic';

if(~isTrainingComplete)
    negativeExamples = readImagesFromDB('nonfaces.pat');
    positiveExamples = readImagesFromDB('faces.pat');        
    [sampleSet, labels, featureRecPoints] = FeatureExtraction(positiveExamples, negativeExamples);
    trainSet       = sampleSet(:,1:2:end);
    trainLabelsSet = labels(1:2:end);
 
    TestSet = sampleSet(:,2:2:end);
    TestLabelsSet = labels(:, 2:2:end);    
         
    model = CLSgentleBoost(trainSet, trainLabelsSet');    
    [predictedLabels, ~] = CLSgentleBoostC(TestSet, model);
    test_error = sum(TestLabelsSet~=predictedLabels')/length(TestLabelsSet)  
    delete TrainingModel.mat;
    save('TrainingModel.mat', 'featureRecPoints', 'model');
    disp('Training data has been saved successfully in TrainingModel.mat');
else
    load TrainingModel.mat;    
end
% I = imread('face2.jpg');
I = imread('iphone_prog_team.jpg');
I = imresize(I,[300 300]);
I=rgb2gray(I);
if(~isRectSaved)
 rectangles = ScanFaceDetector(I, model, featureRecPoints);
 DisplayFace(I, rectangles);
else
    load 'rectangles.mat';
    DisplayFace(I, rectangles);
end

   



























% function [TrainLabelsSet, TestLabelsSet, model, isFace] = FaceDetector
% close all;
% %read data from image DB
% negativeExamples = readImagesFromDB('C:\Documents and Settings\vera\My Documents\ComputerVision\L8\Viola\viola-traindata\package\data\nonfaces.pat');
% positiveExamples = readImagesFromDB('C:\Documents and Settings\vera\My Documents\ComputerVision\L8\Viola\viola-traindata\package\data\faces.pat');
% 
% 
% 
% 
% [~,~,numOfImages] = size(positiveExamples);
% positiveFeatures = []; 
% 
% for i = 1 : 29
%     faceIm =  positiveExamples(:,:,i);    
% %     imshow(uint8(faceIm));
%     integralIm = integralImage(faceIm);  
% %     imshow(integralIm);    
%     positiveFeatures = [positiveFeatures GetFeatures(integralIm)];    
% end
% 
% negativeFeatures = []; 
% for j = 1 : 38
%     nonfaceIm =  negativeExamples(:,:,j); 
%     integralIm = integralImage(nonfaceIm);  
%     negativeFeatures = [negativeFeatures GetFeatures(integralIm)];    
% end
% 
% featuresDS = [positiveFeatures negativeFeatures];
% lablesDS   = [ones(1, length(positiveFeatures)) zeros(1, length(negativeFeatures))];
% 
% addpath 'C:\Documents and Settings\vera\My Documents\ComputerVision\L8\classifiers';
% addpath 'C:\Documents and Settings\vera\My Documents\ComputerVision\L8\classifiers\boosting';
% 
% %splitting data to training and control set
% TrainSet       = featuresDS(:,1:2:end);
% TrainLabelsSet = lablesDS(1:2:end);
% 
% TestSet       = featuresDS(:,2:2:end);
% TestLabelsSet = lablesDS(2:2:end);
% 
% %call to Gentle AdaBoost (1) train; 2)classify)
 %model = CLSgentleBoost(TrainSet, TrainLabelsSet');
% I = imread('C:\Documents and Settings\vera\My Documents\ComputerVision\L8\Viola\face.jpg');
% isFace = SearchAndDisplayFaceDetector(I, 20, 20, model);
% % DisplayFace(isFace, I);
% % [predictedLabels, weights] = CLSgentleBoostC(TestSet, model);
% %caclulate error
% % test_error = sum(TestLabelsSet~=predictedLabels')/length(TestLabelsSet);
% 

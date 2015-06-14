function rectangles = ScanFaceDetector(controlImage, model, featureRecPoints)
warning off all
winSize = 24;
fSet=[];
% Im = rgb2gray(imresize(controlImage, [250 250]));

rectangles=[];
recCount = 0;
scale = 1;
tic;
resizedIm = double(imresize(controlImage, [300 300]));
[n,m] =  size(resizedIm)  

count = 1;
tic;
for y = 1 : 3 : n - winSize
    for x = 1 : 3 : m - winSize
         imChunks(:,:,count)  = resizedIm(y:y+winSize,x:x+winSize); 
         index(count).x = x;
         index(count).y = y;
         count = count + 1;        
    end
end


toc;
inIm = integralImage(imChunks);
for i = 1:250
     features = GetFeatures(inIm,featureRecPoints(i).x1,featureRecPoints(i).y1,...
                                 featureRecPoints(i).x2,featureRecPoints(i).y2); 
     fSet = [fSet; features];                                  
end    
[predictedLabel, Weights] = CLSgentleBoostC(fSet, model);   
sum((predictedLabel'==1)&(Weights>2.3))
rectPoints = index((predictedLabel'==1)&(Weights>2.3));
[n,m]=size(rectPoints);
for i= 1:m
    rectangles(i,:) = [rectPoints(i).x rectPoints(i).y  winSize winSize];
end

rectangles = fix(rectangles);
save('rectangles.mat', 'rectangles');
disp('rectangles data has been saved successfully in Rectangles.mat');

















% for scale=0.05: 0.05 : 0.3
%     resizedIm = double(imresize(controlImage, [220 220]));
%     [n,m] =  size(resizedIm);    
%     tic
%     cropedIM = mat2cell(resizedIm, repmat(24,[1 size(resizedIm,1)/24]),...
%                                    repmat(24,[1 size(resizedIm,2)/24]));
%     toc
%     [n,m] = size(cropedIM);
%     count = 1;
%     for i = 1 : n
%         for j = 1:m
%             Temp(:,:,count) = cropedIM{i,j};
%             count = count + 1;
%         end
%     end
%     inIm = integralImage(Temp);
%     size(inIm)
%      for i = 1:250
%          features = GetFeatures(inIm,featureRecPoints(i).x1,featureRecPoints(i).y1,...
%                                      featureRecPoints(i).x2,featureRecPoints(i).y2); 
%          fSet = [fSet; features];                                  
%      end    
%      
%    [predictedLabel, Weights] = CLSgentleBoostC(fSet, model);
%    predictedLabel~=0
%    
%    x = 1:winSize-1:ImW-winSize;
%    y = 1:winSize-1:ImH-winSize; 
%    rectangles = []
    
    
    
%     
%     
%     for y = 1 : 3 : n - winSize
%          for x = 1 : 3 : m - winSize
% %              imChunks(:,:,count)  = resizedIm(y:y+winSize,x:x+winSize);               
%              imChunks  = resizedIm(y:y+winSize,x:x+winSize)  ;
%              inIm = integralImage(imChunks);
%              for i = 1:250
%                  features = GetFeatures(inIm,featureRecPoints(i).x1,featureRecPoints(i).y1,...
%                                              featureRecPoints(i).x2,featureRecPoints(i).y2); 
%                  fSet = [fSet; features];                                  
%              end             
%              fSet;
%              [predictedLabel, Weights] = CLSgentleBoostC(fSet, model);           
%              fSet = [];
%              Weights;
%              %isFaceMatrix(y,x)  = predictedLabel; 
%              if(predictedLabel == 1 )%&& Weights>1.5)
%                 Weights
%                 recCount = recCount + 1;
% %                 rectangles(recCount,:) = [y x (y + winSize) (x + winSize)]/scale
%                 rectangles(recCount,:) = [y x  winSize winSize]/scale
%              end
%          end
%     end    
%     recCount
% %  end
% %  squares = squares/resizeBy; 
% 
% 
% 
% 
% 
% rectangles = fix(rectangles)
% save('rectangles.mat', 'rectangles');
% disp('rectangles data has been saved successfully in Rectangles.mat');
% toc;
% warning on all



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
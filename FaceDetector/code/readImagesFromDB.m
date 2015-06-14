function faces=readImagesFromDB (fileName)
imgSize = 24;
fid = fopen(fileName);
if fid == -1,
  disp('Unable to open file');
else,   
fseek(fid, 0, 'eof');
numImages = ftell(fid) / (imgSize * imgSize);
fseek(fid, 0, 'bof'); 
faces = zeros(imgSize, imgSize, numImages);
for i = 1:numImages,
  [image] = fread(fid, [imgSize imgSize], 'uint8');
  faces(:,:,i) = image;     
end;
%     R = 1;
%     figure(1);
%     clf;
%     while ~isempty(R),
%       R = input(sprintf(['Display image number (1 to %d) or nothing to' ...
% 			 ' quit: '], numImages)); 
%       if ~isempty(R),
%         imshow(uint8(faces(:,:,R)));
%       end;
%     end;       
  end;  
    
function DisplayFace(I, rectangles)
[n,m]=size(rectangles);
figure;imshow(double(I)./255);
hold on;
for i = 1 : n   
    rectangle('position', rectangles(i,:), 'EdgeColor', 'red');
end
hold off;


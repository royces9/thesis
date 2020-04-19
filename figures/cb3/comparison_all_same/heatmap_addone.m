function [ probMat , complexData ] = heatmap_addone(file, x1, x2, y2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

data = dlmread(file,'',1,0);

x1x2 = data(:, 5);
x1y2 = data(:, 6);
x1y2(x1y2 == 0) = 1;

sizeData = numel(x1x2);

%y-axis is x1x2
%x-axis is x1y2
probMat = zeros(min(x1, x2)+1, min(x1, y2)+1);

for i = 1:sizeData;
    probMat(x1x2(i) + 1, x1y2(i) + 1) = probMat(x1x2(i) + 1, x1y2(i) + 1) + 1;
end

specificity = extractColumn(x1x2./x1y2);
complexData = [extractColumn(x1x2), extractColumn(x1y2)];
specText = ['Specificity:', char(10),...
    'Mean: ', num2str(specificity(1)), char(10),...
    'Median: ', num2str(specificity(2)), char(10),...
    'Std Dev: ', num2str(specificity(3)), char(10),...
    '10th: ', num2str(specificity(4)), char(10),...
    '90th: ', num2str(specificity(5)), char(10)];

maximum = sum(sum(probMat));
probMat = probMat/maximum;

imagesc(probMat);

xlabel('x1y2');
ylabel('x1x2');
text(min(x1, y2)*0.2,min(x1, x2)*0.2+1, specText, 'Color', 'white');
colorbar
end


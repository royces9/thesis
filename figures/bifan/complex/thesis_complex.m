function [] = thesis_complex(x1, x2, y1, y2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

x1x2 = zeros(5, numel(x1));
x1y2 = zeros(5, numel(x1));
y1y2 = zeros(5, numel(x1));
y1x2 = zeros(5, numel(x1));

x2s = int2str(x2);
y1s = int2str(y1);
y2s = int2str(y2);
pre = ['raw_data/', x2s, '-', y1s,'-', y2s, '/bifan-'];
post = ['-', x2s, '-', y1s, '-', y2s '.gdat'];
for i = 1:numel(x1)
    file = [pre,  int2str(x1(i)), post];
    data = extractData(file);

    x1x2(:, i) = extractColumn(data(:, 6));
    x1y2(:, i) = extractColumn(data(:, 7));
    y1y2(:, i) = extractColumn(data(:, 8));
    y1x2(:, i) = extractColumn(data(:, 9));
end

data = {x1x2, x1y2, y1y2, y1x2};
color = {'-r', '-b', '-g', 'y'};
leg_name = {'x1x2', 'x1y2', 'y1y2', 'y1x2'};
leg_entry = cell(4, 1);
shade = cell(4, 1);
figure;
for j = 1:4
    hold on;
    shade{j} = shadedErrorBar(x1', data{j}(1, :)', [data{j}(3, :)', data{j}(3, :)'], 'patchSaturation', .12, 'transparent', 1, 'lineprops', color{j});
    color = {'-r', '-b', '-g', 'y'};
    leg_entry{i} = shade{j}.mainLine;
end

legend([shade{1}.mainLine, shade{2}.mainLine, shade{3}.mainLine, shade{4}.mainLine], leg_name);

xlim([x1(1), x1(end)]);
end

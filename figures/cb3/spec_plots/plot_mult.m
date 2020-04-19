volume = 10;
step = 1;
x1 = [20 100 30 15];
x2 = [10 100 100 10];
y2 = [10 10  100 100];

for i = 1:4
    subplot(2, 2, i);
    hold on;
    spec_plot(x1(i), x2(i), y2(i), volume, step);
    hold off;
end

set(gcf,'color','w');
set(findall(gcf,'-property','FontSize'),'FontSize',20);
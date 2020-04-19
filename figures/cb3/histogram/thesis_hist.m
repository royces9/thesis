figure;

sub_handle = zeros(3, 1);
v_handle = zeros(3, 1);
v = [1 10 100];

prefix = 'thesis_figs/histogram/';
file = {[prefix, 'vol_1.gdat'], [prefix, 'vol_10.gdat'], [prefix, 'vol_100.gdat']};

for i = 1:3
    sub_handle(i) = subplot(1, 3, i);
    hold on;
    v_handle(i) = spec_histo(file{i}, 10, 10 , 10, v(i));
    xlim([0 10]);
    hold off;
end

set(gcf,'color','w');
set(findall(gcf,'-property','FontSize'),'FontSize',20);

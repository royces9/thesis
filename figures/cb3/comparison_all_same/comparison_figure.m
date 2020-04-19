%data = load('cme_poisson_simulation_comparison.mat');
volume = 10;

Nx1 = 10 * volume;
Nx2 = 10 * volume;
Ny2 = 10 * volume;

means = deterministic_steady_state_function(Nx1, Nx2, Ny2, volume);
mux = means(1);
muy = means(2);

cme = mine_solve_CME(Nx1, Nx2, Ny2, volume, 0);
gaussian = CB3_gaussian(Nx1, Nx2, Ny2, volume);
p = heatmap_addone('thesis_figs/histogram/vol_10.gdat', 100, 100, 100);
simu = p;
%simu = data.data(:, :, 3);

simu_cme = (simu - cme) .^2 ;
simu_gaussian = (simu - gaussian) .^ 2;
cme_gaussian = (cme - gaussian) .^ 2;


SSD_simu_cme = sum(simu_cme(:));
SSD_simu_gaussian = sum(simu_gaussian(:));
SSD_cme_gaussian = sum(cme_gaussian(:));


%figure stuffx
fig = figure(1);

panel = uipanel('Parent', fig);
% 
% 
% ,'BackgroundColor', [1 1 1]...
%     ,'BorderType', 'none'...
%     ,'HighlightColor', [1 1 1]...
%     ,'Title', 'Comparison of different methods'...
%     ,'TitlePosition', 'centertop'...
%     ,'FontSize', 20);
 
 panel.BackgroundColor = [1 1 1];
 panel.BorderType = 'none';
 panel.HighlightColor = [1 1 1];
 panel.Title = 'Comparison of different methods';
 panel.TitlePosition = 'centertop';
 panel.FontSize = 20;


%CME plot
cme_plot = subplot(1, 3, 1, 'Parent', panel);
imagesc(cme);
colorbar;
title(cme_plot, 'CME', 'FontSize', 20);
xlabel('x1y2', 'FontSize', 20);
ylabel('x1x2', 'FontSize', 20);

%set(gca,'XTickLabel',['0 '; '1 '; '2 '; '3 '; '4 '; '5 '; '6 '; '7 '; '8 '; '9 ';'10']);
%set(gca,'YTickLabel',['0 '; '1 '; '2 '; '3 '; '4 '; '5 '; '6 '; '7 '; '8 '; '9 ';'10']);


%poisson plot
poisson_plot = subplot(1, 3, 2, 'Parent', panel);
imagesc(poisson);
colorbar;
title(poisson_plot, 'Gaussian', 'FontSize', 20);

xlabel('x1y2', 'FontSize', 20);
ylabel('x1x2', 'FontSize', 20);

%set(gca,'XTickLabel',['0 '; '1 '; '2 '; '3 '; '4 '; '5 '; '6 '; '7 '; '8 '; '9 ';'10']);
%set(gca,'YTickLabel',['0 '; '1 '; '2 '; '3 '; '4 '; '5 '; '6 '; '7 '; '8 '; '9 ';'10']);


%simulation plot
simu_plot = subplot(1, 3, 3, 'Parent', panel);
imagesc(simu);
colorbar;
title(simu_plot, 'Simulation', 'FontSize', 20);

xlabel('x1y2', 'FontSize', 20);
ylabel('x1x2', 'FontSize', 20);

%set(gca,'XTickLabel',['0 '; '1 '; '2 '; '3 '; '4 '; '5 '; '6 '; '7 '; '8 '; '9 ';'10']);
%set(gca,'YTickLabel',['0 '; '1 '; '2 '; '3 '; '4 '; '5 '; '6 '; '7 '; '8 '; '9 ';'10']);


% tabulated_data = [0, SSD_simu_cme, SSD_simu_poisson;
%                   SSD_simu_cme, 0, SSD_cme_poisson;
%                   SSD_simu_poisson, SSD_cme_poisson, 0];
% 
% position = get(subplot(2, 2, 4), 'position');
% delete(subplot(2, 2, 4));              
%               
% t = uitable(panel, 'Data', tabulated_data ...
%     ,'ColumnName', {'Simulation', 'CME', 'Poisson'} ...
%     ,'RowName', {'Simulation', 'CME', 'Poisson'} ...
%     ,'ColumnWidth', {175} ...
%     ,'FontSize', 20 ...
% );
% 
% set(t, 'units', 'normalized');
% set(t, 'Position', position + [0 0 0 -0.05]);
% 
% table_position = position + [0 0.3 0 -0.3];
% 
% table_title = uicontrol('Style', 'text' ...
%     , 'Units', 'normalized'...
%     , 'position', table_position...
%     , 'string', 'Sum of Squared Differences between each method'...
%     , 'FontSize', 15....
%     ,'BackgroundColor', [1 1 1]);

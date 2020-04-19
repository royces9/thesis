function [] = spec_plot(x1, x2, y2, volume, step)

Nx1 = 1:step:(x1 * volume);

Nx2 = x2 * volume;
Ny2 = y2 * volume;

percentile = [0.1 0.5 0.9];

sx = x1plot_out(Nx1, Nx2, Ny2, volume, 1, 'gaussian', percentile, 0);

%error bar stuff
resolution = 300;

%0 - marsaglia
%1 - cedilnik
%other - gaussian

flag = 0;
Nx1_err = linspace(0.1, x1, x1 * 10);
perc = zeros(numel(Nx1_err), 3);
for i = 1:numel(Nx1_err);
    [P, S] = Sx_ratio_resolution(Nx1_err(i), Nx2, Ny2, volume, resolution, flag);
    V = [S, P];
    perc(i, :) = getpercentile(V, percentile);
end

Err1 = (perc(:, 3) - perc(:, 2))';
Err2 = (perc(:, 1) - perc(:, 2))';

titleStr = ['CB3 Motif, x_2 = ', num2str(Nx2), ', y_2 = ', num2str(Ny2), ', copy number, volume = ', num2str(volume)];

title(titleStr);
pError = shadedErrorBar(Nx1_err, perc(:, 2)', [-Err1; Err2], 'patchSaturation', .12, 'transparent', 0);

width = 2;
p50 = my_plot(Nx1, sx(:, 1, 1, 2));
p50.LineWidth = width;
p10 = my_plot(Nx1, sx(:, 1, 1, 4));
p10.LineWidth = width;
p90 = my_plot(Nx1, sx(:, 1, 1, 5));
p90.LineWidth = width;
pMean = my_plot(Nx1, sx(:, 1, 1, 1));
pMean.LineWidth = width;

legend([pMean p10 p50 p90 pError.mainLine pError.patch],'S_x Deterministic','S_x Stochastic 10%','S_x Stochastic 50%','S_x Stochastic 90%','Normal approx. 50%','Normal approx. [10,90]' )
xlabel('Concentration of x_1, copy number')
ylabel('Specificity Factor S_x')
end

Nx2 = 100;
Ny2 = 100;
volume = 1;
flag = 0;
Nx1_err = linspace(0.1, 200, 1000);
perc = zeros(numel(Nx1_err), 3);
for i = 1:numel(Nx1_err);
    [P, S] = Sx_ratio_resolution(Nx1_err(i), Nx2, Ny2, volume, 300, flag);
    V = [S, P];
    perc(i, :) = getpercentile(V, [0.1 0.5 0.9]);
end

x1 = 1:1:200;
simu = zeros(numel(x1), 5);
for i = 1:numel(x1)
    [simu(i, :), ~, ~] = extract_simu_data('raw_data/alot/', x1(i), 100, 100);
end

figure;
hold on
for i = 1:3
    err = plot(Nx1_err, perc(:, i));
    err.LineWidth = 2;
end
for i = [4 2 5]
    out = plot(x1, simu(:, i));
    out.LineWidth = 2;
end

legend({'Gaussian 10th', 'Gaussian 50th', 'Gaussian 90th', 'Simulation 10th', 'Simulation 50th', 'Simulation 90th'});

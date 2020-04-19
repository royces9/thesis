Nx1 = 10;
Nx2 = 10;
Ny2 = 10;

volumeRange = unique(floor(10 .^ (0:0.1:1.5)));

SSD = zeros(numel(volumeRange), 1);
means = zeros(numel(volumeRange), 2);
i = 1;

for volume = volumeRange
    means(i, :) = deterministic_steady_state_function(Nx1 * volume, Nx2 * volume, Ny2 * volume, volume);
    poisson = CB3_poisson(Nx1 * volume, Nx2 * volume, Ny2 * volume, means(i, :));
    gaussian = CB3_gaussian(Nx1 * volume, Nx2 * volume, Ny2 * volume, means(i, :));
    
    diff = (poisson - gaussian) .^ 2;
    
    SSD(i) = sum(diff(:));
    i = i + 1;
end

logVR = log10(volumeRange);

figure;
plot(volumeRange, SSD);
title('SSD of Poisson and Gaussian');
xlabel('V, # of bacterial volumes');
ylabel('SSD');
xlim([volumeRange(1) volumeRange(end)]);

figure;
plot(volumeRange, log10(SSD));
title('log(SSD) of Poisson and Gaussian');
xlabel('V, # of bacterial volumes');
ylabel('log(SSD)');
xlim([volumeRange(1) volumeRange(end)]);
% figure(2);
% hold on;
% plot(logVR, means(:, 1));
% plot(logVR, means(:, 2));
% 
% figure(3);
% plot(logVR, (means(:, 1) ./ means(:, 2)));
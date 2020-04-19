function [] = thesis_bifan_spec()
volume = 1;

x2 = 100;
y1 = 100;
y2 = 100;

Nx1 = (10:10:1000)';
Nx2 = floor(x2 * volume);
Ny1 = floor(y1 * volume);
Ny2 = floor(y2 * volume);

v_Nx2 = Nx2 * ones(size(Nx1));
v_Ny1 = Ny1 * ones(size(Nx1));
v_Ny2 = Ny2 * ones(size(Nx1));

simu = bifan_spec(Nx1, Nx2, Ny1, Ny2, 0);

figure;
spec = {'Sx1', 'Sx2', 'Sy1', 'Sy2'};
p_const = 1;

for i = 1:4
    subplot(2, 2, i);
    hold on

    std_down = simu(:, 1, i) - p_const * simu(:, 3, i);
    std_up = simu(:, 1, i) + p_const * simu(:, 3, i);

    std_up = max_value(std_up, Nx1, v_Nx2, v_Ny1, v_Ny2, i);
    std_down(std_down < 0) = 0;


    %plot(Nx1, std_up);
    %plot(Nx1, std_down);

    plot(Nx1, simu(:, 4, i));    
    plot(Nx1, simu(:, 2, i));
    plot(Nx1, simu(:, 5, i));
    
    xlabel('x_1 copy number')
    ylabel('Specificity')
    title([spec{i} ' bifan'])
    set(gca,'FontSize',16)
    %legend('\mu', '\mu + \sigma', '\mu - \sigma', '10th', '90th');
    legend('10th', '50th', '90th');
end
end

function [out] = max_value(std, x1, x2, y1, y2, type)
out = std;

switch(type)
    case 1
        left = x1;
        right = x2;

    case 2
        left = x1;
        right = y2;
        
    case 3
        left = y1;
        right = y2;
        
    case 4
        left = y1;
        right = x2;
end

max_spec = min(left, right);

ind = out > max_spec;
out(ind) = max_spec(ind);

end
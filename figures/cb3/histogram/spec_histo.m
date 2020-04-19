function [pl] = spec_histo(file, Nx1, Nx2, Ny2, volume)
[~, mx, my, ~, ~] = CB3_gaussian(Nx1 * volume, Nx2 * volume, Ny2 * volume, volume);

s = dlmread(file,'',1,0);
histogram(s(:, 5) ./ s(:, 6), 'Normalization', 'probability', 'BinWidth', 0.2);
% maxX = min(Nx1 * volume, Nx2 * volume);
% maxY = min(Nx1 * volume, Ny2 * volume);
% 
% nx = (0:maxX)';
% ny = 0:maxY;
% 
% Sx = repmat(nx, 1, numel(ny)) ./ repmat(ny, numel(nx), 1);
% 
% x1x2 = sum(p, 2);
% x1y2 = sum(p, 1);
% 
% x1x2r = repmat(x1x2, 1, numel(x1y2));
% x1y2r = repmat(x1y2, numel(x1x2), 1);
% 
% Sx_prob = x1x2r .* x1y2r;
% 
% Sx_prob = Sx_prob(:);
% Sx_prob(Sx_prob < 10^-15) = 0;
% Sx = Sx(:);
% 
% Sx_total = [Sx, Sx_prob];
% Sx_total = sortrows(Sx_total);
% 
% Sxunique = unique(Sx_total(:, 1));
% 
% Sxnew = zeros(numel(Sxunique), 2);
% 
% Sxnew(:, 1) = Sxunique;
% j = 1;
% for i = 1:numel(Sxunique)
%    while(Sxnew(i, 1) == Sx_total(j, 1))
%        Sxnew(i, 2) = Sxnew(i, 2) + Sx_total(j, 2);
%        j = j + 1;
%    end
% end
% 
% Sxnew(Sxnew(:, 2) == 0, :) = [];
% 
% bar(Sxnew(:, 1), Sxnew(:, 2), 30, 'FaceColor', [0 0 1], 'EdgeColor', [0 0 1]);
% 
% last_small = find(Sxnew(:, 2) > 10^-4);
% numAvg = mx/my;
% 
% plot([numAvg, numAvg], [0, max(Sxnew(:, 2))], 'r');
% 
% xlim([0, Sxnew(last_small(end), 1)]);
% 
% legend('Stochastic Specificity Distribution', 'Deterministic Specificity');
% xlabel('Specificity, S_x');
% ylabel('Probability');
% fig2_anno = ['\mu_S_x = ', num2str(numAvg)];
% annotation('textbox', 'String', fig2_anno, 'FitBoxToText', 'on');

numAvg = mx/my;
plot([numAvg, numAvg], [0, 0.2], 'r');
legend('Stochastic Specificity Distribution', 'Deterministic Specificity');
xlabel('Specificity, S_x');
ylabel('Probability');
fig2_anno = ['\mu_S_x = ', num2str(numAvg)];
annotation('textbox', 'String', fig2_anno, 'FitBoxToText', 'on');

pl = gcf;
end

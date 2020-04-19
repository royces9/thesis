function [PLands, mx, my, stdx, stdy] = CB3_gaussian(Nx1, Nx2, Ny2, means)
%means can either be a value for the volume, or the mean for x1x2 and x1y2

sizeMeans = numel(means);

if(sizeMeans == 1)
    m = deterministic_steady_state_function(Nx1, Nx2, Ny2, means);
    mx = m(1);
    my = m(2);
elseif(sizeMeans == 2)
    mx = means(1);
    my = means(2);
end

maxCx = min(Nx1, Nx2);
maxCy = min(Nx1, Ny2);

stdx = sqrt(mx);
stdy = sqrt(my);

PLands  = zeros(maxCx+1, maxCy+1);
totalSize = size(PLands);

nx = 0:maxCx;
ny = 0:maxCy;

[Yi, Xi]=meshgrid(ny,nx);
binMatrix = (Xi + Yi) <= Nx1;
iter = find(binMatrix)';

for i = iter
    [xind, yind] = ind2sub(totalSize, i);
    px1 = gaussian_distr(Nx1 - (xind - 1)- (yind - 1), Nx1 - mx - my);
    px2 = gaussian_distr(Nx2 - (xind - 1), Nx2 - mx);
    py2 = gaussian_distr(Ny2 - (yind - 1), Ny2 - my);
    pCx = gaussian_distr(xind - 1, mx);
    pCy = gaussian_distr(yind - 1, my);
            
    PLands(xind, yind) = px1 * px2 * py2 * pCx * pCy;
end

PLands = PLands / sum(sum(PLands));
end


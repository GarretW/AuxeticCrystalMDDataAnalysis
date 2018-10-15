function[xc] = tcrt(y,n,slct)
%% TCRT Test Critical Points
% Generates test critical points from an input matrix or vector.
% Inputs allow for selection of random or linearly spaced critical points
% between absolute bounds of values in input.
%INPUT:
%       y: Input series for critical point generation.
%       n: Number of points to generate. Actual critical points include
%           maximum and mimimum of series.
%       slct: Selector string. 'rnd for random, 'lin' for linear.
%OUTPUT:
%       xc: Length n vector of critical points including bounds.
%%

ubnd = max(y);              % Boundary values of series
lbnd = min(y);
xc = zeros(1,n);            % Critical point preallocation
yl = length(y);

y = sort(y,'ascend');

if strcmp(slct,'rnd')    
    
    r = sort(randi(yl,1,n),'ascend');
    xc = y(r);
    xc(1) = y(1); xc(end) = y(end);
    
elseif strcmp(slct,'lin')
    
               
    xc(1) = lbnd;
    spc = (ubnd-lbnd)/(n-1);       % Bin size
    
    for i = 2:n
        xc(i) = xc(i-1) + spc;
    end
    
end



xc(1) = xc(1) - eps;
xc(end) = xc(end) + eps;
end % function cpts

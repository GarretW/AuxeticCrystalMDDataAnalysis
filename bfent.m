function [ent,xc] = bfent(y,ncp)
%% BFENT Brute Force Entropy


xc = [1, 0, yl];
ent = zeros(1,yl-2);

for i = 2:yl-1
    xc(2) = i;
    ent(i-1) = cgment(y,reg,bf_xc,cpi);
end


end
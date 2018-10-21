function [per,prb] = ordin(reg,cpi)
%% ORDIN Ordinal permutation
%
%
% INPUT:
%       reg: Regressor from time series.
%       cpi: Compression index.
%
% OUTPUT:
%       per: Permutation counts.
%       prb: Permutation probabilities.


regi = zeros(size(reg));

yl = length(reg);
m = size(reg,1);

for i = cpi+1:yl
    a = reg(:,i);
    b = sort(a,'ascend');
    
    for j = 1:m
        a(a==b(j)) = j;
    end
    regi(:,i) = a;
end

per = zeros(1,yl);

for i = cpi+1:yl
    tmp = 0;
    for j = 1:m       
        tmp = tmp + regi(j,i)*10^(m-j);
    end
    per(i) = tmp;
end

w = sort(per(:,cpi+1:end),'ascend');
[w,~,ind] = unique(w);
wct = accumarray(ind,1);

per = [sort(w,'ascend');wct'];
prb = (wct'/(yl-cpi));

end % function ordin
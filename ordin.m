function [oreg,ospc] = ordin(reg,cpi)
%% ORDIN Ordinal permutation
%
% INPUT:
%       reg: Regressor from time series.
%       cpi: Compression index.
%
% OUTPUT:
%       oreg: Ordinal regressor.
%       opc: Ordinal permutation space, corresponding counts and normalized 
%             probabilities.
%       
%
%


oreg = zeros(size(reg));

yl = length(reg);
m = size(reg,1);

for i = cpi+1:yl
    a = reg(:,i);
    b = sort(a,'ascend');
    
    % Add equivalance condition, secondary precedence of index
    for j = 1:m        
        a(a==b(j)) = j;
    end
        
    
    oreg(:,i) = a;
end

per = zeros(1,yl);

for i = cpi+1:yl
    tmp = 0;
    for j = 1:m       
        tmp = tmp + oreg(j,i)*10^(m-j);
    end
    per(i) = tmp;
end

w = sort(per(:,cpi+1:end),'ascend');
[w,~,ind] = unique(w);
wct = accumarray(ind,1);

ospc = [sort(w,'ascend');wct';wct'/(yl-cpi)];


end % function ordin
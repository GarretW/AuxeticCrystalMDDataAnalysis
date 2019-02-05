<<<<<<< HEAD
function [ordent,wrd] = ordin(reg,cpi,yl)
%% ORDIN Ordinal permutation
%
%
%
%
=======
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
>>>>>>> ac2fc8b2e50027786689841698f000d05b830dd6


regi = zeros(size(reg));

<<<<<<< HEAD
=======
yl = length(reg);
m = size(reg,1);

>>>>>>> ac2fc8b2e50027786689841698f000d05b830dd6
for i = cpi+1:yl
    a = reg(:,i);
    b = sort(a,'ascend');
    
    for j = 1:m
        a(a==b(j)) = j;
    end
    regi(:,i) = a;
end

<<<<<<< HEAD
wrd = zeros(1,yl);
=======
per = zeros(1,yl);
>>>>>>> ac2fc8b2e50027786689841698f000d05b830dd6

for i = cpi+1:yl
    tmp = 0;
    for j = 1:m       
        tmp = tmp + regi(j,i)*10^(m-j);
    end
<<<<<<< HEAD
    wrd(i) = tmp;
end

w = sort(wrd(:,cpi+1:end),'ascend');
[w,~,ind] = unique(w);
wct = accumarray(ind,1);

wrd = [sort(w,'ascend');wct'];
prb = (wct'/(yl-cpi));

ordent = 0;
for i = 1:length(prb)
    ordent = ordent - (prb(i)*log(prb(i)));
end

end
=======
    per(i) = tmp;
end

w = sort(per(:,cpi+1:end),'ascend');
[w,~,ind] = unique(w);
wct = accumarray(ind,1);

per = [sort(w,'ascend');wct'];
prb = (wct'/(yl-cpi));

end % function ordin
>>>>>>> ac2fc8b2e50027786689841698f000d05b830dd6

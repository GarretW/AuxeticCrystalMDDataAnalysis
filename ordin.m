function [ordent,wrd] = ordin(reg,cpi,yl)
%% ORDIN Ordinal permutation
%
%
%
%


regi = zeros(size(reg));

for i = cpi+1:yl
    a = reg(:,i);
    b = sort(a,'ascend');
    
    for j = 1:m
        a(a==b(j)) = j;
    end
    regi(:,i) = a;
end

wrd = zeros(1,yl);

for i = cpi+1:yl
    tmp = 0;
    for j = 1:m       
        tmp = tmp + regi(j,i)*10^(m-j);
    end
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
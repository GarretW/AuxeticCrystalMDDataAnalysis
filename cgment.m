function [ent] = cgment(y,reg,xc,cpi)
%% CGMENT Coarse Grained Marginal Entropy
[~,p] = symbs(y,reg,xc,cpi);

ent = 0;
for i = 1:length(p)
    ent = ent - (p(i)*log(p(i)));
end

end
function [ent] = cgment(y,reg,xc,cpi)
%% CGMENT Coarse Grained Marginal Entropy
% Marginal entropy of a symbolized regressor
%
% INPUT: 
%       y:   Raw time series.
%       reg: Regressor constructed from time series.
%       xc:  Critical point vector for generation of symbols.
%       cpi: Compression index. Excluded values resulting from compression
%            of time series.
% 
% OUTPUT: 
%       ent: Calculated Shannon entropy from resultant symbolization.
%%
[~,p] = symbs(y,reg,xc,cpi);

ent = 0;
for i = 1:length(p)
    ent = ent - (p(i)*log(p(i)));
end

end
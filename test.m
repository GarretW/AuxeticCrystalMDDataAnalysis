clear; close all;

% Data series setting
%   LP: L-Pattern.
%   CM: Cross matrix.

data = 'LP';

if strcmp(data,'CM')
    fid = open(strcat(pwd,'/Wsdat/angdat3377.mat'));
    angs = fid.angdat(2:end,2:end); 
elseif strcmp(data,'LP')
    fid = open(strcat(pwd,'/Wsdat/angdat121322.mat'));
    angs = fid.angdat(2:end,2:end);
end



%% Thresholds and Characteristics

thr = 1e-4;                 % General convergence threshold
r = 12;                     % FNN ratio threshold

%%

% x = 1:10000;
% y = x.^(1/2)-((x./25).^(3/4));
% z = awgn(y,20);
% src = x.^(1/4);

% Data Sets
tgt = angs{1}(3001:8000);
src = angs{2}(3001:8000);

% Target Regressor Characterization
tau = optau(tgt,thr);
m = opdim(tgt,tau,r,thr);
tcpi = m*tau;
tgt_rg = regr(tgt,m,tau,'BP');

% Source Regressor Characterization
sigma = optau(src,thr);
l = opdim(src,tau,r,thr);
scpi = l*sigma;
src_rg = regr(src,l,sigma,'BP');

% 
% if sigma < tau
%     sigma = tau;
% end


% Ordinal Regressor Generation
[tgt_org,tgt_spc] = ordin(tgt_rg,tcpi);
[src_org,src_spc] = ordin(src_rg,scpi);

% Absolute Compression Index and Zero Pad Normalization
 cpi_abs = max(tcpi,scpi); 
src_org(1:cpi_abs) = 0; tgt_org(1:cpi_abs) = 0;

%% Joint Word Distribution

f = factorial(m);
p = perms(1:m);
per = zeros(1,f);
a = per;

% Symbolize Permutations 
for i = 1:f
    tmp = 0;
    for j = 1:m       
        tmp = tmp + p(i,j)*10^(m-j);
    end
    per(i) = tmp;
end
per = fliplr(per);

% for i = 1:f
%     tmp = tgt_org == per(i);
%     a(i) = sum(tmp);
% end


%%

prm_pdf = cell(3,f);

for i = 1:f
    tgt_ind = tgt_org == per(i);    % Index matrix of test permutation in tgt
    
%     if sum(tgt_ind) == 0
%         continue;
%     end
    
    ocr = src_org(tgt_ind);         % Permutations that occurr at same points in source

    [src_prm,~,ind] = unique(ocr);  % Unique permutations in source 
    src_cts = accumarray(ind,1)';   % Counts of each unique 
    
    
    prm_pdf{1,i} = per(i);          % Permutation PDF array
    prm_pdf{2,i} = src_prm;       
    prm_pdf{3,i} = src_cts;

end



%% Regressor Mutual Information Characterization
% 
% tau = optau(y,thr);             % Time lag
% m = opdim(y,tau,r,thr);         % Embedding dimension
% rg = regr(y,m,tau,'BP');        % Optimized regressor
% cpi = m*tau;                    % Compression index

%% Ordinal Permutations

% [org,octs,oprb] = ordin(rg,cpi);


%% Notes

% 10/21: 
%       Pursue Bandt-Pompf method 

% 10/22: 
%   Use FNN regressor vector motif [Y(t-tau),Y(t-tau*2)...,Y(t-(tau*d))] 
%       for embedding dimension optimization.
%   Use BP regressor vector motif [Y(t),Y(t-tau),...,Y(t-(tau*d-1))] for
%       generation of regressor matrix. 

% 10/29:
%   Play with m and tau effect on ordinal entropy
%   End pursuit of curve fitting.





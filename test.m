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

tgt = angs{1}(3001:8000);
src = angs{2}(3001:8000);

tau = optau(tgt,thr);
m = opdim(tgt,tau,r,thr);
cpi = m*tau;

tgt_rg = regr(tgt,m,tau,'BP');
src_rg = regr(src,m,tau,'BP');

[tgt_org,tgt_spc] = ordin(tgt_rg,cpi);
[src_org,src_spc] = ordin(src_rg,cpi);

tgt_ps = pspace(tgt_spc,m);
src_ps = pspace(src_spc,m);

jnt_spc = 

    
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





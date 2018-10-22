clear; close all;

% Data series setting
%   act: Actual, full length MD simulation time series
%   seg: Segment, partition of actual, centrally located 3000 time steps
%   osc: Oscillator, logarithmic oscillating function

set = 'act';

if strcmp(set,'act')
    fid = open(strcat(pwd,'/Wsdat/s10.mat'));
    angs = fid.angs{1};
    y = angs(1,:);
    
elseif strcmp(set,'seg')
    fid = open(strcat(pwd,'/Wsdat/s10.mat'));
    angs = fid.angs{1};
    y = angs(1,5001:8000);
    
elseif strcmp(set,'osc')    
    x = 0.1:.01:6*pi;
    y = log(1/pi*x).*sin(20*x);
    
end

%% Thresholds and Characteristics

yl = length(y);             
thr = 1e-4;                 % General convergence threshold
r = 12;                     % FNN ratio threshold

%% Regressor Mutual Information Characterization

tau = optau(y,thr);         % Time lag
m = opdim(y,tau,r,thr);     % Embedding dimension
reg = regr(y,m,tau);        % Optimized regressor
cpi = m*tau;                % Compression index

%% Ordinal Permutation

[per,prb] = ordin(reg,cpi);
%% Notes

% 10/21: 
%       Pursue Bandt-Pompf method 

% 10/22: 
%   Use FNN regressor vector motif [Y(t-tau),Y(t-tau*2)...,Y(t-(tau*d))] 
%       for embedding dimension optimization.
%   Use BP regressor vector motif [Y(t),Y(t-tau),...,Y(t-(tau*d-1))] for
%       generation of regressor matrix. 
        

% No log
%   Ordinal entropy, across multiple time series. 
%   Possibly abandon symbolization and curve fitting.





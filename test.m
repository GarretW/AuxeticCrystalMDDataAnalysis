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

% Pursue Bandt-Pompf method 
% Ordinal entropy, across multiple time series. 

% Possibly abandon symbolization and curve fitting.





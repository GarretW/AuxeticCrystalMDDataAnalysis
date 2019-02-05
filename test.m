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

<<<<<<< HEAD
%% 
ncp = 30;
it0 = 10000;
trials = 5;
ent = zeros(trials,ncp);

for j = 1:trials
    for i = 1:ncp
        
        e = mcxc(y,reg,i,it0,cpi);
        ent(j,i) = max(e);
        
        clc;
        fprintf('cp: %0.f',i);
    end
    fprintf('\nRun %0.f Done\n',j)
end


%% Curve Fitting Analysis

cval = zeros(trials,ncp);

for j = 1:trials    
    coeffs = zeros(3,ncp);
    [fitc,~] = fit((1:3)',ent(j,1:3)','power2');
    
    for i = 4:ncp            
        coeffs(:,i) = [fitc.a; fitc.b; fitc.c];
        fopt = fitoptions('power2', 'StartPoint', coeffs(:,i));        
        [fitc,~] = fit((1:i)', ent(j,1:i)', 'power2', fopt);

    end
    cval(j,:) = coeffs(3,:);
    
end



%% Plotting Worspace

figure;
for i = 1:trials
    hold on
    plot(cval(i,:));
    
end

figure;
for i = 1:trials
    hold on
    plot(ent(i,:));
    
end

%% Notes

% Search for entropy maxima or plateau across increasing bins at set
% iterations. 

% Power2 analytic solution to brute force?
% Ordinal entropy, across multiple time series. 

=======

[per,prb] = ordin(reg,cpi);
%% Notes

% Pursue Bandt-Pompf method 
% Ordinal entropy, across multiple time series. 

% Possibly abandon symbolization and curve fitting.



>>>>>>> ac2fc8b2e50027786689841698f000d05b830dd6


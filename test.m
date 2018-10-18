clear; close all;

% Data series setting
%   act: Actual, full length MD simulation time series
%   seg: Segment, partition of actual, centrally located 3000 time steps
%   osc: Oscillator, logarithmic oscillating function

set = 'seg';

if strcmp(set,'act')
    load('s10');
    angs = angs{1};
    y = angs(1,:);
    
elseif strcmp(set,'seg')
    load('s10')
    angs = angs{1};
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

%%

ent = zeros(1,50);

for i = 3:50
    
    e = mcxc(y,reg,i,50,cpi);
    ent(i) = max(e);
    
end



%% Curve Fitting Analysis

%fopt = fitoptions('power2','Lower',[-Inf,-Inf,0],'Upper',[Inf,0,Inf]);

% cv = zeros(1,100);
% bv = cv;
% rsq = cv;
% 
% for i = 6:60    
%     [coef,r] = fit((3:i)',max_ent(3:i)','power2');
%     cv(i) = coef.c;
%     rsq(i) = r.rsquare;
%     bv(i) = coef.b;
%     clc;
%     disp(i);
% end

%% Plotting Worspace

% figure
% for i = 1:10 
%     hold on
%     subplot(2,1,1)
%     plot(cval(i,3:end))
%     
%     hold on
%     subplot(2,1,2)
%     plot(diff(cval(i,3:end)))
%      
% end
% 
% hold on 
% subplot(2,1,2)
% %plot(.01*ones(1,mcp-3),'-k');
% hold on
% subplot(2,1,1)
% xlabel('Included critical points')
% ylabel('C coeff')
% title('Maximum entropy fit analysis')
% 
% hold on
% subplot(2,1,2)
% xlabel('Included critical points')
% ylabel('delta C coeff')
% title('Convergence')

%% Notes

% Search for entropy maxima or plateau across increasing bins at set
% iterations. 

% Power2 analytic solution to brute force?
% Ordinal entropy, across multiple time series. 




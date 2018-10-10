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

%% Monty Carlo Method: Max Ent Critical Point Determination

% nb = 4;                         % Number of bins
% ncp = nb+1;                     % Number of critical points
% 
% conv = false;                   % Convergence flag
% max_ent = 0;                    % Maximum entropy preallocation
% max_cp = zeros(1,ncp);
% 
% while conv == false
% 
%         xc = sort(randi(yl,[ncp,1]));
%         xc(1) = 1; xc(end) = yl;
%         tmp_ent = cgment(y,reg,xc,cpi);        
% 
%         if tmp_ent > max_ent
% 
%             if abs(tmp_ent - max_ent) <= .01
%                 conv = true;      
%             end
% 
%             max_ent = tmp_ent;
%             max_cp = xc;            
%         end                    
% end


%%
mci = 5000;             % Monte Carlo iterations
ncp = 3;                % Number of critical points
% ent = zeros(1,mci);   % Entropy vector
% xc = zeros(ncp,mci);  % Critical point solution vector 

max_ent = zeros(3,10);

for k = 1:size(max_ent,1)
    for j = 1:5
        ent = zeros(1,1000*j);
        xc = zeros(ncp,1000*j);
        
        for i = 1:1000*j
            
            tmp_xc = sort(randi(yl,[ncp,1]));
            tmp_xc(1) = 1; tmp_xc(end) = yl;
            ent(i) = cgment(y,reg,tmp_xc,cpi);
            xc(:,i) = tmp_xc;
            
        end
        
        max_ent(k,j) = max(ent);
        
    end
end
%% Plotting Worspace

figure
for i = 1:size(max_ent,1)
    hold on
    plot(max_ent(i,:));
end
hold on
plot(mean(max_ent),'--k','LineWidth',3);
hold off



%% Brute Force Method

for i = 2:yl-1
   %... 
end

%% Genetic Algorithm Method: Max Ent Critical Point Determination

% inA = diag(ones(ncp,1)) + diag(ones(ncp-1,1)*-1,1);
% inA(end,1) = -1;
% inB = zeros(ncp,1);
%
% eqA = zeros(ncp);
% eqA(1) = 1; eqA(end) = 1;
% eqB = zeros(ncp,1);
% eqB(1) = min(y); eqB(end) = max(y);
%
% bndu = ones(1,ncp)*max(y);         % Upper and lower boundary conditions
% bndl = ones(1,ncp)*min(y);
%
% opfn = @(u) -cgment(reg,u,cpi);
% oxc = ga(tst,ncp,idA,idB,[],[],[],ubnd);


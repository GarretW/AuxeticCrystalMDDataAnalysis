clear; close all;

% Data series setting
%   act: Actual, full length MD simulation time series
%   seg: Segment, partition of actual, centrally located 3000 time steps
%   osc: Oscillator, logarithmic oscillating function

set = 'act';

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
mci = 100;             % Monte Carlo iterations
ncp = 3;                % Number of critical points
ent = zeros(1,mci);     % Entropy vector
xc = zeros(ncp,mci);    % Critical point solution vector 

max_ent = zeros(1,10);
hld = zeros(10);
%max_xc = zeros(10);
for k = 1:20
    for j = 3:10                
        
        for i = 1:mci*k
            
            tmp_xc = sort(randi(yl,[ncp,1]));
            tmp_xc(1) = 1; tmp_xc(end) = yl;
            ent(i) = cgment(y,reg,tmp_xc,cpi);
            xc(:,i) = tmp_xc;
            
        end               
        max_ent(j) = max(ent);
        %a = xc(max(ent) == ent);
        %max_xc(1:j,j) = a(1);
    end
    hld(:,j) = max_ent;
end

%% Plotting Worspace

% figure
% for i = 1:size(max_ent,1)
%     hold on
%     plot(max_ent(i,:));
% end
%
% hold on
% plot(mean(max_ent),'--k','LineWidth',3);
% hold off

%% Brute Force Method
% bf_xc = [1, 0, yl];
% bf_ent = zeros(1,yl-2);
% 
% for i = 2:yl-1
%     bf_xc(2) = i;
%     bf_ent(i-1) = cgment(y,reg,bf_xc,cpi);
% end

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


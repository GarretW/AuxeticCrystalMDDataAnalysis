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

%% Ordinal permutation
regi = zeros(size(reg));

for i = cpi+1:yl
    a = reg(:,i);
    b = sort(a,'ascend');
    
    for j = 1:m
        a(a==b(j)) = j;
    end
    regi(:,i) = a;
end

wrd = zeros(1,yl);

for i = cpi+1:yl
    tmp = 0;
    for j = 1:m       
        tmp = tmp + regi(j,i)*10^(m-j);
    end
    wrd(i) = tmp;
end

w = sort(wrd(:,cpi+1:end),'ascend');
[w,~,ind] = unique(w);
wct = accumarray(ind,1);

wrd = [sort(w,'ascend');wct'];
prb = (wct'/(yl-cpi));

ent = 0;
for i = 1:length(prb)
    ent = ent - (prb(i)*log(prb(i)));
end


%%
% mci = 5;                                                        % Monte Carlo iterations
% ncp = 3;                                                        % Number of critical points
% % ent = zeros(1,mci);                                           % Entropy vector
% xc = zeros(ncp,mci);                                            % Critical point solution vector 
% 
% max_ent = zeros(1,ncp);                                         % Maxima of MC entropy for given critical points
% 
% mcp = 150;
% cval = zeros(10,mcp);                                           % Target fit coefficients 
% 
% for k = 1:10                                                    % Test multiplier    
%     for j = 3:mcp                                               % Crit point count
%         ent = zeros(1,mci);
%         
%         for i = 1:mci*k                                         % MC search
%             
%             tmp_xc = sort(randi(yl,[j,1]));                     % Generate j random crit points
%             tmp_xc(1) = 1; tmp_xc(end) = yl;
%             ent(i) = cgment(y,reg,tmp_xc,cpi);                  % Calculate entropy for solution and store
%             % xc(:,i) = tmp_xc;
%             
%         end
%         
%         max_ent(j) = max(ent);                                  % Store maximum entropy from best solution of j crit points
%         % a = xc(max(ent) == ent);                              % Store maximum entropy critical point index solutions
%         % max_xc(1:j,j) = a(1);
%         
%         clc;
%         fprintf('cpn: %0.f ',j);
%                 
%     end
%     fprintf('\nDone: %0.f\n', k);
%     
%     for o = 6:mcp
%         tmp_c = coeffvalues(fit((3:o)',max_ent(3:o)','poly2'));
%         cval(k,o) = tmp_c(3);
%         
%     end
%     
% end


%% Brute Force Method
% bf_xc = [1, 0, yl];
% bf_ent = zeros(1,yl-2);
% 
% for i = 2:yl-1
%     bf_xc(2) = i;
%     bf_ent(i-1) = cgment(y,reg,bf_xc,cpi);
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

% Delta average across increasing cp
% Variances across increasing cp
% Behaviour at low number of iterations

% Search for entropy maxima or plateau across increasing bins at set
% iterations. 

%Curve fitting power 2 constant convergence? 

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


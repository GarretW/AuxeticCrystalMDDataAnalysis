clear; close all;

load('s10');
angs = angs{1};
ns = size(angs,1);


%%

%y = angs(1,:);
x = 0.1:.01:6*pi;
y = log(1/pi*x).*sin(20*x);

yl = length(y);             

tol = 1e-4;                 % General convergence tolerance
r = 12;                     % FNN threshold

tau = optau(y,tol);         % Time lag
m = opdim(y,tau,r,tol);     % Embedding dimension
reg = regr(y,m,tau);        % Optimized regressor

cpi = m*tau;                % Compression index

%% Monty Carlo Method: Max Ent Critical Point Determination

nb = 4;                         % Number of bins
ncp = nb+1;                     % Number of critical points

conv = false;                   % Convergence flag
max_ent = 0;                    % Maximum entropy preallocation
max_cp = zeros(1,ncp);

while conv == false

        xc = sort(randi(yl,[ncp,1]));
        xc(1) = 1; xc(end) = yl;
        tmp_ent = cgment(y,reg,xc,cpi);        

        if tmp_ent > max_ent
            
            if abs(tmp_ent - max_ent) <= .01
                conv = true;      
            end
            
            max_ent = tmp_ent;
            max_cp = xc;            
        end                    
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

% bndu = ones(1,ncp)*max(y);      % Upper and lower boundary conditions
% bndl = ones(1,ncp)*min(y);

% opfn = @(u) -cgment(reg,u,cpi);
% oxc = ga(tst,ncp,idA,idB,[],[],[],ubnd);


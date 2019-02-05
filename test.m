clear; close all;

%% Raw Data 
% Data series setting
%   Knight: Knight pattern.
%   Cross: Cross matrix.

% RESTRUCTURE FOR FULL DATA SET
data = 'Knight';

if strcmp(data,'Cross')
    fid = open(strcat(pwd,'/Wsdat/angdat3377.mat'));
    angs = fid.angdat(2:end,2:end); 
elseif strcmp(data,'Knight') 
    fid = open(strcat(pwd,'/Wsdat/angdat121322.mat'));
    angs = fid.angdat(2:end,2:end);
elseif strcmp(data,'s10')
    fid = open(strcat(pwd,'/Wsdat/s10.mat'));
    angs = fid.angs{1};
end

%% Data Preprocessing

tgt = angs{3}; %(3001:8000);
src = angs{4}; %(3001:8000);

a = (.001*pi:.001*pi:4*pi);
b = ones(1,4000);

% tgt = awgn(sin(a),45);
% src = awgn(b,45);

%% Thresholds and Characteristics

disp('TC');

thr = 1e-4;                 % General convergence threshold
r = 12;                     % FNN ratio threshold
nt = length(a);             % Number of data points

disp('done');

% te_v = zeros(1,25);
% te_sd = zeros(1,25);

% parfor i = 1:25

tnsf = zeros(1,4);

for i = 1:4
%% Shuffling 

% if i == 2
% tgt = tgt(randperm(nt));
% src = src(randperm(nt));

tgt = awgn(sin(a),60);
src = awgn(b,60);

disp(i);
plot(tgt);
hold on
plot(src);
%pause;
hold off
%close all
%% Regressor Characterization

disp('Reg');

% Target History
tauh = optau(tgt,thr);
mh = opdim(tgt,tauh,r,thr);
cpih = mh*tauh;
rgh = regr(tgt,mh,tauh,'FNN');      % History Regressor

% Target Present
taup = tauh;
mp = mh;
cpip = (mp+1)*taup;
rgp = regr(tgt,mp,tauh,'BP');       % Present Regressor

% Source 
taus = optau(src,thr);
ms = opdim(src,taus,r,thr);
cpis = ms*taus;
rgs = regr(src,ms,taus,'FNN');      % Target Regressor



%% Regressor Symbolization 

disp('Symb');

[orgs,prbs] = ordin(rgs,cpis);
[orgh,prbh] = ordin(rgh,cpih);
[orgp,prbp] = ordin(rgp,cpip);

cfgs = prbs(1,:);
cfgh = prbh(1,:);
cfgp = prbp(1,:);

disp('done');

%% Ordinal Entropy Calculation

disp('Ord Ent');

% Marginal Entropies
e_h = genent(prbh(3,:));
e_p = genent(prbp(3,:));
e_s = genent(prbs(3,:));

% Binary Entropies
be_ph = binent([orgp;orgh],{cfgp,cfgh},max([cpip,cpih]));
be_sh = binent([orgs;orgh],{cfgs,cfgh},max([cpis,cpih]));
% be_ps = binent([orgp;orgs],{cfgp,cfgs},max([cpip,cpis]));

% Ternary Entropies
te_shp = ternent([orgs;orgh;orgp],{cfgs,cfgh,cfgp},max([cpis,cpih,cpip]));

% Mutual Information
%mi = e_s + e_p - be_ps;

% Transfer Entropy
tnsf(i) = be_ph + be_sh - te_shp - e_h; 


%     if i == 1
%         TRANSFER_ENTROPY = tnsf;
%     elseif i == 2
%         TRANSFER_ENTROPY_SHUFFLED = tnsf;
%     end
% te_v(i) = transf_ent;
% te_sd(i) = std(te_v);
% disp(i);
% end

disp('done');
end


disp('complete');
plot(tnsf);


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

% 11/26
%   Work in m+1 regressors for present conditioning
%   Implement source shuffling baseline
%   Research partial transfer entropy
%   Begin architecture for analysis of all simulations
% Addendum
%   Compare to nonlinear tools
%   Benchmarking with nonlinearity and independence
%   Independent and deterministic limits

% 1/25
%   Find convergenge of shuffled transfer entropy sdev
%   Directionality coefficient normalized by H(Xp|Xh)
%   Implement parallel computation
%   Determine transfer entropy symmetry or inversion from target and source
%   Investigate the nessicary degree of conditioning for other influencing variables.
%   Investigate trends in spurious biases: Location of squares in lattice, distance of
%       variable pairs, inversion of target and source, etc...



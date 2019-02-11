clear; close all;

%% Raw Data 
% Data series setting

fid = open(strcat(pwd,'/Wsdat/angs4_875_2.mat'));
angs = fid.angt;
s = 4;
tm = zeros(s^2);
randt = zeros(1,10);
for j = 1:10
%% 
disp(j);

%% Data Preprocessing

tgt = angs(3,3001:8000); %(3001:8000);
src = angs(4,3001:8000); %(3001:8000);
% a = (.001*pi:.001*pi:4*pi);
% b = ones(1,4000);
% tgt = awgn(sin(a),45);
% src = awgn(b,45);

%% Thresholds and Characteristics

% disp('TC');

thr = 1e-4;                 % General convergence threshold
r = 12;                     % FNN ratio threshold
nt = length(tgt);             % Number of data points

%% Shuffling 

tgt = tgt(randperm(nt));
src = src(randperm(nt));


%% Regressor Characterization


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

[orgs,prbs] = ordin(rgs,cpis);
[orgh,prbh] = ordin(rgh,cpih);
[orgp,prbp] = ordin(rgp,cpip);

cfgs = prbs(1,:);
cfgh = prbh(1,:);
cfgp = prbp(1,:);

%%
org = orgh(cpih+1:end);
[states1,~,c] = unique(org);
cnt = accumarray(c,1);
prob = cnt/(nt-cpih);
menh = 0;

for i = 1:length(prob)
    menh = menh - prob(i)*log(prob(i));
end
%%
max_cpi = max(cpis,cpih);
org2 = [orgs;orgh]';
org2 = org2(max_cpi+1:end,:);
[states21,~,c] = unique(org2,'rows');
cnt = accumarray(c,1);

prob = cnt/(nt-max_cpi);
bensh = 0;
for i = 1:length(prob)
    bensh = bensh - prob(i)*log(prob(i));
end

%%
max_cpi = max(cpip,cpih);
org2 = [orgp;orgh]';
org2 = org2(max_cpi+1:end,:);
[states22,~,c] = unique(org2,'rows');
cnt = accumarray(c,1);

prob = cnt/(nt-max_cpi);
benph = 0;
for i = 1:length(prob)
    benph = benph - prob(i)*log(prob(i));
end


%%
max_cpi = max([cpis,cpih,cpip]);
org3 = [orgs;orgh;orgp]';
org3 = org3(max_cpi+1:end,:);
[states3,~,c] = unique(org3,'rows');

cnt = accumarray(c,1);
prob = cnt/(nt-max_cpi);
ten = 0;
for i = 1:length(prob)
    ten = ten - prob(i)*log(prob(i));
end

%%
transfer = bensh + benph - ten - menh;
randt(j) = transfer;
end
%% Ordinal Entropy Calculation

% % Marginal Entropies
% e_h = genent(prbh(3,:));
% e_p = genent(prbp(3,:));
% e_s = genent(prbs(3,:));
% 
% % Binary Entropies
% be_ph = binent([orgp;orgh],cfgp,max([cpip,cpih]));
% be_sh = binent([orgs;orgh],cfgs,max([cpis,cpih]));
% 
% % Ternary Entropies
% te_shp = ternent([orgs;orgh;orgp],cfgs,max([cpis,cpih,cpip]));
% 
% % Transfer Entropy
% tnsf = be_ph + be_sh - te_shp - e_h; 
% 
% 
% disp('complete');

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



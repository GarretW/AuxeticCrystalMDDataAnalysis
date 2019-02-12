clear; close all;

%% Raw Data 
% Data series setting

fid = open(strcat(pwd,'/Wsdat/angs4_875_2.mat'));
angs = fid.angt;
s = 4;
%tm = zeros(s^2);    % Transfer Matrix
sv = zeros(1,100);  % Shuffle Vector
%sm = zeros(s^2);    % Shuffle Matrix
%%

%for i = 1:4
%    for j = 1:4
%% Data Preprocessing 

%disp(i);
%disp(j);

%tgt = angs(i,1:5000);  
%src = angs(j,1:5000); 
x = 0:0.001*pi:2*pi-0.001*pi;
tgt = sin(x);
src = 2*sin(x) + pi/16;
%% Thresholds and Characteristics

thr = 1e-4;                 % General convergence threshold
r = 12;                     % FNN ratio threshold
nt = length(tgt);             % Number of data points

%% Shuffling 

    for k = 1:101
        disp(k);
shuffle = 'on';

if k == 1
    shuffle = 'off';
end
    
switch shuffle
    case 'on'
        tgt = tgt(randperm(nt));
        src = src(randperm(nt));
end
       

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

[orgs,~] = ordin(rgs,cpis);
[orgh,~] = ordin(rgh,cpih);
[orgp,~] = ordin(rgp,cpip);

%% Entropy Calculation

uenh = uni(orgh,cpih);
bensh = bin([orgs;orgh],max(cpis,cpih));
benph = bin([orgp;orgh],max(cpip,cpih));
ten = tern([orgs;orgh;orgp],max([cpis,cpih,cpip]));

transfer = bensh + benph - ten - uenh;
transfer_norm = transfer / benph;

if k == 1
%tm(i,j) = transfer_norm;
a = transfer_norm;
else 
    sv(k-1) = transfer_norm;
end


    end
    
    %sm(i,j) = mean(sv);
    b = mean(sv);
    
    %end
%end
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



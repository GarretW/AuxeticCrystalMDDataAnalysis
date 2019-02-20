function [transfer, transfer_norm] = trans(tgt,src,thr,r)
%% TRANS Transfer Entropy Calculation 

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


end
function ent = uni(org,cpi)
%% UNITARY ENTROPY

org = org(cpi+1:end)';
nt = length(org);

[~,~,c] = unique(org);
cnt = accumarray(c,1);
prob = cnt/(nt);

ent = 0;
for i = 1:length(prob)
    ent = ent - prob(i)*log(prob(i));
end
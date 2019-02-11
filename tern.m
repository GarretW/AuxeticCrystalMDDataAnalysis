function ten = tern(org3,max_cpi)
%% TERNARY ENTROPY 

org3 = org3(:,max_cpi+1:end)';
nt = length(org3);

[~,~,c] = unique(org3,'rows');
cnt = accumarray(c,1);
prob = cnt/(nt);

ten = 0;
for i = 1:length(prob)
    ten = ten - prob(i)*log(prob(i));
end

end
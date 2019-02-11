function ben = bin(org2,max_cpi)
%% BINARY ENTROPY

org2 = org2(:,max_cpi+1:end)';
nt = length(org2);

[~,~,c] = unique(org2,'rows');
cnt = accumarray(c,1);
prob = cnt/(nt);

ben = 0;
for i = 1:length(prob)
    ben = ben - prob(i)*log(prob(i));
end

end
function ent = genent(prb)
%% GENENT General Entropy Calculation
% Calculation of entropy from an input set of normalized probabilities

ent = 0;

for i = 1:length(prb)
    ent = ent - (prb * log(prb));
end


end % function genent
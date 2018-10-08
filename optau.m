function tau = optau(ts,tol)
%% FMIM First MI Minima
% Calculates the first local minima of the auto mutual information of a time
% series 

mfound = false;
i = 1;
tau = 0;
seq = zeros(1,3);

while (mfound == false) && (i <= length(ts/4))
    
    [tst,tsl] = lag(ts,i);
    m_ent = mglent(tst,tol);
    j_ent = jntent(tst,tsl,tol);
    
    seq(end-2) = seq(end-1);
    seq(end-1) = seq(end);
    seq(end) = 2*m_ent - j_ent;
    
    dseq = diff(seq);
    
    if dseq(1) < 0 && dseq(2) > 0
        mfound = true;
        tau = i-1;
    end
    
    i = i + 1;
    
end

if i >= length(ts)
    disp('Tau exceeded 1/4 total time series length');
end

end % function fmim

function [y,yl] = lag(y,tau)
%% LAG Lagged Time Series Pair
% Returns lagged time series and trimmed length array corresponding to a lag size tau.. 

yl = y(tau+1:end);
y = y(1:end-tau);

end % function lag



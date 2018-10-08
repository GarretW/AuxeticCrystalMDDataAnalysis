function [ef] = mglent(ts,tol)
%% MGLENT Marginal Entropy Estimator
%Calculates the approximate shannon entropy of a given time series through
%histogram binning. Entropy returned is yielded through maximum convergence
%across increasing bin counts.
%INPUT:
%       ts: Time series of interest
%       tol: Tolerance for determination of convergence
%OUTPUT
%       ef: Maximized estimated entropy

ediff = 2*tol;
ei = 0;
b = 2;

while ediff > tol
    
    % Generate probability normalized histogram PDF with increasing bin
    % count
    [n] = histcounts(ts,b,'Normalization','probability');
    
    ef = 0;    
    n = n(n ~= 0);
    
    % Entropy calculation from sum of probability bins 
    for i = 1:length(n)
        ef = ef - n(i)*log(n(i));
    end
    
    % Calculated change in entropy from previous binned estimator.
    ediff = abs(ef - ei);
    ei = ef;
    b = b + 1;
    
end

end







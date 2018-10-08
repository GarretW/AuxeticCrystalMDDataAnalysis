function [ef] = jntent(ts1,ts2,tol)
%% JNTENT Joint Entropy
%Calculates the approximate joint shannon entropy from two given time series through
%histogram binning. Entropy returned is yielded through maximum convergence
%across decreasing bin dimensions.

ediff = 2*tol;
b = 2;
ei = 0;

while ediff > tol

    [n] = histcounts2(ts1,ts2,b,'Normalization','probability');
    ef = 0;

    n = n(n ~= 0);

    for i = 1:length(n)
        ef = ef - n(i)*log(n(i));
    end
        
    ediff = abs(ef - ei);
    ei = ef;
    b = b + 1;
      
end

end
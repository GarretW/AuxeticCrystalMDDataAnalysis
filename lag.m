function [y,yl] = lag(y,tau)
%% LAG Lagged Time Series Pair
% Returns lagged time series and trimmed length array corresponding to a lag size tau.. 

yl = y(tau+1:end);
y = y(1:end-tau);

end % function lag


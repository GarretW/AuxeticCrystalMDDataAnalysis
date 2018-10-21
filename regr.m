function [reg] = regr(y,m,tau)
%% REGR Regressor Builder
%   Builds regressor components for a given time series
%   pair. regressors are generated for each step. Output of function 
%   is the components of the regressor:
%       I(k) 
%   for all time steps in the data.
%INPUT: 
%       y: Time series raw data.
%       m: Specified embedding dimension.
%       tau: Optimized time delay for time series input.
%OUTPUT:
%       reg: Regressor vectors for all possible k

nt = length(y);

% Regressor Component Preallocation
reg = zeros(m,nt);

% Regressor extraction from raw data.
% For regressor lags which exceede current time step in data, nonexistant
% points are set to zero.

for i = (m*tau)+1:nt      
    reg(:,i) = y(i-tau:-tau:i-(m*tau));    
end

end

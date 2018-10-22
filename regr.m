function [reg] = regr(y,m,tau,set)
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
%       set: Regressor motif setting
%           OPTIONS: 'BP' - Bandt-Pompf motif with regressor vectors
%                     headed with unlagged value.
%                     >>[Y(t),Y(t-tau),...,Y(t-(tau*d-1))]<<
%                     'FNN' - False Nearest Neighbors motif with regressor
%                     vectors headed with first lagged value.
%                     >>[Y(t-tau),Y(t-tau*2)...,Y(t-(tau*d))]<<
%OUTPUT:
%       reg: Regressor vectors for all possible k

nt = length(y);

% Regressor Component Preallocation
reg = zeros(m,nt);

% Regressor extraction from raw data.
% For regressor lags which exceede current time step in data, nonexistant
% points are set to zero.

if strcmp(set,'FNN')
    for i = (m*tau)+1:nt      
        reg(:,i) = y(i-tau:-tau:i-(m*tau));    
    end
    
elseif strcmp(set,'BP')
    for i = (m*tau)+1:nt          
        reg(:,i) = y(i:-tau:i-(m*tau-1));    
    end
    
end

end

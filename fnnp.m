function [fnn] = fnnp(ts,m,tau,r)
%% FNNP False Nearest Neighbors Percentage
%   Calculates the percentage of neighbors which are determined to be false
%   by the euclidean norm ratio test.
%INPUT:
%       y: Output time series raw data.
%       regr: Regressor vectors.
%       m: Regressor embedding dimension.
%       tau: Regressor time delay.
%       r: FNN threshold.
%OUTPUT:
%       fnn: Percentage of neighbors which fail the fnn ratio criteria.
%       d: Nearest euclidean neighbor and corresponding norm.

nt = length(ts);

% Builds regressor from time series, given embed dim and time lag.
reg = regr(ts,m,tau,'FNN');                         

% Index of minimum regressor norm neighbor and value of minimum norm.
d = ones(2,nt);                                     

% Number of points with false neighbors.
nf = 0;                                             

% Logical vector to exclude evaluation of identity and OB regressors 
s =  logical([zeros(1,m*tau), ones(1,nt-m*tau)]);   



if ismember(NaN(1),reg)
    disp('Series contains invalid values');
    quit;
end
    
for k = m*tau:nt
    
    s(k) = 0;
    
    % Regressor norm evaluation
    jreg = reg - reg(:,k);
    nrm = sqrt(dot(jreg,jreg));              
    
    % Value and index of norm minima
    d(1,k) = min(nrm(s));
    a = find(nrm == d(1,k));
    
    if numel(a) > 1
        a = a(1);
        %disp('Multiple Pts Detected');              
    end
    
    d(2,k) = a(1); 
    
    ydiff = abs(ts(k)-ts(a));
    thresh = ydiff / d(1,k);
    
    if thresh > r
        nf = nf+1;
    end    
    
    %thr(k) = thresh;   
    s(k) = 1;
    
end

fnn = (nf/nt)*100;

%fprintf('m: %d \nRT: %.04f \nFNNP: %.04f \n\n',m,ti,fnn);

end



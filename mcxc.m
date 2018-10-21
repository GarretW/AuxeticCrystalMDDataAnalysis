function [ent,xc] = mcxc(y,reg,ncp,mci,cpi)
%% MCXC Monte Carlo Critical Points
%
%INPUT: 
%       y: Input data
%       ncp: Number of critical points, non-inclusive of boundaries.
%       mci: Monte Carlo iterations
%
%OUTPUT:
%       ent: Maximum estimated entropy
%       xc: Critical point soultion
%%
ncp = ncp+2;
ent = zeros(1,mci);                                  % Entropy vector
xc = zeros(ncp,mci);                               % Critical point solution vector, 
yl = length(y);


for i = 1:mci                                        % MC search
    
    tmp_xc = [1, sort(randi([1 yl],[ncp-2,1]))', yl];   % Generate random crit points with boundary conditions
    ent(i) = cgment(y,reg,tmp_xc,cpi);               % Calculate entropy for solution and store        
    xc(:,i) = tmp_xc;                                % Record test critical point solution

end


end % function mcxc
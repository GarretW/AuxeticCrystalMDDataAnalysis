function [ent,xc] = mcxc(y,reg,ncp,mci,cpi)
%% MCXC Monte Carlo Critical Points
%
%INPUT: 
%       y: Input data
%       ncp: Number of critical points
%       mci: Monte Carlo iterations
%
%OUTPUT:
%
%
%%

ent = zeros(1,mci);                                  % Entropy vector
xc = zeros(ncp,mci);                                 % Critical point solution vector 
yl = length(y);


for i = 1:mci                                        % MC search
    
    tmp_xc = sort(randi([1 yl],[ncp,1]));                % Generate random crit points
    tmp_xc(1) = 1; tmp_xc(end) = yl;                 % Boundary conditions
    ent(i) = cgment(y,reg,tmp_xc,cpi);               % Calculate entropy for solution and store        
    xc(:,i) = tmp_xc;                                % Record test critical point solution

end


end % function mcxc
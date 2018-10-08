clear; close all;

load('s10');
angs = angs{1};
ns = size(angs,1);


%%

%y = angs(1,:);
x = 0.1:.01:6*pi;
y = log(1/pi*x).*sin(20*x);

yl = length(y);             

tol = 1e-4;                 % General convergence tolerance
r = 12;                     % FNN threshold

tau = optau(y,tol);         % Time lag
m = opdim(y,tau,r,tol);     % Embedding dimension
reg = regr(y,m,tau);        % Optimized regressor

cpi = m*tau;                % Compression index

%% 

nb = 4;                         % Number of bins
ncp = nb+1;                     % Number of critical points

% sym = symbs(reg,xc,cpi);

nb = 1;
ent = 0;
ent0 = 1;
con = false;

while con == false
    nb = nb+1;
    c = kmeans(reg',nb);
    b = sort(c,'ascend');
    [~,~,ind] = unique(b);
    cnt = accumarray(ind,1);
    
    for j = 1:nb
        ent = ent - ((cnt(j)/yl) * log(cnt(j)/yl));
    end
    
    if abs(ent-ent0) <= tol
        con = true;
    end
    
    ent0 = ent;
    
end


%%
% conv = false;
% ent = 0;
% while conv == false
% 
%         xc = sort(randi(yl,[ncp,1]));
%         xc(1) = 1; xc(end) = yl;
%         tmp_ent = cgment(y,reg,xc,cpi);        
% 
%         if tmp_ent > ent
%             
%             if abs(tmp_ent - ent) <= .01
%                 conv = true;      
%             end
%             
%             ent = tmp_ent;
%             cmax = xc;            
%         end         
%             
% end

%%
% for i = 1:5000   
%     for j = 4:8
%
%         ncp = j;
%         xc = sort(randi(yl,[ncp,1]));
%         xc(1) = 1; xc(end) = yl;
%         ent(j-3,i) = cgment(y,reg,xc,cpi);         
%          
%         if ent(j-3,i) > tmp_ent
%             tmp_ent = ent(j-3,i);
%             cmax(j-3,1:length(xc)) = xc;
%
%         end                 
%     end
% end
%%
% figure
% for i = 1:10   
%     plot(ent(i,:));
%     hold on
% end
% legend('show');
% hold off
%%







% inA = diag(ones(ncp,1)) + diag(ones(ncp-1,1)*-1,1);
% inA(end,1) = -1;
% inB = zeros(ncp,1);
% 
% eqA = zeros(ncp);
% eqA(1) = 1; eqA(end) = 1;
% eqB = zeros(ncp,1);
% eqB(1) = min(y); eqB(end) = max(y);

% bndu = ones(1,ncp)*max(y);      % Upper and lower boundary conditions
% bndl = ones(1,ncp)*min(y);

% opfn = @(u) -cgment(reg,u,cpi);
% oxc = ga(tst,ncp,idA,idB,[],[],[],ubnd);


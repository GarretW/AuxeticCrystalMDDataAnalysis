function bne = binent(org2,cfg2,max_cpi)
%% Binary Joint Ent

cga = cfg2{1}; cfgb = cfg2{2};
orga = org2(1,:); orgb = org2(2,:);

nterms = 2*(length(orga)-max_cpi);

bne = 0;


for i = 1:length(cga)
    confa = cga(1,i);
    confai = orga == confa;
    bc = orgb(confai);
    bcu = unique(bc);
    
    % h = zeros(2,length(hcu));
    
    for j = 1:length(bcu)        
        confb = bcu(j);
        confbi = orgb == confb;
        
        % point_config = [confs; confh];
        
        confcnt = sum(and(confai,confbi));
        
        % h(1,j) = confh;
        % h(2,j) = confcnt;
        % h(3,j) = confcnt/nterms;
        
        bne = bne - ((confcnt/nterms)*log(confcnt/nterms));
    end


end  



end
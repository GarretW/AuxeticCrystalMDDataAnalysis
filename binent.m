function bne = binent(org2,cfg2,max_cpi)
%% Binary Joint Ent

cfga = cfg2(1,:); 
orga = org2(1,:); orgb = org2(2,:);
nterms = 2*(length(orga)-max_cpi);

bne = 0;

for i = 1:length(cfga)
    confa = cfga(1,i);
    confai = orga == confa;
    bc = orgb(confai);
    bcu = unique(bc);    
    
    for j = 1:length(bcu)        
        confb = bcu(j);
        confbi = orgb == confb;        
        confcnt = sum(and(confai,confbi));
        
        bne = bne - ((confcnt/nterms)*log(confcnt/nterms));
    end

end  

end
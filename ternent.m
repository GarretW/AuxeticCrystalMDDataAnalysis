function tne = ternent(org3,cfg3,max_cpi)

% Ternary Joint Entropy


cfga = cfg3(1,:);
orga = org3(1,:); orgb = org3(2,:); orgc = org3(3,:);

nterms = 3*(length(orga)-max_cpi);

tne = 0;

%s = cell(2,length(prbs));

for i = 1:length(cfga)
    confa = cfga(1,i);
    confai = orga == confa;
    ac = orgb(confai);
    acu = unique(ac);   
    
    for j = 1:length(acu)
        confb = acu(j);
        confbi = orgb == confb;
        bc = orgc(confbi);
        bcu = unique(bc);
        
        for k = 1:length(bcu)
            confc = bcu(k);
            confci = orgc == confc;            
            confcnt = sum(and(and(confai,confbi),confci));            
            
            if confcnt == 0 
                break;    
            end
            
            tne = tne - ((confcnt/nterms)*log(confcnt/nterms));
        end
                
    end    
    
end

end

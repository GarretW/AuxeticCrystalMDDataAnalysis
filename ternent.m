function tne = ternent(org3,cfg3,max_cpi)

% Ternary Joint Entropy


cfga = cfg3{1}; cfgb = cfg3{2}; cfgc = cfg3{3};
orga = org3(1,:); orgb = org3(2,:); orgc = org3(3,:);

nterms = 3*(length(orga)-max_cpi);

tne = 0;

%s = cell(2,length(prbs));

for i = 1:length(cfga)
    confa = cfga(1,i);
    confai = orga == confa;
    ac = orgb(confai);
    acu = unique(ac);
    
    %h = cell(4,length(hcu));
    
    for j = 1:length(acu)
        confb = acu(j);
        confbi = orgb == confb;
        bc = orgc(confbi);
        bcu = unique(bc);
        
        %p = zeros(2,length(pcu));
        
        for k = 1:length(bcu)
            confc = bcu(k);
            confci = orgc == confc;            
            confcnt = sum(and(and(confai,confbi),confci));

            %point_config = [confs, confh, confp];
            
            if confcnt == 0 
                break;    
            end
            
            %p(1,k) = confp;
            %p(2,k) = confcnt;            
            
            tne = tne - ((confcnt/nterms)*log(confcnt/nterms));
        end
        
        %h(:,j) = {confh; p(1,:); p(2,:); p(2,:)/nterms};                          
    end
    
    %s(:,i) = {confp; h};
end


end

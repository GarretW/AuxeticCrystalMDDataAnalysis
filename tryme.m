clear;  
trials = 20;

success = 0;

for i = 1:trials
    a = randn(1,1);
    
    if a>0.75
        success = success + 1;
    end
end

        
function dim = opdim(ts,tau,r,etol)
%% OPDIM Optimal Embedding Dimension
% Determines optimal embedding dimension using an entropy optimized time 
% lag and method of false nearest neighbors.

conv = false;
fn = zeros(1,3);
m = 2;
dim = 0;

while conv == false    
    
    fn(end-2) = fn(end-1);
    fn(end-1) = fn(end);
    fn(end) = fnnp(ts,m,tau,r); 
    di = abs(diff(fn));
    
    if (di(1) <= etol && di(2) <= etol) && m > 3
        conv = true;
        dim = m-2;
    end
    
    m = m+1;
    
end

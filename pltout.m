clear; close all;
a = strcat(pwd,'/Wsdat/coeff.mat');
b = strcat(pwd,'/Wsdat/entropyfull.mat');
c = open(a);
d = open(b);

cval = c.cval;
ent = d.ent;

t = size(cval,1);

figure;
for i = 1:t
    hold on
    plot(cval(i,:));
    
end
%%
t=5;
figure;
for i = 1:t
    hold on
    plot(ent(i,:));
    
end

clear all
%axis
x = linspace(-10,10,1024);

c1 = [1 0.2 0];
c2 = [0 0 1];
r = linspace(c1(1),c2(1),5)';
g = linspace(c1(2),c2(2),5)';
b = linspace(c1(3),c2(3),5)';
cmap = [r,g,b];
figure(1)
clf
for ii=1:5
    tmp = besselj(ii-1,x);
    hold on
    a=plot(x,tmp);
    a.LineWidth = 1.75;
    a.Color = cmap(ii,:);
end
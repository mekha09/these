xaxis = linspace(-15,15,512);
V0 = -1./abs(xaxis);

figure(1)
clf
plot(xaxis,V0)
ylim([-0.9 0.2]);
hold on
plot(xaxis,-0.58.*ones(size(xaxis)),'--')

V1 = V0 + 0.04.*xaxis;
plot(xaxis,V1)

V2 = V0 + (0.58/2).^2.*xaxis;
plot(xaxis,V2)
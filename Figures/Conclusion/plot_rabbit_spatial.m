taxis = linspace(-4,4,512).*1e-15;
chirp = 103e-18;
q = 12:2:18;
shift = 1;
phase = [1 0 -0.5 2];

figure(1)
clf
hold on
for ii=1:length(q)
    lambda = 800e-9./q(ii);
    omega = 2*pi*3e8/lambda;
osc = cos(taxis.*2*pi./(1.33.*1e-15)+chirp.*omega+phase(ii))+shift.*ii;
plot(taxis,osc)
a=gca;
a.YTickLabel = {};
a.YTick = [];
end
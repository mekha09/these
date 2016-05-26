file = importdata('reflectivity.txt');
e = file.data(:,1)./1.55;
r = file.data(:,2);

figure(1)
clf
plot(e,r)

ylim([0 1]);
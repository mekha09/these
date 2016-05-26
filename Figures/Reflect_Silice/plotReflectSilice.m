tmp = [0.39 0.52 0.48 0.645 0.5 0.54 0.27];
tmp = sqrt(tmp);
hh = 9:2:21;

figure(1)
clf
plot(hh,tmp*100,'-o')

ref = importdata('ref.txt');
ref = ref.data;

hold on
plot(ref(:,1)./1.55,ref(:,2)*100)
xlim([8 50]);
a=gca;
ylim([0.4 0.9]*100);
a.XTick = [9:4:49];
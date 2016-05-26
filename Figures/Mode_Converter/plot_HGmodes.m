clear all
subplot = @(m,n,p) subtightplot(m,n,p);

lvector = [0 1 0 2 2 3];
pvector = [0 0 1 0 1 3];
figure(1)
clf
for ii=1:length(lvector)
% clear domain;
l = lvector(ii); p = pvector(ii);
w=150e-6;
R=-1e10;
lambda=800e-8;
q=q_(w,R,lambda);

screensize=3*w;
nptsr=1024;
nptstheta=100;
accuracy=0.001;

[xmesh,ymesh] = meshgrid(linspace(-screensize,screensize,nptsr),linspace(-screensize,screensize,nptsr));

z1 = HermiteGaussianE([p,l,q_(w,R,lambda),lambda],xmesh,ymesh);
% z1=LaguerreGaussianE([p,l,q_(w,R,lambda),lambda],xmesh,ymesh,'cart');
cmap= cbrewer('div','RdBu',512);
if ii==1, cmap = [cmap(257:end,:);cmap(1:256,:)]; end;
rgb = mat2im(angle(z1),cmap);
adjusted_brightness = rgb.*repmat(abs(z1).^2./max(max(abs(z1).^2)),[1 1 3]);

figure(1);
subplot(1,6,ii)
imagesc(xmesh(1,:),ymesh(:,1),adjusted_brightness); axis square;
a =gca;
a.Visible = 'off';
%export_fig(['LG_Mode(' num2str(l) ',' num2str(p) ')'],'-png','-r400');
end

%% colormap
figure(111)
clf
plot(1,1)
view(2)
colormap(cmap);
colorbar
export_fig('colorbarLG_RB','-png','-r400');

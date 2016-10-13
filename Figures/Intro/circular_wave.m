taxis = linspace(-5,5,5000).*1e-15;
taxis = linspace(-4,4,500).*1e-15;
xaxis = linspace(-2,2,256).*1e-3;

tau = 50e-15;
qvect = 11;%(11:2:51)';
lambda = 800e-9;%./qvect;
omega = 3e8.*2.*pi./lambda;
Ex = repmat(exp(-(taxis).^2./tau.^2),length(qvect),1).*cos(repmat(omega,1,length(taxis)).*repmat(taxis,length(qvect),1));
Ey = repmat(exp(-(taxis).^2./tau.^2),length(qvect),1).*cos(repmat(omega,1,length(taxis)).*repmat(taxis,length(qvect),1)+repmat(pi/2,length(qvect),length(taxis)));
focusing = ones(size(taxis));%sqrt(1+(taxis-max(taxis)).^2./max(taxis).^2.*10);
AttoPulseX = sum(Ex,1).*focusing;
AttoPulseY = sum(Ey,1).*focusing;
% figure(1)
% clf
% plot(taxis,AttoPulseX)
% hold on
% plot(taxis,AttoPulseY)

figure(2)
plot3(taxis,AttoPulseX,AttoPulseY)
view([20 30]);

%%
xaxis = linspace(-30,30,256);
[X,Y] = meshgrid(xaxis);
idx = 1:3:500;
taxis2=taxis(idx);
% xv = zeros(size(X)); yv = xv;
% zv = zeros(size(X));
% U = ones(size(X)); V = U; W = U;
xv = zeros(1,length(taxis2));yv = zeros(1,length(taxis2));  
zv = taxis2;
uv = AttoPulseX(idx);vv = AttoPulseY(idx);
wv = zeros(1,length(taxis2));
figure(3)
clf

hold on
r = 5.55e-16;
plot3(taxis,AttoPulseX.*r,AttoPulseY.*r,'Color',[52 77 126]./255,'LineWidth',1.75)
a=quiver3(zv,xv,yv,wv,uv,vv,'LineWidth',1);
a.MaxHeadSize = 0.03;
a.Color = [52 77 126]./255;
view([20 30]);
b=gca;
% b.View = [115 20];
% b.DataAspectRatio = [5 1 1];
b.Visible = 'off';
% %%
% xaxis = linspace(-30,30,256);
% [X,Y,T] = meshgrid(xaxis,xaxis,taxis);
% pulse3d = zeros(size(X));
% for ii=1:length(taxis)
% pulse3d(:,:,ii) = (abs(X(:,:,ii))<AttoPulseX(ii))&(abs(Y(:,:,ii))<AttoPulseY(ii));
% end
% %%
% Isovaleur_affichee = 0;
% 
% figure(3)
% clf
% ap=patch(isosurface(X,T,Y,pulse3d,Isovaleur_affichee),'FaceColor',[69,117,180]./255,'EdgeColor','none');
% 
% lighting gouraud
% view(120,10)
% camlight headlight


%%
AttoPulseX = zeros(size(taxis));
AttoPulseY = cos(2*pi*3e8/lambda.*taxis);
figure(2)
clf
plot3(taxis,AttoPulseX,AttoPulseY)

view([20 30]);

%%
xaxis = linspace(-30,30,256);
[X,Y] = meshgrid(xaxis);
idx = 1:5:500;
taxis2=taxis(idx);
% xv = zeros(size(X)); yv = xv;
% zv = zeros(size(X));
% U = ones(size(X)); V = U; W = U;
xv = zeros(1,length(taxis2));yv = zeros(1,length(taxis2));  
zv = taxis2;
uv = AttoPulseX(idx);vv = AttoPulseY(idx);
wv = zeros(1,length(taxis2));
figure(3)
clf

hold on
r = 7.2e-16;
plot3(taxis,AttoPulseX.*r,AttoPulseY.*r,'Color',[52 77 126]./255,'LineWidth',1.75)
a=quiver3(zv,xv,yv,wv,uv,vv,'LineWidth',1);
a.MaxHeadSize = 0.05;
a.Color = [52 77 126]./255;
view([8 20]);
b=gca;
% b.View = [115 20];
b.DataAspectRatio = [5 1 2];
b.Visible = 'off';
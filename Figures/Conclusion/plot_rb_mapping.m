taxis = linspace(0,3,256).*1e-15;
q = 11:1:25;
qvect = linspace(10.5,25.5,512);

[T,Q] = meshgrid(taxis,qvect);
Iq = zeros(size(T));
omega = 2*pi*3e8/800e-9;
DeltaE = 103e-18;
largeur = 0.2;
for ii=1:length(q)
    qq= q(ii);
    if(mod(qq,2))
        Iq = Iq + exp(-(Q-qq).^2./largeur.^2).*(1+0.5.*abs(cos(omega.*T+DeltaE.*omega.*qq)));
    else
        Iq = Iq + exp(-(Q-qq).^2./largeur.^2).*0.5.*abs(sin(omega.*T+DeltaE.*omega.*qq));
    end
end

%
figure(2)
clf
surf(T./(1.3e-15),Q,Iq)
view(2)
shading interp
axis tight
colormap(parula)

%%
load('redcmap.mat'); rcmap = cmap;
load('bluecmap.mat'); bcmap = cmap;
raxis = linspace(0,200,256).*1e-6;
thaxis = linspace(0,2*pi,256);
[R,Th] = meshgrid(raxis,thaxis);
[X,Y] = pol2cart(Th,R);
Iq2 = cell(1,length(q));
omr = 75e-6;
Ir = (R.^2)./omr.^2.*exp(-(R.^2)./omr.^2);
omb = 75e-6;
Ib = (R.^2)./omb.^2.*exp(-(R.^2)./omb.^2);

figure(3)
clf
surf(X,Y,Ir)
view(2)
shading interp
axis equal
colormap(rcmap)

figure(4)
clf
surf(X,Y,Ib)
view(2)
shading interp
axis equal
colormap(bcmap)
%%

subplot = @(m,n,p) subtightplot(m,n,p);
q = 11:1:19;
figure(5)
clf
for ii=1:length(q)
    qq= q(ii);
    if(mod(qq,2))
        Iq2{ii} = Ir.*(1+1.5.*abs(cos(Th/2+DeltaE.*omega.*qq)));
    else
        Iq2{ii} = Ir.*(1+1.5.*abs(sin(Th/2+DeltaE.*omega.*qq)));
    end
    figure(5)
    subplot(1,length(q),ii)
    surf(X,Y,Iq2{ii})
    view(2)
    shading interp
    axis equal
    colormap(bcmap)
    a=gca;
    a.Visible = 'off';
end

%%
taxis2 = linspace(0,5,256).*1e-15;
figure(44)
clf
plot(taxis,cos(omega.*taxis2))
hold on
plot(taxis,cos(2*omega.*taxis2+2*pi/3))


%%
figure(67)
clf
surf(X,Y,Th)
view(2)
shading interp
colormap(gray)
axis equal
a=gca;
a.Visible = 'off';

%%
tmp = Iq2{1};
tmpft = fftshift(fft2(tmp));
figure(5)
clf
surf(abs(tmpft))
view(2)
shading interp

NptsXY=1*1024;
w0=15e-3; %waist en m

d1=0.4e-3;   %diameter of the inner beam
d2=0.4e-3;

lambda=800e-9/11;
k0=2*pi/lambda;

%
% DR0 =3*w0;
% r=linspace(-DR0,DR0,NptsXY);    % Grid for the transverse axis at the entrance.
% [XArray, YArray]=meshgrid(r,20*r); % Meshgrids on the entrance plane
% RArray=sqrt(XArray.^2+YArray.^2);
% [ThetaArray,RhoArray] = cart2pol(XArray,YArray);
% Deltar=mean(diff(r));
%
m=8;
e=1;

% E1=exp(-(RArray/w0).^2).*exp(1i*m*ThetaArray);%(XArray+1i*e*YArray).^m %Laguerre-Gauss d'ordre m
%%
% figure_docked('Champ');clf
figure(1)
set(gcf,'renderer','zbuffer')   %Important for avoiding annoying white stripes
subplot(2,1,1)
temp=abs(E1).^2;
temp(temp<=1e-2)=NaN;
%     surfc(XArray*1000, YArray*1000,abs(U0).^2)
surfc(XArray*1000, YArray*1000,temp)
shading interp
axis square
axis ([-30 30 -30 30])
view(2)
axis tight
xlabel('x-axis(mm) ')
ylabel('y-axis(mm)')
title('Intensity of the input beam')

subplot(2,1,2)
temp=angle(E1);
temp(abs(E1).^2<=1e-2)=NaN;
surfc(XArray*1000, YArray*1000,temp)
shading interp
axis square
axis ([-30 30 -30 30])
view(2)
axis tight
xlabel('x-axis(mm) ')
ylabel('y-axis(mm)')
title('Phase of the input beam')
%

%
% Mz0=[1 0 z0 0;
%     0 1 0 z0;
%     0 0 1 0;
%     0 0 0 1];
%
% Mz=[1 0 z 0;
%     0 1 0 z;
%     0 0 1 0;
%     0 0 0 1];
%
% d=1e-3/1200;%pas du réseau
% theta1=0;%angle d'incidence
% theta2=asind(lambda/d-sind(theta1));
% Rg=0.235;%rayon de courbure
% Rgt=2*cosd(theta1)*cosd(theta2)*Rg/(cosd(theta1)+cosd(theta2));
% M=cosd(theta1)/cosd(theta2);
%
% Mreseau=[M 0 0 0;
%          0 1 0 0;
%          -2/Rgt 0 1/M 0;
%          0 0 0 1];
%
% Mtot=Mz*Mreseau*Mz0;
%
%
% aa1=Mtot(1,1);
% aa2=Mtot(2,2);
% bb1=Mtot(1,3);
% bb2=Mtot(2,4);
% cc1=Mtot(3,1);
% cc2=Mtot(4,2);
% dd1=Mtot(3,3);
% dd2=Mtot(4,4);
%
% ww1=sqrt(1./(1/w0^2+1i*k0*aa1./(2*bb1)));
% ww2=sqrt(1./(1/w0^2+1i*k0*aa2./(2*bb2)));
%
% aalpha1=k0*ww1.^2./(2*bb1);
% aalpha2=k0*ww2.^2./(2*bb2);
%
% bbeta1=(k0*ww1./(2*bb1)).^2+1i*k0*dd1./(2*bb1);
% bbeta2=(k0*ww1./(2*bb2)).^2+1i*k0*dd2./(2*bb2);
% ggamma=sqrt(ww1.^2-ww2.^2);

%% Transfer matrix
NptsXY=1*1024;
w0=10e-3; %waist en m

d1=0.4e-3;   %diameter of the inner beam
d2=0.4e-3;

lambda=800e-9/11;
load('bluecmap');
DR0 =3*w0;
r=linspace(-DR0,DR0,NptsXY);    % Grid for the transverse axis at the entrance.
[XArray, YArray]=meshgrid(0.0003*r,r);
z=0.235;%0.14069
z0 = 0.237;
m=3;
eps = 1;
theta = 6*pi/180;
f = 0.235;
M = @(z) [eye(2) z.*eye(2) ; zeros(2,2) eye(2)];
% C = [sec(theta) 0 ; 0 cos(theta)];
C = [1 0 ; 0 0];
Mlens = [eye(2) zeros(2,2) ; -C./f eye(2)];

Mtot = M(z)*(Mlens*M(z0));
aa1 = Mtot(1,1); aa2 = Mtot(2,2);
bb1 = Mtot(1,3); bb2 = Mtot(2,4);
cc1 = Mtot(3,1); cc2 = Mtot(4,2);
dd1 = Mtot(3,3); dd2 = Mtot(4,4);
B = Mtot(1:2,3:4);
b = det(B);

phi = @(x1,y1,x2,y2) x1^2*a1/b1+y1^2*a2/b2 + x2^2*d1/b1 + y2^2*d2/b2 -2*(x1*x2/b1 + y1*y2/b2);
k0=2*pi/lambda;
ww1 = sqrt(1./(1/w0^2+1i*k0*aa1/2/bb1));
ww2 = sqrt(1./(1/w0^2+1i*k0*aa2/2/bb2));
aalpha1 = k0*ww1^2/2/bb1;
aalpha2 = k0*ww2^2/2/bb2;
bbeta1 = (k0*ww1/2/bb1)^2+1i*k0*dd1/2/bb1;
bbeta2 = (k0*ww2/2/bb2)^2+1i*k0*dd2/2/bb2;
ggamma = sqrt(ww1^2-ww2^2);

E4=(k0*ww1.*ww2*(1i/2)^(m+1)/sqrt(bb1.*bb2)).*exp(-(bbeta1.*XArray.^2+bbeta2.*YArray.^2))...
    .*ggamma^m.*hermite(m,(aalpha1.*XArray+1i*eps.*aalpha2.*YArray)./ggamma);

figure(22)
% subplot(2,1,1)
set(gcf,'renderer','zbuffer')   %Important for avoiding annoying white stripes
temp=abs(E4).^2;
%temp(temp<1e-2)=NaN;
surf(XArray*1000,YArray*1000,temp./max(temp(:)))
shading interp
%      axis equal
%axis ([-10 10 -10 10])
% xlim([-0.1 0.1])
view(2)
%axis tight
xlabel('x-axis(mm) ')
ylabel('y-axis(mm)')
title('Intensity of the beam on the lens ')
axis tight
colormap(cmap)

%%
zvect = linspace(0.23489,0.23511,9);
zvect = [0.2348 0.2349 0.234985 0.23499 0.235];% 0.23501 0.235015 0.2351 0.2352];
rvect = [0.001 0.001 0.0005 0.0005 0.0003];

for ii=1:length(zvect)
    z=zvect(ii);
    [XArray, YArray]=meshgrid(rvect(ii).*r,r);
    Mtot = M(z)*(Mlens*M(z0));
    aa1 = Mtot(1,1); aa2 = Mtot(2,2);
    bb1 = Mtot(1,3); bb2 = Mtot(2,4);
    cc1 = Mtot(3,1); cc2 = Mtot(4,2);
    dd1 = Mtot(3,3); dd2 = Mtot(4,4);
    B = Mtot(1:2,3:4);
    b = det(B);
    
    phi = @(x1,y1,x2,y2) x1^2*a1/b1+y1^2*a2/b2 + x2^2*d1/b1 + y2^2*d2/b2 -2*(x1*x2/b1 + y1*y2/b2);
    k0=2*pi/lambda;
    ww1 = sqrt(1./(1/w0^2+1i*k0*aa1/2/bb1));
    ww2 = sqrt(1./(1/w0^2+1i*k0*aa2/2/bb2));
    aalpha1 = k0*ww1^2/2/bb1;
    aalpha2 = k0*ww2^2/2/bb2;
    bbeta1 = (k0*ww1/2/bb1)^2+1i*k0*dd1/2/bb1;
    bbeta2 = (k0*ww2/2/bb2)^2+1i*k0*dd2/2/bb2;
    ggamma = sqrt(ww1^2-ww2^2);
    
    E4=(k0*ww1.*ww2*(1i/2)^(m+1)/sqrt(bb1.*bb2)).*exp(-(bbeta1.*XArray.^2+bbeta2.*YArray.^2))...
        .*ggamma^m.*hermite(m,(aalpha1.*XArray+1i*eps.*aalpha2.*YArray)./ggamma);
    
    
    figure(23)
    clf
%     subplot(1,length(zvect),ii);
    set(gcf,'renderer','zbuffer')   %Important for avoiding annoying white stripes
    temp=abs(E4).^2;
    %temp(temp<1e-2)=NaN;
    surf(XArray*1000,YArray*1000,temp./max(temp(:)))
    shading interp
    %      axis equal
    %axis ([-10 10 -10 10])
    % xlim([-0.1 0.1])
    view(2)
    %axis tight
    xlabel('x-axis(mm) ')
    ylabel('y-axis(mm)')
    title('Intensity of the beam on the lens ')
    axis tight
    colormap(cmap)
    a=gca; 
    a.Visible = 'off';
    export_fig(['Propag_Grating_2_' num2str(ii)],'-png','-r300');
end
%% Gamma study
zvect = 0:0.001:1;

for ii=1:length(zvect)
    z=zvect(ii);%0.18;%0.14069
    z0 = 0.05;
    m=15;
    theta = 6*pi/180;
    f = 0.1406;
    M = @(z) [eye(2) z.*eye(2) ; zeros(2,2) eye(2)];
    % C = [sec(theta) 0 ; 0 cos(theta)];
    C = [1 0 ; 0 0];
    Mlens = [eye(2) zeros(2,2) ; -C./f eye(2)];
    
    Mtot = M(z)*(Mlens*M(z0));
    aa1 = Mtot(1,1); aa2 = Mtot(2,2);
    bb1 = Mtot(1,3); bb2 = Mtot(2,4);
    cc1 = Mtot(3,1); cc2 = Mtot(4,2);
    dd1 = Mtot(3,3); dd2 = Mtot(4,4);
    B = Mtot(1:2,3:4);
    b = det(B);
    
    phi = @(x1,y1,x2,y2) x1^2*a1/b1+y1^2*a2/b2 + x2^2*d1/b1 + y2^2*d2/b2 -2*(x1*x2/b1 + y1*y2/b2);
    k0=2*pi/lambda;
    ww1 = sqrt(1./(1/w0^2+1i*k0*aa1/2/bb1));
    ww2 = sqrt(1./(1/w0^2+1i*k0*aa2/2/bb2));
    aalpha1 = k0*ww1^2/2/bb1;
    aalpha2 = k0*ww2^2/2/bb2;
    bbeta1 = (k0*ww1/2/bb1)^2+1i*k0*dd1/2/bb1;
    bbeta2 = (k0*ww2/2/bb2)^2+1i*k0*dd2/2/bb2;
    ggamma = sqrt(ww1^2-ww2^2);
    gammasave(ii) = abs(ggamma);
end

figure(4)
oneDplot(zvect,gammasave)
[~,i] = max(gammasave);
zvect(i)

%%
temp2=temp;
IndexT=find((YArray)>=0);
temp2(IndexT)=0;
[Max1,idC] = max(temp2);
[~,idL]=max(Max1);
LineMax=idL;
ColMax=idC(LineMax);


temp2=temp;
IndexT=find((YArray)<=0);
temp2(IndexT)=0;
[Max1,idC] = max(temp2);
[~,idL]=max(Max1);
LineMax2=idL;
ColMax2=idC(LineMax2);

X1=XArray(ColMax,LineMax);
X2=XArray(ColMax2,LineMax2);
Y1=YArray(ColMax,LineMax);
Y2=YArray(ColMax2,LineMax2);

ExtraLine=0.3;
X1=X1-ExtraLine*(X2-X1);
X2=X2+ExtraLine*(X2-X1);
Y1=Y1-ExtraLine*(Y2-Y1);
Y2=Y2+ExtraLine*(Y2-Y1);


NPtsLine=100;
XLine=linspace(X1,X2,NPtsLine);
YLine=linspace(Y1,Y2,NPtsLine);

LineOutIntensity=0;
for ii=1:NPtsLine
    
    [~, IndexXMin]=min(abs(XArray(1,:)-XLine(ii)));
    [~, IndexYMin]=min(abs(YArray(:,1)-YLine(ii)));
    LineOutIntensity(ii)=temp(IndexYMin,IndexXMin);
    
    
end

figure
oneDplot(1:NPtsLine,LineOutIntensity)
figure(2)
line([X1 X2]*1000, [Y1, Y2]*1000, [3*max(temp(:)) 3*max(temp(:))],'color','w')
% [~,ind]=max(max(temp(:)));
% [y,x] = ind2sub(NptsXY,idx);
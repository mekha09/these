clear all

NptsXY=1025;  %number of point along the radius. Sampling for the hankel function evaluation as well
f=1.0; % focal length of the lens in m
d1vect=(5:1:25).*1e-3;   %diameter of the inner beam
d2=15e-3;   %Diameter of the annular beam
w0=15e-3;   %Waist of the laser when collimated
Ein=1e-3; %Energy in J
Tau1=50e-15; %Duration (s) of the beam
Lambda=792e-9;
k0 = 2*pi/Lambda;   % Wave vector
zL=0.0;  %Distance from the phase mask to the lens
zP=f;   %Distance from the lens to where the final profile is calculated

zE=f;   %SDcreen (MCP) distance from focus

I0=2*Ein/Tau1/pi/(w0^2)*sqrt(4*log(2)/pi);   %Reference for the  intensity
%Phase mask
NPhase=0*800/800;   %Number of pi phase difference between the upper and lower part of the beam

%%
for ii=1:length(d1vect)
    d1 = d1vect(ii);
    DR0 =5*max(d1,d2);    %Typical size of the input slit. Used to define the input grid.
    %\\\\|\|\||||\ It should be large enough so that the step of the Fourier transform is
    % small enough to get a good definition of the focus.
    r=linspace(-DR0,DR0,NptsXY);    % Grid for the transverse axis at the entrance.
    [XArray YArray]=meshgrid(r,r); % Meshgrids on the entrance plane
    RArray=sqrt(XArray.^2+YArray.^2);
    Deltar=mean(diff(r));   %usefull for defining the output grid
    
    
    
    
    %------- Input field ---------------
    U0 =sqrt(I0)*exp(-(RArray/w0).^2);%Gaussian beam
    U0=U0.*((RArray-d1/2)<0);   %times the diameter of the hole
    
    ULens=U0;
    
    %%------------------------------------------------------------------------
    % \\\\\\\\\\\\\\\\\\ Propagation from the lens to the z position \\\\\\\\
    %%------------------------------------------------------------------------
    %Computation of the field at abcissa z after the lens
    % It should be chosen close to focus for the FT method to work
    %Usual scaling factors
    rLinOut=2*pi/NptsXY/Deltar*linspace(0,NptsXY-1,NptsXY);  %Scaling of the output grid obtained through the Fourier Transform
    Scale=Deltar/sqrt(2*pi);    %Amplitude scaling factor for 1D
    Scale=Scale^2;  % Here is for 2D. Checked on a gaussian:correct
    %Here it is the FT taken at x'*k/zP=x'*2*pi/lambda/z. So the linscale and scale requires
    % rescaling:
    rLinOut=rLinOut*Lambda/2/pi*zP;
    rLinOut=rLinOut-mean(rLinOut);
    %Just 2pi is missing on the Scale to fit with the definition of the FFT:
    Scale=Scale*(2*pi);
    
    [XOutArray YOutArray]=meshgrid(rLinOut,rLinOut); % output grid
    ROutArray=sqrt(XOutArray.^2+YOutArray.^2);
    U0temp = ULens.*exp(-i*k0*(RArray).^2/2*(1/f-1/zP)); %Input field times a lens and the other one in the Fresnel integral
    U0Out=Scale/(Lambda*zP).*fftshift(fft2(fftshift(U0temp)).*exp(i*k0*(ROutArray).^2/2/zP));
    temp=abs(U0Out).^2;
    Imax=max(max(temp))*1e-18;
    
    xsave(ii,:) = XOutArray(512,:);
    Usave(ii,:) = U0Out(512,:);
    Isave(ii) = Imax;
end

%%
commonaxis = linspace(-200e-6,200e-6,257);
clear Usave2
for ii=1:length(d1vect)
    Usave2(ii,:)= interp1(xsave(ii,:),abs(Usave(ii,:)).^2,commonaxis);
end
%
load('bluecmap.mat');
figure(1)
clf
% surf(commonaxis*1e6,d1vect.*1000,Usave2.*1e-4)
surf(commonaxis*1e6,d1vect.*1000,ones(size(Usave2)))
view(2)
shading interp
xlim([-60 60]);
ylabel('diam')
xlabel('X (mum)')
colormap(cmap)
a=gca;

colorbar

%%
%export_fig('I_funofIris','-png','-r300');


%%
for ii=1:length(d1vect)
    tmp = Usave2(ii,:);
    imax(ii) = max(tmp);
f = fit(commonaxis',tmp','gauss1');
% plot(f,commonaxis,tmp)
     waist(ii) = f.c1;
end

%%
subplot = @(m,n,p) subtightplot(m,n,p);
figure(33)
clf
subplot(1,2,1)
plot(imax.*1e-18,d1vect.*1e3)
xlim([0 10]);
subplot(1,2,2)
plot(waist.*1e6,d1vect.*1e3)
xlim([20 95]);

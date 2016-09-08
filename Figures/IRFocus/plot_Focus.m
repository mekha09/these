clear all
% A = im2double(rgb2gray(imread('400-800_BBO_min.bmp')));
L1 = im2double(rgb2gray(imread('Images foyer céline\Foyer 800nm l=1 (2).bmp')));
load('redcmap.mat');

%%
xc = 603; yc = 110; R = 25;
L1crop = L1((yc-R):(yc+R),(xc-R):(xc+R));
% L1crop = L1crop+flipud(L1crop);
L1crop = L1crop./max(L1crop(:));
L1crop = imrotate(L1crop,25,'bilinear','crop');
figure(2)
clf
surf(L1crop)
view(2)
shading interp
axis equal
colormap(cmap)
a=gca;
% a.CLim = [0.14 0.42];
a.CLim = [0.20 1.1];
a.Visible = 'off';
%%
L2 = im2double(rgb2gray(imread('Images foyer céline\Foyer 800nm l=2 (2).bmp')));
% xc = 603; yc = 110; R = 25;
L2crop = L2((yc-R):(yc+R),(xc-R):(xc+R));
% L2crop = L2crop+flipud(L2crop);
L2crop = L2crop./max(L2crop(:));
L2crop = imrotate(L2crop,25,'bilinear','crop');
figure(2)
clf
surf(L2crop)
view(2)
shading interp
axis equal
colormap(cmap)
a=gca;
a.CLim = [0.20 1.1];
a.Visible = 'off';
%%
L3 = im2double(rgb2gray(imread('Images foyer céline\Foyer 800nm l=2+1.bmp')));
xc = 603; yc = 113; R = 30;
L3crop = L3((yc-R):(yc+R),(xc-R):(xc+R));
L3crop = L3crop./max(L3crop(:));
% L3crop = L3crop+flipud(L3crop);
L3crop = imrotate(L3crop,25,'bilinear','crop');
figure(2)
clf
surf(L3crop)
view(2)
shading interp
axis equal
colormap(cmap)
a=gca;
a.CLim = [0.20 1.1];
a.Visible = 'off';

%%
export_fig('L1','-png','-r100')
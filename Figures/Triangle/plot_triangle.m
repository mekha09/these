clear all

l1 = imread('L=1_diffracted.bmp');
l2 = imread('L=2_diffracted.bmp');
l3 = imread('L=3_diffracted.bmp');
load('redcmap.mat');

%%
figure(1)
set(gcf,'renderer','zbuffer');
clf
l11 = imrotate(l1,0,'bilinear','crop');
imagesc(l11)
colormap(cmap)
center = [358 226];
R = 150;
xlim([center(1)-R center(1)+R]);
ylim([center(2)-R center(2)+R]);
a = gca;
a.DataAspectRatio = [1 1 1];
a.XTick = {};
a.YTick = {};

%%
figure(2)
set(gcf,'renderer','zbuffer');
clf
l22 = imrotate(l2,3,'bilinear','crop');
imagesc(l22)
colormap(cmap)
center = [362 247];
R = 150;
xlim([center(1)-R center(1)+R]);
ylim([center(2)-R center(2)+R]);
a = gca;
a.DataAspectRatio = [1 1 1];
a.XTick = {};
a.YTick = {};

%%
figure(3)
set(gcf,'renderer','zbuffer');
clf
l33 = imrotate(l3,3,'bilinear','crop');
imagesc(l33)
colormap(cmap)
center = [361 253];
R = 150;
xlim([center(1)-R center(1)+R]);
ylim([center(2)-R center(2)+R]);
a = gca;
a.DataAspectRatio = [1 1 1];
a.XTick = {};
a.YTick = {};
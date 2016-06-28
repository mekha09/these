clear all

l1 = imread('400nm_L=1.bmp');
l2 = imread('400nm_L=2.bmp');
l3 = imread('400nm_L=3.bmp');
load('bluecmap.mat');

%%
figure(1)
% set(gcf,'renderer','zbuffer');
clf
l11 = imrotate(l1,9,'bilinear','crop');
imagesc(l11)
colormap(cmap)
center = [429 149];
R = 150;
xlim([center(1)-R center(1)+R]);
ylim([center(2)-R center(2)+R]);
a = gca;
a.DataAspectRatio = [1 1 1];
a.XTick = {};
a.YTick = {};
a.CLim(2) = 265;
% export_fig(['Triangl_400_1'],'-png','-r500');

%%
figure(2)
set(gcf,'renderer','zbuffer');
clf
l22 = imrotate(l2,5,'bilinear','crop');
imagesc(l22)
colormap(cmap)
center = [434 151];
R = 150;
xlim([center(1)-R center(1)+R]);
ylim([center(2)-R center(2)+R]);
a = gca;
a.DataAspectRatio = [1 1 1];
a.XTick = {};
a.YTick = {};
a.CLim(2) = 265;
% export_fig(['Triangl_400_2'],'-png','-r500');

%%
figure(3)
set(gcf,'renderer','zbuffer');
clf
l33 = imrotate(l3,3,'bilinear','crop');
imagesc(l33)
colormap(cmap)
center = [438 158];
R = 150;
xlim([center(1)-R center(1)+R]);
ylim([center(2)-R center(2)+R]);
a = gca;
a.DataAspectRatio = [1 1 1];
a.XTick = {};
a.YTick = {};
a.CLim(2) = 150;
export_fig(['Triangl_400_3'],'-png','-r500');

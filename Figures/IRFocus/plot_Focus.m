clear all
A = im2double(rgb2gray(imread('400-800_BBO_min.bmp')));
load('redcmap.mat');

%%
figure(1)
clf
surf(A)
view(2)
shading interp
axis equal
colormap(cmap)
a=gca;
a.CLim = [0.14 0.42];
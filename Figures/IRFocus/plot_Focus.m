clear all
A = im2double(rgb2gray(imread('400-800_BBO_min.bmp')));

%%
figure(1)
clf
surf(A)
view(2)
shading interp
axis equal
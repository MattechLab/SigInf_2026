clc; close all;clear 

addpath('Dataset')
addpath('My_functions')
addpath('Pack_1_petkov_functions')

%Lena = imread('lab03_intro_image_01.png');
Lena = imread('bOvf94dPRxWu0u3QsPjF_tree.jpeg');
%% 
figure, imagesc(Lena), axis image,  colormap('gray');
lena_gray = double(rgb2gray(Lena));
figure, imagesc(lena_gray), axis image,  colormap('gray');
dx = Dx1(lena_gray);
dy = Dy1(lena_gray);

figure, subplot(2,1,1), imagesc(dx), axis image, colormap('gray'), subplot(2,1,2), imagesc(dy)
axis image, colormap('gray');

%%
grad=sqrt(dx.^2+dy.^2);
figure, imagesc(grad), axis image, colormap('gray');


%%
lambd=0;
sigma=(0.56)*5;
gamma=0.4;
phi=[0,90];

theta=linspace(0,pi,36);

%Convolution of Gabor filters with the initial stimulus
result=mygaborfilter2(lena_gray, lambd, sigma, theta, phi, gamma, 2);
result_conv1=squeeze(result(:,:,1,:));
result_conv2=squeeze(result(:,:,2,:));
energy=sqrt(result_conv1.^2+result_conv2.^2);
[massimi,indmax]=max(energy,[],3);

for k=1:size(lena_gray,1)
    for j=1:size(lena_gray,2)
    orientazioni(k,j)=theta(indmax(k,j));
    end
end

figure, imagesc(orientazioni), axis image

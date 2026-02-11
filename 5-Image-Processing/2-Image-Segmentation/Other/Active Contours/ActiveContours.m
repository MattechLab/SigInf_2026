%% Prueba Active Contours 
close all; clc;

I = imread('C:\Users\jaime\OneDrive\VADL\Unit 4 Segmentation\plane2.jpg');
imshow(I)    
str = 'Click to select initial contour location. Double-click to confirm and proceed.'; 
title(str); 
fprintf('\nNote: Click close to object boundaries for more accurate result.\n');

mask = roipoly;    
figure, imshow(mask), title('Initial MASK'); 

maxIterations = 200; 
bw = activecontour(I, mask, maxIterations, 'Chan-Vese');    
% Display segmented image 
figure, imshow(bw), title('Segmented Image'); 


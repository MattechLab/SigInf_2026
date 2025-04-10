close all; clear; clc;
I = imread('square.png');
I_hist=imhist(I);
th = graythresh(I);
I_seg = imbinarize(I, th); % Otsu's algorithm
figure('Position', [100, 100, 1200, 400]);
subplot(1, 3, 1);
imshow(I);
title('Original Image');
subplot(1, 3, 2);
imshow(I_seg);
title('Segmented Image');
subplot(1, 3, 3)
plot(I_hist);
title('Image histogram (blue) and threshold value (red)');
hold on;
line([th * 255, th * 255], ylim, 'Color', 'r'); % Ensure correct threshold scaling
hold off;


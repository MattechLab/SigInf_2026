clc

% Load and resize the image
img = imread('grace_hopper.jpg'); % Make sure the file is in the same directory or provide the full path
if size(img, 3) == 3
    img = rgb2gray(img); % Convert to grayscale if the image is in color
end

% Set up the figure with two side-by-side subplots
figure;

% Left subplot: Display the grayscale image in high quality
subplot(1, 2, 1);
imshow(img, []); % Display the original image in high resolution
title('Grayscale Image', 'FontSize', 12, 'Color', 'black');
axis equal;
axis off;

% Right subplot: Display pixel intensity values on a black background with less density
subplot(1, 2, 2);
imagesc(zeros(size(img))); % Display a black background of the same size as the original image
colormap('gray'); % Gray colormap for reference (will not affect black background)
axis equal; % Keep axes proportional for a square display
axis off; % Hide axes
hold on;

% Add color bar with a smaller width
c = colorbar;
caxis([0 255]); % Set color bar range for grayscale intensity
set(c, 'Position', [0.92, 0.1, 0.02, 0.8]); % Adjust the color bar to be narrower and positioned

% Set a larger step size and adjust font size for fewer displayed values
step = 50; % Increase step size to display fewer values
font_size = 8;

% Display pixel intensity values in green on black background
for i = 1:step:size(img, 1)
    for j = 1:step:size(img, 2)
        pixel_value = img(i, j);
        rectangle('Position', [j - step/2, i - step/2, step, step], 'EdgeColor', 'none', 'FaceColor', 'black'); % Create black squares
        text(j, i, num2str(pixel_value), 'Color', 'green', 'FontSize', font_size, ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    end
end

% Adjust the title of the right subplot in black without "green on black" text
title('Pixel Intensity Values', 'Color', 'black', 'FontSize', 12);
hold off;

% Adjust the positions of the subplots to align the two images symmetrically
set(subplot(1, 2, 1), 'Position', [0.1, 0.1, 0.4, 0.8]); % Position of the left subplot
set(subplot(1, 2, 2), 'Position', [0.55, 0.1, 0.35, 0.8]); % Position of the right subplot

%% RGB Display with Pixel Intensity Values and Separate Color Channel Views

% Load the high-quality RGB image
img = imread('grace_hopper_RGB.jpg'); % Load RGB image (ensure the image file is in the same directory or provide the full path)

% First Figure with Pixel Intensity Values on Black Background
figure;

% Display the high-quality original RGB image in the first subplot
subplot(1, 4, 1);
imshow(img);
title('RGB Image', 'FontSize', 12);

% Resize image data for better readability in the channel subplots
resized_img = imresize(img, [80, 80]);

% Define step size for pixel display and font size for text
step = 10; % Adjust this to control sparsity of displayed pixels
fontSize = 7;

% Red Channel
subplot(1, 4, 2);
imshow(zeros(size(resized_img))); % Black background
hold on;
for i = 1:step:size(resized_img, 1)
    for j = 1:step:size(resized_img, 2)
        redVal = resized_img(i, j, 1); % Red channel value
        text(j, i, sprintf('%d', redVal), ...
            'Color', [1, 0, 0], ... % Red color text
            'FontSize', fontSize, ...
            'HorizontalAlignment', 'center');
    end
end
title('Red Channel', 'Color', 'red', 'FontSize', 12);
axis off;
hold off;

% Green Channel
subplot(1, 4, 3);
imshow(zeros(size(resized_img))); % Black background
hold on;
for i = 1:step:size(resized_img, 1)
    for j = 1:step:size(resized_img, 2)
        greenVal = resized_img(i, j, 2); % Green channel value
        text(j, i, sprintf('%d', greenVal), ...
            'Color', [0, 1, 0], ... % Green color text
            'FontSize', fontSize, ...
            'HorizontalAlignment', 'center');
    end
end
title('Green Channel', 'Color', 'green', 'FontSize', 12);
axis off;
hold off;

% Blue Channel
subplot(1, 4, 4);
imshow(zeros(size(resized_img))); % Black background
hold on;
for i = 1:step:size(resized_img, 1)
    for j = 1:step:size(resized_img, 2)
        blueVal = resized_img(i, j, 3); % Blue channel value
        text(j, i, sprintf('%d', blueVal), ...
            'Color', [0, 0, 1], ... % Blue color text
            'FontSize', fontSize, ...
            'HorizontalAlignment', 'center');
    end
end
title('Blue Channel', 'Color', 'blue', 'FontSize', 12);
axis off;
hold off;

% Adjust layout
set(gcf, 'Position', [100, 100, 1400, 400]); % Resize figure for better viewing

%% Second Figure with Each Color Channel Displayed Separately in its Original Color

% Convert the image to double precision
img_double = im2double(img);

% Separate each channel and prepare images for each color
red_channel_img = cat(3, img_double(:, :, 1), zeros(size(img_double, 1), size(img_double, 2)), zeros(size(img_double, 1), size(img_double, 2)));
green_channel_img = cat(3, zeros(size(img_double, 1), size(img_double, 2)), img_double(:, :, 2), zeros(size(img_double, 1), size(img_double, 2)));
blue_channel_img = cat(3, zeros(size(img_double, 1), size(img_double, 2)), zeros(size(img_double, 1), size(img_double, 2)), img_double(:, :, 3));

% Display each channel in its original color
figure;

% Red Channel in red color
subplot(1, 3, 1);
imshow(red_channel_img);
title('Red Channel', 'Color', 'red', 'FontSize', 12);

% Green Channel in green color
subplot(1, 3, 2);
imshow(green_channel_img);
title('Green Channel', 'Color', 'green', 'FontSize', 12);

% Blue Channel in blue color
subplot(1, 3, 3);
imshow(blue_channel_img);
title('Blue Channel', 'Color', 'blue', 'FontSize', 12);

% Adjust layout for the new figure
set(gcf, 'Position', [150, 150, 1200, 400]);

%% Noise 

%% Load and Convert RGB Image to Grayscale
img = imread('grace_hopper_RGB.jpg'); % Load the RGB image
gray_img = rgb2gray(img); % Convert to grayscale

% Display original grayscale image
figure;
subplot(1, 3, 1);
imshow(gray_img);
title('Original Grayscale Image', 'FontSize', 12);

%% Add Gaussian Noise
sigma = 0.05; % Standard deviation of Gaussian noise
gaussian_noisy_img = imnoise(im2double(gray_img), 'gaussian', 0, sigma);

% Display grayscale image with Gaussian noise
subplot(1, 3, 2);
imshow(gaussian_noisy_img);
title('With Gaussian Noise', 'FontSize', 12);

%% Add Salt-and-Pepper Noise
density = 0.05; % Noise density for salt-and-pepper
sp_noisy_img = imnoise(gray_img, 'salt & pepper', density);

% Display grayscale image with Salt-and-Pepper noise
subplot(1, 3, 3);
imshow(sp_noisy_img);
title('With Salt-and-Pepper Noise', 'FontSize', 12);

%% Image processing techniques
%% Load a Low-Contrast Image
img = imread('low_contrast_imag.jpg'); % Replace with an actual low-contrast image
if size(img, 3) == 3
    img = rgb2gray(img); % Convert to grayscale if it's an RGB image
end

%% Display Original Image and Histogram
figure;

% Original image
subplot(2, 3, 1);
imshow(img);
title('Original Image', 'FontSize', 12);

% Original histogram
subplot(2, 3, 4);
[counts_original, bins] = imhist(img);
bar(bins, counts_original, 'FaceColor', [0, 0, 1], 'EdgeColor', [0, 0, 1]); % Blue histogram
title('Original Histogram', 'FontSize', 10);
xlim([0, 255]); % Set the same x-axis range for both histograms
ylim([0, max(counts_original) * 1.1]); % Match y-axis range (with slight padding)

%% Apply Histogram Equalization
enhanced_img = histeq(img);

% Display Enhanced Image and Histogram
% Enhanced image
subplot(2, 3, 2);
imshow(enhanced_img);
title('Enhanced Image', 'FontSize', 12);

% Enhanced histogram
subplot(2, 3, 5);
[counts_enhanced, ~] = imhist(enhanced_img);
bar(bins, counts_enhanced, 'FaceColor', [0, 0, 1], 'EdgeColor', [0, 0, 1]); % Blue histogram
title('Enhanced Histogram', 'FontSize', 10);
xlim([0, 255]); % Set the same x-axis range
ylim([0, max(counts_original) * 1.1]); % Match y-axis range (based on the original histogram)

%% Mapping Function (Straight Line)
% Compute the cumulative distribution function (CDF) for the original image
cdf = cumsum(counts_original) / numel(img);

% Plot the mapping function
subplot(2, 3, 3);
plot(bins, cdf, 'r', 'LineWidth', 2); % CDF in red
hold on;
plot(bins, bins / max(bins), 'b--', 'LineWidth', 1); % Reference line for identity mapping in blue dashed
title('Mapping Function', 'FontSize', 10);
xlabel('Input Intensity');
ylabel('Output Intensity');
legend('CDF Mapping', 'Identity Line', 'Location', 'southeast');
grid on;

% Adjust layout
set(gcf, 'Position', [100, 100, 1200, 600]); % Resize figure for better viewing

%% Filtering in the spatial domain: smoothing
%% Mean filtering
% Load the Grace Hopper image (RGB)
img = imread('grace_hopper_RGB.jpg'); % Replace with the actual image file path

% Convert the image to grayscale for simplicity
gray_img = rgb2gray(img);

% Define a 3x3 mean filter kernel
mean_kernel = ones(3, 3) / 9;

% Smooth the original grayscale image using the mean filter
smoothed_original = imfilter(gray_img, mean_kernel, 'replicate');

% Plot the results
figure;

% Original grayscale image
subplot(2, 2, 1);
imshow(gray_img);
title('Original Grayscale Image', 'FontSize', 12);

% Histogram of original grayscale image
subplot(2, 2, 2);
imhist(gray_img);
title('Histogram (Original)', 'FontSize', 10);

% Smoothed original image (mean filter)
subplot(2, 2, 3);
imshow(smoothed_original);
title('Smoothed Image (Mean Filter)', 'FontSize', 12);

% Histogram of smoothed original image
subplot(2, 2, 4);
imhist(smoothed_original);
title('Histogram (Smoothed)', 'FontSize', 10);

% Adjust layout for better visibility
set(gcf, 'Position', [100, 100, 1200, 800]);

%% Gaussian filtering

% Read a grayscale image (e.g., Grace Hopper)
original_img = imread('grace_hopper.jpg'); 
original_img = rgb2gray(original_img); % Convert to grayscale if RGB

% Add Gaussian noise to the image
noisy_img = imnoise(original_img, 'gaussian', 0, 0.02); % Mean=0, Variance=0.02

% Define a stronger Gaussian filter
gaussian_sigma = 2.5; % Larger standard deviation for more smoothing
gaussian_filter = fspecial('gaussian', [7 7], gaussian_sigma); % Larger kernel

% Apply Gaussian filter to smooth the noisy image
smoothed_img = imfilter(noisy_img, gaussian_filter, 'replicate');

% Plot the results
figure;

% Noisy image
subplot(1, 2, 1);
imshow(noisy_img);
title('Noisy Image (Gaussian Noise)', 'FontSize', 12);

% Smoothed image
subplot(1, 2, 2);
imshow(smoothed_img);
title('Smoothed Image (Gaussian Filter)', 'FontSize', 12);

% Adjust layout for better visualization
set(gcf, 'Position', [100, 100, 900, 400]); % Wider figure layout

%% Laplacian filter - not big changes (because the intensity does not change in an abrupt way)

% Read a grayscale image (e.g., Grace Hopper)
original_img = imread('grace_hopper.jpg'); 
original_img = rgb2gray(original_img); % Convert to grayscale if RGB

% Define a Laplacian filter kernel
laplacian_filter = fspecial('laplacian', 0.2); % 0.2 is the alpha value for edge sensitivity

% Apply the Laplacian filter to the original image
laplacian_result = imfilter(original_img, laplacian_filter, 'replicate');

% Plot the results
figure;

% Original image
subplot(1, 2, 1);
imshow(original_img);
title('Original Image', 'FontSize', 12);

% Laplacian-filtered image
subplot(1, 2, 2);
imshow(laplacian_result, []);
title('Laplacian Filter Result', 'FontSize', 12);

% Adjust layout
set(gcf, 'Position', [100, 100, 900, 400]); % Wider figure layout

%% Laplacian 2

% Create a synthetic image with abrupt intensity changes (checkerboard)
img_size = 256; % Define the size of the image
square_size = 32; % Size of each square in the checkerboard
checkerboard_img = checkerboard(square_size, img_size/(2*square_size), img_size/(2*square_size)) > 0.5;
checkerboard_img = uint8(checkerboard_img * 255); % Convert logical array to uint8 image

% Define a Laplacian filter kernel
laplacian_filter = fspecial('laplacian', 0); % Use default alpha = 0

% Apply the Laplacian filter to the synthetic image
laplacian_result = imfilter(checkerboard_img, laplacian_filter, 'replicate');

% Enhance the contrast of the Laplacian result for better visibility
laplacian_result = imadjust(laplacian_result);

% Plot the results
figure;

% Original synthetic image
subplot(1, 2, 1);
imshow(checkerboard_img);
title('Synthetic Image with Abrupt Changes', 'FontSize', 12);

% Laplacian-filtered image
subplot(1, 2, 2);
imshow(laplacian_result, []);
title('Laplacian Filter Result', 'FontSize', 12);

% Adjust layout
set(gcf, 'Position', [100, 100, 1000, 400]); % Adjust figure size for better visibility


%% 
%close all 

%% Gaussian filter in the frequency domain

% Step 1: Load the image
image = imread('Jaime.png');
if size(image, 3) == 3
    image = rgb2gray(image); % Convert to grayscale if the image is RGB
end

% Step 2: Perform the Fourier Transform
fft_image = fft2(double(image)); % Compute 2D FFT of the image
fft_shift = fftshift(fft_image); % Shift zero frequency to the center

% Step 3: Create a Gaussian Low-Pass Filter
[m, n] = size(image); % Dimensions of the image
[X, Y] = meshgrid(-n/2:n/2-1, -m/2:m/2-1); % Create a grid centered at zero
D = sqrt(X.^2 + Y.^2); % Distance from the center
D0 = 50; % Cutoff frequency (adjust as needed)
gaussian_filter = exp(-(D.^2) / (2 * (D0^2))); % Gaussian filter formula

% Step 4: Apply the Gaussian filter in the frequency domain
filtered_fft = fft_shift .* gaussian_filter;

% Step 5: Perform the Inverse Fourier Transform
ifft_shift = ifftshift(filtered_fft); % Shift zero frequency back
filtered_image = ifft2(ifft_shift); % Compute the inverse FFT
filtered_image = abs(filtered_image); % Take the magnitude of the result

% Step 6: Display Results
figure;

% Original Image
subplot(2, 2, 1);
imshow(image, []);
title('Original Image');

% Magnitude Spectrum of Original FFT
subplot(2, 2, 2);
imshow(log(1 + abs(fft_shift)), []);
title('Magnitude Spectrum (Original)');

% Gaussian Filter
subplot(2, 2, 3);
imshow(gaussian_filter, []);
title('Gaussian Low-Pass Filter');

% Filtered Image
subplot(2, 2, 4);
imshow(filtered_image, []);
title('Filtered Image (Low-Pass)');

%% Band pass filter 

% Step 1: Load the image
image = imread('Jaime.png'); % Replace 'Jaime.png' with your image
if size(image, 3) == 3
    image = rgb2gray(image); % Convert to grayscale if the image is RGB
end

% Step 2: Perform the Fourier Transform
fft_image = fft2(double(image)); % Compute 2D FFT of the image
fft_shift = fftshift(fft_image); % Shift zero frequency to the center

% Step 3: Create a Band-Pass Filter
[m, n] = size(image); % Dimensions of the image
[X, Y] = meshgrid(-n/2:n/2-1, -m/2:m/2-1); % Create a grid centered at zero
D = sqrt(X.^2 + Y.^2); % Distance from the center

% Define the inner and outer cutoff frequencies for the band-pass filter
D0_low = 20;  % Inner cutoff frequency (high-pass threshold)
D0_high = 50; % Outer cutoff frequency (low-pass threshold)

% Create the Gaussian low-pass and high-pass filters
low_pass = exp(-(D.^2) / (2 * (D0_high^2))); % Low-pass filter
high_pass = 1 - exp(-(D.^2) / (2 * (D0_low^2))); % High-pass filter

% Combine to create the band-pass filter
band_pass_filter = low_pass .* high_pass;

% Step 4: Apply the Band-Pass Filter in the Frequency Domain
filtered_fft = fft_shift .* band_pass_filter;

% Step 5: Perform the Inverse Fourier Transform
ifft_shift = ifftshift(filtered_fft); % Shift zero frequency back
filtered_image = ifft2(ifft_shift); % Compute the inverse FFT
filtered_image = abs(filtered_image); % Take the magnitude of the result

% Step 6: Display Results
figure;

% Original Image
subplot(2, 3, 1);
imshow(image, []);
title('Original Image');

% Magnitude Spectrum of Original FFT
subplot(2, 3, 2);
imshow(log(1 + abs(fft_shift)), []);
title('Magnitude Spectrum (Original)');

% Band-Pass Filter
subplot(2, 3, 3);
imshow(band_pass_filter, []);
title('Band-Pass Filter');

% Filtered Image
subplot(2, 3, 4);
imshow(filtered_image, []);
title('Filtered Image (Band-Pass)');

% Low-Pass Filter (for reference)
subplot(2, 3, 5);
imshow(low_pass, []);
title('Low-Pass Filter');

% High-Pass Filter (for reference)
subplot(2, 3, 6);
imshow(high_pass, []);
title('High-Pass Filter');


%% %Feature extractions

%Lena = imread('lab03_intro_image_01.png');
Lena = imread('tree.jpeg');

% Step 2: Convert to grayscale if necessary
if size(Lena, 3) == 3
    Lena_gray = rgb2gray(Lena); % Convert RGB to grayscale
else
    Lena_gray = Lena; % Image is already grayscale
end

% Step 3: Apply the Canny edge detection
% The 'edge' function performs Canny edge detection
edges = edge(Lena_gray, 'Canny');

% Step 4: Visualize the results
figure;
subplot(1, 2, 1);
imshow(Lena_gray);
title('Original Grayscale Image');

subplot(1, 2, 2);
imshow(edges);
title('Canny Edge Detection');

%% Segmentation

% Step 1: Load the image
image = imread('Jaime.png');

% Step 2: Convert to Lab color space for better clustering
% Lab separates color information (a, b) from brightness (L)
image_lab = rgb2lab(image);

% Reshape the image into a 2D array where each row is a pixel
[m, n, ~] = size(image);
pixel_features = reshape(image_lab, m * n, 3);

% Step 3: Perform k-means clustering
% Choose the number of clusters (e.g., 3 for segmentation)
num_clusters = 3;
[cluster_idx, cluster_centers] = kmeans(pixel_features, num_clusters, ...
    'Distance', 'sqEuclidean', 'Replicates', 3);

% Reshape the clustered output back to the original image size
segmented_image = reshape(cluster_idx, m, n);

% Step 4: Display the results
figure;

% Original image
subplot(1, 2, 1);
imshow(image);
title('Original Image');

% Segmented image (display each region with a unique color)
segmented_rgb = label2rgb(segmented_image); % Convert labels to RGB
subplot(1, 2, 2);
imshow(segmented_rgb);
title(['Segmented Image with ', num2str(num_clusters), ' Clusters']);

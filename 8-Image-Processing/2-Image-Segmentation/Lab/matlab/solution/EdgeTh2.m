%% Edge threshold 2
close all; clear; clc;
addpath("sw/")
I=imread('imgs/star2.png');
th=0.35;
I_edge=SobelDetector(I,th);
NumLines=8;
Display=1;
[rho,theta]=HoughTransform(I_edge,NumLines,Display);
LineCuts=GetLineCuts(I,rho,theta);
LineMask = false(size(I));
for i = 1:NumLines
    [x,y] = bresenham(LineCuts(:,i));
    LineMask(sub2ind(size(I), y, x)) = true;
end

% Postprocessing
se_dilate=strel('disk',7);
I_edge_dilate=imdilate(I_edge,se_dilate);
I_line_dilate=imdilate(LineMask,se_dilate);
I_intersect=I_edge_dilate.*I_line_dilate;
se_erode=strel('disk',5);
I_intersect_erode=imerode(I_intersect,se_erode);
I_filled=imfill(I_intersect_erode,'holes');

% Plotting
figure
subplot(241), imshow(I), title('Original Image');
subplot(242), imshow(I_edge), title('Edge Image');
subplot(243), imshow(LineMask), title('Line Image');
subplot(244), imshow(I_edge_dilate), title('Edge dilate');
subplot(245), imshow(I_line_dilate), title('Line dilate');
subplot(246), imshow(I_intersect), title('Intersection');
subplot(247), imshow(I_intersect_erode), title('Erosion');
subplot(248), imshow(I_filled), title('Final segmentation');







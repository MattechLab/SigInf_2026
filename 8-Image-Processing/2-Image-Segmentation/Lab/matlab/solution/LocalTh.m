%% Local Thresholds 
close all; clear; clc;
I=imread('imgs/sonnet.png');
figure, imshow(I), title('Original Image');
n = 10;
for i=n+1:size(I,1)-n
    for j=n+1:size(I,2)-n
        A=I(i-n:i+n,j-n:j+n); % (2n+1)*(2n+1) block for n=10
        m=median(A);
        if I(i,j)>m
            I(i,j)=1; % white 
        else
            I(i,j)=0; % black 
        end
    end
end
figure, imshow(I,[0 1]), title('Segmented Image');

%% Local thresholding
close all; clear; clc;
I=imread('imgs/sonnet.png');
figure, imshow(I), title('Original Image');
n=10;
for i=n+1:size(I,1)-n
    for j=n+1:size(I,2)-n
        A=I(i-n:i+n,j-n:j+n); % (2n+1)*(2n+1) block for n=10
        m=median(A);
        if I(i,j)>m-n
            I(i,j)=1; % white 
        else
            I(i,j)=0; % black 
        end
    end
end
figure, imshow(I,[0 1]), title('Segmented Image');
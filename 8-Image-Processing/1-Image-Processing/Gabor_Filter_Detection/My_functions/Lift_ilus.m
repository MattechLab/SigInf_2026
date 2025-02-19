clc 
clear all
close all

A=imread('Surf.png');
img=double(A(:,:,1))/255;

figure()
colormap gray;
imagesc(img)
axis image
title('Img')
shading interp;

img=img(1:250,1:250);
[nx, ny]=size(img);

figure()
colormap gray;
imagesc(img)
axis image
title('Img')
shading interp;

img = laplacian_eucl(img, 0.1, 100);

figure()
colormap gray;
imagesc(img)
axis image
title('Img')
shading interp;

nz=50;

%-----------------------------------------------
%Lifting dell'immagine nello spazio corticale
%-----------------------------------------------

dx = Dx(img);
dy = Dy(img);
theta = atan2(dy,dx); %restituisce fra -pi e +pi
ATB=theta([2 2:nx-1 nx-1],[2 2:ny-1 ny-1]);
mg= sqrt(dx.^2+dy.^2);
Lift=zeros(nx,ny,nz);
M=zeros(nx,ny,nz);
Lift2=zeros(nx,ny,nz);

[X, Y, Z]=meshgrid(1:ny,1:nx,1:nz);
len=nz-1;

for k=1:nz 
    Lift(:,:,k)=cos((k-1).*pi./(nz)-(theta(:,:))).^12; 
    M(:,:,k)=exp(-len/pi.*sin((k-1)*pi/len-ATB(:,:)+pi/2).^2);
    Lift2(:,:,k)=sin((k-1)*pi/len-ATB(:,:)+pi/2)*len/pi;
end

maxLift=max(Lift,[],3);
    
figure()
Sigma=patch(isosurface(X,Y,Z,Lift2,0,M),'FaceColor','interp', 'EdgeColor', 'none','FaceAlpha',1);
isonormals(X,Y,Z,Lift2,Sigma);
view(3)
Vert=get(Sigma,'Vertices');
axis image
lighting phong
grid on;
colormap copper;
hold on

X1=zeros(1,nz);
X2=zeros(1,nz);

i=10; j=10;
DX= D3x(Lift2); DY=D3y(Lift2); DTheta=D3z(Lift2);
figure()
for k=1:5:nz
    X1=cos(k)*DX(i,j,k)+sin(k)*DY(i,j,k);
    X2=DTheta(i,j,k);
    [x,y]=meshgrid((i-5):(i+5),(j-5):(j+5));
    theta=acos(x./y);
    surf(x,y,theta) 
    hold on
end


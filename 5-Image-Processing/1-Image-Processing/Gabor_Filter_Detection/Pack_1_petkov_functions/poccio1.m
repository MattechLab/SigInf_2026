clc
close all

nx=50;

u=zeros(nx,nx);
v=zeros(nx,nx);

v(nx/2,nx/2)=5;

figure();
quiver(u,v);

it = 0; 
itmax = 2000;
dt = 0.1;


u0 = zeros(nx,nx);
v0 = zeros(nx,nx);

mu=0.1;
lambda = 2;

while it < itmax
    
    u0 = u0 + dt.*(mu*(Dxx(u0) + Dyy(u0)) + (mu + lambda)*(Dxx(u0) + Dx(Dy(v0))) - u);
    v0 = v0 + dt.*(mu*(Dxx(v0) + Dyy(v0)) + (mu + lambda)*(Dy(Dx(u0)) + Dyy(v0)) - v);
    it = it + 1

end
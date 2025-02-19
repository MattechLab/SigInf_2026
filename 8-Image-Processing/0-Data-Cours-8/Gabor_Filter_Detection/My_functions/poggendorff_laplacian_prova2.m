%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% POGGENDORFF
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear all

%%
theta=linspace(0,pi,100);
sigma=0.3;
m=200;
n=150;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% POGGENDORFF CON SUPERFICIE IN MEZZO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=zeros(m,n);
lung_pog=60;
A(1:m,(1+(n-lung_pog)/2):1:(n-((n-lung_pog)/2)))=ones(m,60);
msk=A; %La maschera è costituita di elementi uguali a 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% POGGENDORFF CON RETTE PARALLELE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A=zeros(m,n);
% lung_pog=60;
% A(1:m,(1+(n-lung_pog)/2))=ones(m,1);
% A(1:m,n-((n-lung_pog)/2))=ones(m,1);
% 
% msk=A; %La maschera è costituita di elementi uguali a 1

figure()
imagesc(A)
axis image
colormap gray

[x0]=n/2;
[y0]=m/2;


figure()
imshow(A)   %Credo che la matrice venga più larga perchè viene ritagliata l'img in pixel dallo schermo, che misurerà quei pixel lì. 
xlabel('x') %Getframe copia la quantità di spazio di schermo occupata dall'immagine.
ylabel('y')
axis image
 
%%
sum_1=zeros(m,n);
sum_2=zeros(m,n);
sum_3=zeros(m,n);
         
int_1=zeros(m,n);
int_2=zeros(m,n);
int_3=zeros(m,n);
coun=0;
coun1=0;


A=laplacian_eucl(A, 0.1, 100);
dx=Dx(A); 
dy=Dy(A); 
[nx ny]=size(dx);
dx1=dx./sqrt(dx.^2+dy.^2+.00001);
dy1=dy./sqrt(dx.^2+dy.^2+.00001);

%Calcolo gli angoli shiftando sul dominio [0 2*pi]
thetalift=-atan2(dx1,dy1);
[xlif, ylif]=size(thetalift);

for i=1:xlif
    for j=1:ylif
        if (thetalift(i,j)<0)
           thetalift(i,j)=thetalift(i,j)+pi;
        end
    end
end

%thetabound = thetalift([2 2:nx-1 nx-1],[2 2:ny-1 ny-1]); %Toglie la prima riga e l'ultima, e vi ricopia 2 e nx-1


for i=1:m
    for j=1:n
        
        if msk(i,j)==1
           
           
           tlift=thetalift(i,j);
           
           for cc=1:length(theta)   
                sum_1(i,j)= sum_1(i,j) + exp(-(cos(theta(cc)-tlift).^2)/(2*sigma)).*(cos(theta(cc))).^2;
                sum_2(i,j)= sum_2(i,j) + exp(-(cos(theta(cc)-tlift).^2)/(2*sigma)).*(cos(theta(cc)).*sin(theta(cc)));
                sum_3(i,j)= sum_3(i,j) + exp(-(cos(theta(cc)-tlift).^2)/(2*sigma)).*(sin(theta(cc))).^2;
           end
    
            int_1(i,j)=sum_1(i,j)/(length(theta));
            int_2(i,j)=sum_2(i,j)/(length(theta));
            int_3(i,j)=sum_3(i,j)/(length(theta));
 
                if mod(j,20)==0
                   if mod(i,40)==0
                    % DRAW THE ELLIPSE
                    Sp1=[int_1(i,j) int_2(i,j);int_2(i,j) int_3(i,j)];
                    [Vec, Val]=eig(Sp1);
                    vec1= Vec(:,1)/norm(Vec(:,1));
                    vec2= Vec(:,2)/norm(Vec(:,2));
                
                    theta0 = atan2(-vec1(2),vec1(1));
                    %theta0=acos(vec1(1));
                    a=Val(1,1); if a<0; coun=coun+1; end
                    b=Val(2,2); if b<0; coun1=coun1+1; end
                    ellipse(15*sqrt(a),15*sqrt(b),-theta0,j,i,'m',1000);  %Devo dare j e i invertiti perchè gli angoli vengono calcolati rispetto al piano %cartesiano standard
                    hold on
                    quiver(j,i,cos(theta0),-sin(theta0),7)  %con uso di theta0 segna l'asse a, il primo asse considerato                                      
                    hold on 
                    
                   end
                end
            int_1(i,j)=sum_1(i,j)/(length(theta))-1;
            int_2(i,j)=sum_2(i,j)/(length(theta));
            int_3(i,j)=sum_3(i,j)/(length(theta))-1;
         else
        
    
    
            for cc=1:length(theta)   
                sum_1(i,j)= sum_1(i,j) + (cos(theta(cc))).^2;
                sum_2(i,j)= sum_2(i,j) + (cos(theta(cc)).*sin(theta(cc)));
                sum_3(i,j)= sum_3(i,j) + (sin(theta(cc))).^2;
            end
    
        int_1(i,j)=sum_1(i,j)/(length(theta));
        int_2(i,j)=sum_2(i,j)/(length(theta));
        int_3(i,j)=sum_3(i,j)/(length(theta));
         
        
            if mod(j,30)==0
               if mod(i,70)==0
                Sp1=[int_1(i,j) int_2(i,j);int_2(i,j) int_3(i,j)];
                [Vec, Val]=eig(Sp1);
                vec1= Vec(:,1)/norm(Vec(:,1));
                vec2= Vec(:,2)/norm(Vec(:,2));
        
                % DRAW THE ELLIPSE
                theta0 = atan2(-vec1(2),vec1(1));
                %theta0=acos(vec1(1));
                a=Val(1,1); if a<0; coun=coun+1; end
                b=Val(2,2); if b<0; coun1=coun1+1; end
                ellipse(8*sqrt(a),8*sqrt(b),-theta0,j,i,'g',1000);
                hold on 
%                 quiver(j,i,cos(theta0),-sin(theta0),7)
%                 hold on
               end
            end
           int_1(i,j)=sum_1(i,j)/(length(theta))-1;
           int_2(i,j)=sum_2(i,j)/(length(theta));
           int_3(i,j)=sum_3(i,j)/(length(theta))-1;
       end
   end
end

Mat=zeros(m,n,4);
Mat(:,:,1)=A;
Mat(:,:,2)=int_1;
Mat(:,:,3)=int_2;
Mat(:,:,4)=int_3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DIFFUSIONE DEGLI STRATI DEI TENSORI
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% Mat(:,:,2)=laplacian_eucl(Mat(:,:,2), 0.1, 50);
% Mat(:,:,3)=laplacian_eucl(Mat(:,:,3), 0.1, 50);
% Mat(:,:,4)=laplacian_eucl(Mat(:,:,4), 0.1, 50);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SOLUZIONE DELL' EQUAZIONE DI POISSON
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha_1=(-Dx(Mat(:,:,4))+Dx(Mat(:,:,2))+2.*Dy(Mat(:,:,3)));
alpha_2=(-Dy(Mat(:,:,2))+Dy(Mat(:,:,4))+2.*Dx(Mat(:,:,3)));

u=zeros(m,n);
v=zeros(m,n);
t=0.1;
it=20000;

for l=1:it
    
    u=u+t.*(Dxx(u)+Dyy(u)-alpha_1);
    
end

for l=1:it
    
    v=v+t.*(Dxx(v)+Dyy(v)-alpha_2);
    
end

u1=u(1:6:m,1:6:n);
v1=v(1:6:m,1:6:n);

figure()

quiver(u1,v1,2)
axis image


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DEFORMAZIONE DI UNA RETTA COL CAMPO I(x,y)=I(x+U,y+V)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stimolo_superposed=zeros(m,n);

figure()

for j=1:n
    stimolo_superposed(j,j)=1;  
    stimolo_superposed(10+j,j)=1; 
    stimolo_superposed(20+j,j)=1; 
    stimolo_superposed(30+j,j)=1; 
    stimolo_superposed(40+j,j)=1;
    stimolo_superposed(50+j,j)=1; 
    stimolo_superposed(60+j,j)=1;
    
    stimolo_superposed(70+j,j)=1;
    stimolo_superposed(80+j,j)=1;
    stimolo_superposed(90+j,j)=1;
    
end


imagesc(stimolo_superposed)
colormap gray


figure()

for i=1:m
    for j=1:n
        if stimolo_superposed(i,j)==1
           plot(j+u(i,j),(m-i)+v(i,j),'k')
           hold on
        end
    end
end

axis([1 n 1 m])

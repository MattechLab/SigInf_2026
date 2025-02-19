function f = Dx(Mat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% f = Dx(Mat)
%
%  Differenza finita centrata lungo x
%
% Parametri in ingresso:
% Mat := matrice di cui calcolare la derivata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
[m n] = size(Mat);

if nargin == 1
    f = (Mat(1:m,[2:n n]) - Mat(1:m,[1 1:n-1]))/2;
else error('Usage: Dx = Dx(Mat)');
end
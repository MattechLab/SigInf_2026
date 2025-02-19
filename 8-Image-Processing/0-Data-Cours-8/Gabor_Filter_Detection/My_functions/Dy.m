function f = Dy(Mat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% f = Dy(Mat)
%
%  Differenza finita centrata lungo y
%
% Parametri in ingresso:
% Mat := matrice di cui calcolare la derivata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[m n] = size(Mat);

if nargin == 1
   f = (Mat([2:m m],1:n) - Mat([1 1:m-1],1:n))/2; 
else error('Usage: Dy = Dy(Mat)');
end
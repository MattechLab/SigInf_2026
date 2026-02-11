function f = Dxx(Mat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% f = Dxx(Mat)
%
% Calcolo della derivata seconda lungo x
%
% Parametri in ingresso:
% Mat := matrice di cui calcolare la derivata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
[m n] = size(Mat);

if nargin == 1
   f = (Mat(1:m,[2:n n]) - 2.*Mat + Mat(1:m,[1 1:n-1])); 
else error('Usage: f = Dxx(Mat)');
end


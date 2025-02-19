function f =  Dp_y(Mat) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% f =  Dp_y(Mat)
%
% Calcola la differenza finita in avanti lungo y
%  
% Parametri in ingresso
%
% Mat := matrice di cui calcolare la derivata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m n] = size(Mat);

if nargin == 1
    f = (Mat([2:m m],1:n) - Mat);
else error('Usage:  f = Dp_y(Mat)');
end
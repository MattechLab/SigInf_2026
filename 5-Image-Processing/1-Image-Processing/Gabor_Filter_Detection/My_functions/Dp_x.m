function f =  Dp_x(Mat) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% f =  Dp_x(Mat)
%
% Calcola la differenza finita in avanti lungo x
%  
% Parametri in ingresso
%
% Mat := matrice di cui calcolare la derivata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m n] = size(Mat);

if nargin == 1
    f = (Mat(1:m,[2:n n]) - Mat);
else error('Usage:  f = Dp_x(Mat)');
end



    

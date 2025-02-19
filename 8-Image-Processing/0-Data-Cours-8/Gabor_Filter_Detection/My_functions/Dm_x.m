function f =  Dm_x(Mat) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% f =  Dm_x(Mat)
%
% Calcola la differenza finita all'indietro lungo x
%  
% Parametri in ingresso
%
% Mat := matrice di cui calcolare la derivata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m n] = size(Mat);
if nargin == 1
    f = (Mat - Mat(1:m,[1 1:n-1]));
else error('Usage:  f = Dm_x(Mat)');
end




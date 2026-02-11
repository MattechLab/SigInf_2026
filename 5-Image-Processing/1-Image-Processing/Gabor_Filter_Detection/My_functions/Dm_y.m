function f =  Dm_y(Mat)  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% f =  Dm_y(Mat)
%
% Calcola la differenza finita all'indietro lungo y
%  
% Parametri in ingresso
%
% Mat := matrice di cui calcolare la derivata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m n] = size(Mat);

if nargin == 1
    f = (Mat - Mat([1 1:m-1],1:n));
else error('Usage:  f = Dm_y(Mat)');
end
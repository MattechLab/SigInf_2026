%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Use:  f = Dxx1(Matrix)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Dxx1(Mat) 
[m n] = size(Mat);
f = Mat([2:m m],1:n) - 2.* Mat + Mat([1 1:m-1],1:n); 
%dalla seconda riga in poi, e l'ultima ripetuta due volte; 
% - 2 volte la matrice;
%la prima riga ripetuta due volte, e poi fino alla penultima.


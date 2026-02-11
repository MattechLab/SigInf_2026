%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Use:  f = Dx1(Matrix)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Dx1(Mat) 
[m n] = size(Mat);
f = (Mat([2:m m],1:n) - Mat([1 1:m-1],1:n))./2; 
% dalla seconda riga in poi, e l'ultima ripetuta due volte;
% - prima riga ripetuta due volte, e poi fino alla penultima;
% tutto diviso 2

% Divido per due perché sto facendo differenze centrate: l'incremento è di
% due intervalli!
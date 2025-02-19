function f = Dxy1(Mat) 
[m n] = size(Mat);
f = (Mat([2:m m],[2:n n]) - Mat([2:m m],[1 1:n-1]) - Mat([1 1:m-1],[2:n n]) + Mat([1 1:m-1],[1 1:n-1]))/4; 
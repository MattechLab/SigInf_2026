function LineCuts = GetLineCuts(I,rhos,thetas)

% INPUT:
% I -> Original image
% rhos -> Rho values of the lines
% thetas ->  Theta values of the lines

% OUTPUT:
% LineCuts: One set of cut-points per column [col1;fil1;col2;fil2]

Row = size(I,1);
Col = size(I,2);
LineCuts = [];
NumLines = length(rhos);
for i = 1:NumLines
    coor_hom = Pol2Hom(thetas(i), rhos(i), 0);         % From polar to homogeneous coordinates
    PuntosCorte = GetImageCut(coor_hom,Row,Col);       % cut points with the image limits
    if (PuntosCorte(1) == -1), continue; end           % If there are not enought cut points the line is not valid. We go to the next one
    LineCuts = [LineCuts, PuntosCorte];     
end
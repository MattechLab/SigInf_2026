function [out] = laplacian_eucl(img, dt, it)
% la funzione implementa il calore euclideo

for i=1:it
    lapl= Dxx(img) + Dyy(img);
    img = img + dt.*(lapl);
end

out=img;

end
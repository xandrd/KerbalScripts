function [ a, e, Rp ] = OrbitalParam( mu, V,R,al )
%ORBITALPARAM orbital parameters from mu, V, R and alpha [Balk]
a = R.*mu ./ (2.*mu - (V.^2).*R);
sigma = V.*R.*sin(al);
h = V.^2 - 2.*mu./R;
e = sqrt(1+h.* (sigma.^2 ./ mu.^2) );
Rp = a ./ (e + 1);
end


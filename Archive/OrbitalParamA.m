function [e,a] = OrbitalParamA(mu,Va,Ra)
% orbital parameters from apogi V and R
% a - major semiaxis
% e- excentricity

    a = (mu.*Ra)./(2.*mu - Ra.*Va.^2);
    e = (Ra - a)./a;
end
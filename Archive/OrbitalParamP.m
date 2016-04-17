function [e,a] = OrbitalParamP(mu,Vp,Rp)
% orbital parameters from peregi V and R
% a - major semiaxis
% e- excentricity

    a = (mu.*Rp)./(2.*mu - Rp.*Vp.^2);
    e = (a - Rp)./a;
end
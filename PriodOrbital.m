function T = PriodOrbital( mu, a)
%Period - orbital period

T = 2.*pi.*sqrt(a.^3/mu);
end


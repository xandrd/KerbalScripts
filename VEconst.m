function V2 = getVEconst(mu,V1,R1,R2)
% Calculate V from conservation for Energy
% V2 - velocity at R2
% V1 - velocirty at R1
% mu - gravitational paramter

    V2 = sqrt( V1.^2 - 2.*mu.*( 1./R1 - 1./R2 ) );
end
function V2 = VEconst(mu,V1,R1,R2)
% Calculate V from conservation for Energy 
% V2 = VEconst(mu,V1,R1,R2)
% mu - gravitational paramter
% V1 - velocity at R1
% V2 - velocity at R2

    V2 = sqrt( V1.^2 - 2.*mu.*( 1./R1 - 1./R2 ) );
end
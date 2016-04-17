function [V, deltaV] = SOI_V(mu, Vsoi, Rsoi, R0)
% perigi velosity and delta V for parking/departure
% Vsoi - velocity at the ende of SOI
% Rsoi - Radius of soi
% R0   - parking orbit

    V_r = sqrt(mu ./ R0);
    V  = VfromEconst(mu, Vsoi, Rsoi, R0);
    deltaV = abs(V - V_r);
    
end
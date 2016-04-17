% script for interplanetary trasfer
Constants
%% trasfer to left turn
Vmin = 1e-3;
Vh   = VHomman(mu0,R2,R1)-1e-3;
deltaV = linspace(Vmin,Vh,10);
perpV = Vh - deltaV; % perpendicular velosity

al = atan(perpV ./ Vh ) + pi./2; % Initial velosity angle
totalV = sqrt(perpV.^2 + Vh.^2);

[a,e,Rp] = OrbitalParam(mu0,totalV,R2,al);
phi0 = PhiOrbital(e,a,R2);
phi1 = PhiOrbital(e,a,R1);
phi_rot = phi0 + phi1; % Total true anomaly change

T_to_peregi = -1.*TimeTransfer(mu0,a,e,phi0,0);
T_to_cross  = TimeTransfer(mu0,a,e,0,phi1);
T = T_to_peregi + T_to_cross;
M  = TimeToMeanAnomaly(mu0,R1,phi_rot,-1.*T); % Initial phase of target planet
M0 = TimeToMeanAnomaly(mu0,R2,0,T); % End phase of source planet

phi1 =  pi - (phi0 + phi1);
ip = 0;
PlotTrasferResults;



%% trasfer to acceleration
Vmin = 1e-3; % free falling
Vh   = VHomman(mu0,R2,R1)-1e-3; % with trigonometrical correction
deltaV = linspace(Vmin,Vh,10);

[a,e, Rp] = OrbitalParam(mu0,deltaV,R2,pi./2);

phi0 = pi;
phi1 = PhiOrbital(e,a,R1);

T = -1.*TimeTransfer(mu0,a,e,phi0,phi1);
M = TimeToMeanAnomaly(mu0,R1,phi1,T); % Initial phase of target planet
M0 = TimeToMeanAnomaly(mu0,R2,0,T); % End phase of source planet


ip = 1;
PlotTrasferResults;

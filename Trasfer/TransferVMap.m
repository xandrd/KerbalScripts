% script for interplanetary trasfer
Constants
figure('Position',[100 100 600 900],'defaultAxesFontWeight','bold','defaultAxesFontsize',12);

%% trasfer to left
Vh   = VHomman(mu0,R1,R2);
Vmax = Vparapolic(mu0,R1) - 1;
V = linspace(Vh,Vmax,100);
perpV = V - Vh; % perpendicular velosity

al = atan(perpV ./ Vh ) + pi./2; % Initial velosity angle
totalV = sqrt(perpV.^2 + Vh.^2);

[a,e,Rp] = OrbitalParam(mu0,totalV,R1,al);
phi0 = PhiOrbital(e,a,R1);
phi1 = PhiOrbital(e,a,R2);
phi_rot = phi0 + phi1; % Total true anomaly change

T_to_peregi = -1.*TimeTransfer(mu0,a,e,phi0,0);
T_to_cross  = TimeTransfer(mu0,a,e,0,phi1);
T = T_to_peregi + T_to_cross;
M  = TimeToMeanAnomaly(mu0,R2,phi_rot,-1.*T); % Initial phase of target planet
M0 = TimeToMeanAnomaly(mu0,R1,0,T); % End phase of source planet

phi1 = phi1 + phi0;
ip = 0;
deltaV = V - Vh;
PlotTrasferResults;

%% trasfer to acceleration
Vh   = VHomman(mu0,R1,R2);
Vmax = Vparapolic(mu0,R1)-1;
V = linspace(Vh,Vmax,100);

[a,e] = OrbitalParam(mu0,V,R1,pi./2);

phi0 = 0;
phi1 = PhiOrbital(e,a,R2);

T = TimeTransfer(mu0,a,e,phi0,phi1);
M = TimeToMeanAnomaly(mu0,R2,phi1,-1.*T); % Initial phase of target planet
M0 = TimeToMeanAnomaly(mu0,R1,0,T); % End phase of source planet


ip = 1;
deltaV = V - Vh;
PlotTrasferResults;

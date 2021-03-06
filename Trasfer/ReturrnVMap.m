% script for interplanetary trasfer
Constants
figure('Position',[100 100 600 900],'defaultAxesFontWeight','bold','defaultAxesFontsize',12);

%% trasfer to left turn
Vmin = 1e-3; % Homman trasfer
Vh   = VHomman(mu0,R2,R1)-1e-3;
V = linspace(Vmin,Vh,100);
perpV = V; % perpendicular velosity

al = atan(perpV ./ Vh ) + pi./2; % Initial velosity angle
totalV = sqrt(perpV.^2 + Vh.^2);

[a,e,Rp] = OrbitalParam(mu0,totalV,R2,al);
phi0 = PhiOrbital(e,a,R2);
phi1 = PhiOrbital(e,a,R1);
phi_rot = phi0 + phi1; % Total true anomaly change

T_to_peregi = -1.*TimeTransfer(mu0,a,e,phi0,0);
T_to_cross  = TimeTransfer(mu0,a,e,0,phi1);
T = T_to_peregi + T_to_cross;
M  = 2*pi + TimeToMeanAnomaly(mu0,R1,pi-phi_rot,-1*T); % Initial phase of target planet
M0 = pi+TimeToMeanAnomaly(mu0,R2,0,T); % End phase of source planet

phi1 =  pi - (phi0 + phi1);
ip = 0;
deltaV = V;
PlotTrasferResults;



%% trasfer to acceleration
Vmin = 1e-3; % homman trasfer
Vh = VHomman(mu0,R2,R1)-1e-3; % with trigonometrical correction, free falling
V  = linspace(Vmin,Vh,100);
parV = Vh - V; % paralel velocity after burn


[a,e, Rp] = OrbitalParam(mu0,parV,R2,pi./2);

phi0 = pi;
phi1 = PhiOrbital(e,a,R1);
phi1 = -1*phi1; % right side of the orbit

T = -1.*TimeTransfer(mu0,a,e,phi0,phi1);
M  = 2*pi + TimeToMeanAnomaly(mu0,R1,phi1,-1.*T); % Initial phase of target planet
M0 = pi+TimeToMeanAnomaly(mu0,R2,0,T); % End phase of source planet


ip = 1;
deltaV = V;
PlotTrasferResults;

% display wating time of specifict trasfers
% relatively ugly scripts
Constants;
figure;

% departure with accleration
Vh   = VHomman(mu0,R1,R2);
Vmax = Vparapolic(mu0,R1)-1;
V = linspace(Vh,Vmax,100);
[a,e] = OrbitalParam(mu0,V,R1,pi./2);
phi0 = 0;
phi1 = PhiOrbital(e,a,R2);
T = TimeTransfer(mu0,a,e,phi0,phi1);
M = TimeToMeanAnomaly(mu0,R2,phi1,-1.*T); % Initial phase of target planet
M0 = TimeToMeanAnomaly(mu0,R1,0,T); % End phase of source planet

deltaV1 = V - Vh;

W1 = M0 - 0;
W2 = phi1 - M;
DW1 = (W1-W2).*180/pi;
subplot(2,1,1);
plot(deltaV1, DW1);

%% return with acceleration
Vmin = 1e-3; % homman trasfer
Vh = VHomman(mu0,R2,R1)-1e-3; % with trigonometrical correction, free falling
V  = linspace(Vmin,Vh,101);
parV = Vh - V; % paralel velocity after burn
[a,e, Rp] = OrbitalParam(mu0,parV,R2,pi./2);
phi0 = pi;
phi1 = PhiOrbital(e,a,R1);
phi1 = -1*phi1; % right side of the orbit

T = -1.*TimeTransfer(mu0,a,e,phi0,phi1);
M  = 2*pi + TimeToMeanAnomaly(mu0,R1,phi1,-1.*T); % Initial phase of target planet
M0 = pi+TimeToMeanAnomaly(mu0,R2,0,T); % End phase of source planet

deltaV2 = V;

W2 = phi0 - M;
DW2 = (W2).*180/pi;

subplot(2,1,1)
hold on;
plot(deltaV2, DW2);

%% prepare the difference
ax = subplot(2,1,2);
[vr1,vr2] = meshgrid(deltaV1,deltaV2);
[dw1,dw2] = meshgrid(DW1,DW2);

delt = dw2-dw1;
delt(delt < 3 & delt > -3) = NaN;

pcolor(vr1, vr2, delt);
shading flat;
colorbar;

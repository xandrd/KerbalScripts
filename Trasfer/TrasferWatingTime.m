% display wating time of specifict trasfers
% relatively ugly scripts
Constants;
figure;

%% Departure, 2 cases (sa, st)
Vh   = VHomman(mu0,R1,R2);
Vmax = Vparapolic(mu0,R1)-1;
Vmax = Vh + 500;
V = linspace(Vh,Vmax,10);
[a,e] = OrbitalParam(mu0,V,R1,pi./2);

% departure with accleration (sa)
phi0 = 0;
phi1 = PhiOrbital(e,a,R2);
Tsa = TimeTransfer(mu0,a,e,phi0,phi1);
Msa = TimeToMeanAnomaly(mu0,R2,phi1,-1.*Tsa); % Initial phase of target planet

% departure with turn
perpV = V - Vh; % perpendicular velosity
al = atan(perpV ./ Vh ) + pi./2; % Initial velosity angle
totalV = sqrt(perpV.^2 + Vh.^2);
[a,e] = OrbitalParam(mu0,totalV,R1,al);
phi0 = PhiOrbital(e,a,R1);
phi1 = PhiOrbital(e,a,R2);
phi_rot = phi0 + phi1; % Total true anomaly change

T_to_peregi = -1.*TimeTransfer(mu0,a,e,phi0,0);
T_to_cross  = TimeTransfer(mu0,a,e,0,phi1);
Tst = T_to_peregi + T_to_cross;
Mst  = TimeToMeanAnomaly(mu0,R2,phi_rot,-1.*Tst); % Initial phase of target planet

deltaVs = V - Vh;

%% Return, 2 cases (da, dt)
Vmin = 1e-3; % homman trasfer
Vh = VHomman(mu0,R2,R1)-1e-3; % with trigonometrical correction, free falling
Vmax = 1000;
V  = linspace(Vmin,Vmax,11);

% return with acceleration (da)
parV = Vh - V; % paralel velocity after burn
[a,e] = OrbitalParam(mu0,parV,R2,pi./2);
phi0 = pi; % Start of the calculations at the point pi
phi1 = PhiOrbital(e,a,R1);
phi1 = -1*phi1; % right side of the orbit

Tda = -1.*TimeTransfer(mu0,a,e,phi0,phi1); % T2 is needed to calculate the encounter
Mda = 2*pi + TimeToMeanAnomaly(mu0,R1,phi1,-1.*Tda); % Initial phase of target planet

%% return with turn
perpV = V; % perpendicular velosity
al = atan(perpV ./ Vh ) + pi./2; % Initial velosity angle
totalV = sqrt(perpV.^2 + Vh.^2);
[a,e] = OrbitalParam(mu0,totalV,R2,al);
phi0 = PhiOrbital(e,a,R2);
phi1 = PhiOrbital(e,a,R1);
phi_rot = phi0 + phi1; % Total true anomaly change

T_to_peregi = -1.*TimeTransfer(mu0,a,e,phi0,0);
T_to_cross  = TimeTransfer(mu0,a,e,0,phi1);
Tdt = T_to_peregi + T_to_cross;
Mdt  = 2*pi + TimeToMeanAnomaly(mu0,R1,pi-phi_rot,-1*Tdt); % Initial phase of target planet

deltaVd = V;



%% waiting time
% the waiting time formula is:
% x = (pi(second calc) - M2 - (M1 + T1*(Wp2-Wp1)) ) ./ (Wp2-Wp1)
% but since Duna is moving slower Wp2-Wp1 is negative
% if x is negative than we need to what a full turn
% if x < 0 -> x = 2pi/|Wp2-Wp1| + x
% In this coordinate system we assume that planet 1 - Kerbin does not move

% grid and constants
dW = Wp2 - Wp1;
[dV1_arr, dV2_arr] = meshgrid(deltaVs, deltaVd);
Tp = abs(2*pi/dW)./24./3600; % maximum waiting time
Dlim = [120 140];

subplot(2,2,1)
% prepare block
W1 = (Msa + Tsa.*dW);
W2 = (pi - Mda);
[W1_arr, W2_arr] = meshgrid(W1, W2);

% calc block
x = ( W2_arr - W1_arr ) ./ dW;
x(x<0) = x(x<0) + abs(2*pi/dW);

% plot block
pcolor(dV1_arr, dV2_arr, x./3600./24);
colorbar; shading flat; ax = gca; ax.CLim = Dlim; colormap(jet);
title('sa da');

subplot(2,2,2);
% prepare block
W1 = (Mst + Tst.*dW);
W2 = (pi - Mda);
[W1_arr, W2_arr] = meshgrid(W1, W2);

% calc block
x = ( W2_arr - W1_arr ) ./ dW;
x(x<0) = x(x<0) + abs(2*pi/dW);

% plot block
pcolor(dV1_arr, dV2_arr, x./3600./24);
colorbar; shading flat; ax = gca; ax.CLim = Dlim; colormap(jet);
title('st da');

% % % % % % %
subplot(2,2,3)
% prepare block
W1 = (Msa + Tsa.*dW);
W2 = (pi - Mdt);
[W1_arr, W2_arr] = meshgrid(W1, W2);

% calc block
x = ( W2_arr - W1_arr ) ./ dW;
x(x<0) = x(x<0) + abs(2*pi/dW);

% plot block
pcolor(dV1_arr, dV2_arr, x./3600./24);
colorbar; shading flat; ax = gca; ax.CLim = Dlim; colormap(jet);
title('sa dt');


subplot(2,2,4)
% prepare block
W1 = (Mst + Tst.*dW);
W2 = (pi - Mdt);
[W1_arr, W2_arr] = meshgrid(W1, W2);

% calc block
x = ( W2_arr - W1_arr ) ./ dW;
x(x<0) = x(x<0) + abs(2*pi/dW);

% plot block
pcolor(dV1_arr, dV2_arr, x./3600./24);
colorbar; shading flat; ax = gca; ax.CLim = Dlim; colormap(jet);
title('st dt');


return

% display wating time of specifict trasfers
% relatively ugly scripts
Constants;

%% Departure, 2 cases (sa, st)
Vh   = VHomman(mu0,R1,R2);
Vmax = Vparapolic(mu0,R1)-1;
%Vmax = Vh + 20;
V = linspace(Vh,Vmax,3*100);
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
Vmax = Vh;
%Vmax = 60;
V  = linspace(Vmin,Vmax,3*101);

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
dV = dV1_arr + dV2_arr;

%% Total time 
Dlim = [0 250];
figure('Position',[100 100 800 600]);

subplot(2,2,1)
W1 = (Msa + Tsa.*dW);
W2 = (pi - Mda);
plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Start: accel., Return: accel.');

subplot(2,2,2);
W1 = (Mst + Tst.*dW);
W2 = (pi - Mda);
plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Start: turn, Return: accel.');

% % % % % % %
subplot(2,2,3)
W1 = (Msa + Tsa.*dW);
W2 = (pi - Mdt);
plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Start: accel., Return: turn');


subplot(2,2,4)
W1 = (Mst + Tst.*dW);
W2 = (pi - Mdt);
plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Start: turn, Return: turn');

%
axd = axes();
h = text(-0.1,0.4, '\Delta V_{return}, m/s'); h.Rotation = 90;
h = text(1.04,0.4, 'Waiting time, days'); h.Rotation = 90;
text(0.4,-0.1, '\Delta V_{start}, m/s');
axd.Visible = 'off';


%% Zoom
figure('Position',[100 100 800 300]);
Dlim = [130 140];

ax1 = subplot(1,2,1);
W1 = (Mst + Tst.*dW);
W2 = (pi - Mda);
[~,cb] = plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Start: turn, Return: accel.');
ylabel(cb,'Waiting time, days');

ax2 = subplot(1,2,2);
Dlim = [265 285];
%Dlim = [0 280];

[ch, cb] = plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Total time');
[Tst_arr, Tda_arr] = meshgrid(Tst,Tda);
ch.CData = ch.CData + (Tst_arr + Tda_arr)./24./3600;
ylabel(cb,'Mission time, days');


ax1.XLim = [0 200];
ax1.YLim = ax1.XLim;
ax2.XLim = ax1.XLim;
ax2.YLim = ax1.XLim;

axd = axes();
h = text(-0.1,0.4, '\Delta V_{return}, m/s'); h.Rotation = 90;
%h = text(1.04,0.4, 'Waiting time, days'); h.Rotation = 90;
text(0.4,-0.08, '\Delta V_{start}, m/s');
axd.Visible = 'off';

%% Time Zero
figure('Position',[100 100 800 250]);
Dlim = [0 10];

ax1 = subplot(1,3,1);
W1 = (Msa + Tsa.*dW);
W2 = (pi - Mdt);
[ch, cb] = plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Start: turn, Return: accel.');
nidx = ch.CData > 10;
ch.CData(nidx) = NaN; 
ylabel(cb,'Waiting time, days');

ax2 = subplot(1,3,2);
Dlim = [4500 6500];
[ch, cb] = plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('\Delta V budget');
ch.CData = dV1_arr + dV2_arr;
ch.CData(nidx) = NaN; 
ylabel(cb,'\Sigma\DeltaV, m/s','interpreter','tex');


ax3 = subplot(1,3,3);
Dlim = [70 100];
[ch, cb] = plot_trasfer_time(W1, W2, dW, dV1_arr, dV2_arr, Dlim);
title('Total time');
[Tsa_arr, Tdt_arr] = meshgrid(Tsa,Tdt);
ch.CData = ch.CData + (Tsa_arr + Tdt_arr)./24./3600;
ch.CData(nidx) = NaN; 
ylabel(cb,'Mission time, days');

ax1.Position(2) = ax1.Position(2) + 0.1;
ax1.Position(4) = ax1.Position(4) - 0.1;
ax2.Position(2) = ax2.Position(2) + 0.1;
ax2.Position(4) = ax2.Position(4) - 0.1;
ax3.Position(2) = ax3.Position(2) + 0.1;
ax3.Position(4) = ax3.Position(4) - 0.1;

axd = axes();
h = text(-0.1,0.4, '\Delta V_{return}, m/s'); h.Rotation = 90;
%h = text(1.04,0.4, 'Time, days'); h.Rotation = 90;
text(0.4,-0.03, '\Delta V_{start}, m/s');
axd.Visible = 'off';

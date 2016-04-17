% script for interplanetary trasfer
%% Constants
% Standard gravitational parameter m^3/s^2
mu_0 = 1.1723328E18; % Kerbol
mu_1 = 3.5316000E12; % Kerbin
%mu_2 = 3.0136321E11; % Duna
mu_2 = 8.1717302E12; % Eve


% Planetary orbits m
R_1 = 13599840256; %Kerbin
%R_2 = 20726155264; %Duna (note: orbit is not round)
%R_2 = 21783189163; % Duna App
%R_2 = 19669121365; % Duna Per
R_2 = 9832684544; %Eve (note: orbit is not round)


% Orbital period s
Tp1 = 9203545; % Kerbin
%Tp2 = 17315400; % Duna
Tp2 = 5657995; % Eve

% Planetary Velocities m/s
Vp_1 = 9284.5; %Kerbin
%Vp_2 = (7147 + 7915)./2; %Duna (note: room for error 768 m/s)
%Vp_2 = 7147; % Duna App
%Vp_2 = 7915; % Duna Per
Vp_2 = (10811 + 11029)./2; %Eve (note: room for error 218 m/s)


% Planet Radius m
Rad_1 = 600000; % Kerbin 
%Rad_2 = 320000; % Duna
Rad_2 = 700000; % Eve


% Atmosphere altitude
Hatm_1 = 70000; % Kerbin
%Hatm_2 = 50000; % Duna
Hatm_2 = 90000; % Eve


% Sphere of influence
Rsoi_1 = 84159286; % Kerbin
%Rsoi_2 = 47921949; %Duna
Rsoi_2 = 85109365; %Eve


%% Calculation paramters
% Interplanetary Velocities
V_max  = sqrt(2.* mu_0 .* (1./R_1 - 1./(R_1 + R_2))); %Minimal trasfer velocity (Hohmann orbit)
V_min  = 0; %Free falling
V_arr = linspace(V_min,V_max,100);

% Parking radiuses
Rp_1 = Rad_1 + Hatm_1 + 10000;
Rp_2 = Rad_2 + Hatm_2 + 10000;

% Parking velocities
vp_1 = sqrt(mu_1./Rp_1);
vp_2 = sqrt(mu_2./Rp_2);

% Minimal Velocity after escape
V_parabmolic = Vp_1 + VfromEconst(mu_1,sqrt(2).*vp_1,Rp_1,Rsoi_1);

%% Calculation of trasfer 1-2
[e,a] = OrbitalParamA(mu_0,V_arr,R_1);

% mean anomaly
cos_E = (a - R_2) ./ (e.*a);
E = acos(cos_E);

% period
n   = sqrt(mu_0./a.^3);
tau = (pi+(E - e.*sin(E))) ./ n;

%% SOI 1
v_soi_1 = Vp_1-V_arr;
[v1, deltaV_1] = SOI_V(mu_1, v_soi_1, Rsoi_1, Rp_1);

%% SOI 2
V_2 = VfromEconst(mu_0,V_arr,R_1,R_2);
cos_alpha = (R_1.*V_arr) ./ (R_2.*V_2);
v_soi_2  = sqrt(V_2.^2 + Vp_2.^2 - 2.*V_2.*Vp_2.*cos_alpha );
[~, deltaV_2] = SOI_V(mu_2, v_soi_2, Rsoi_2, Rp_2);
disp(min(deltaV_1 + deltaV_2));

%% Calculation of the wait period

%% Calculation of trasfer 2 - 1
V_min  = sqrt(2.* mu_0 .* (1./R_2 - 1./(R_1 + R_2))); %Max (optimal) trasfer velocity (Hohmann orbit)
V_max  = sqrt(2 .* mu_0 ./ R_2); %Parabolic velosity

V_arr = linspace(V_min,V_max,100);

[e,a] = OrbitalParamP(mu_0,V_arr,R_2);

% mean anomaly
cos_E = (a - R_1) ./ (e.*a);
% numerical error fix
cos_E(cos_E > 1) = 1;
E = acos(cos_E);

% period
n   = sqrt(mu_0./a.^3);
tau = (pi-(E - e.*sin(E))) ./ n;

%% SOI 2(to1)
v_soi_2 = V_arr-Vp_2;
[~, deltaV_3] = SOI_V(mu_2, v_soi_2, Rsoi_2, Rp_2);

%% SOI 1(return)
V_3 = VfromEconst(mu_0,V_arr,R_2,R_1);
cos_alpha = (R_2.*V_arr) ./ (R_1.*V_3);
v_soi_1  = sqrt(V_3.^2 + Vp_1.^2 - 2.*V_3.*Vp_1.*cos_alpha );
[~, deltaV_4] = SOI_V(mu_1, v_soi_1, Rsoi_1, Rp_1);
disp(min(deltaV_3));
disp(min(deltaV_3 + deltaV_4));





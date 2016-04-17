%% Constants
% Standard gravitational parameter m^3/s^2
mu0 = 1.1723328E18; % Kerbol
mu1 = 3.5316000E12; % Kerbin
mu2 = 3.0136321E11; % Duna
%mu_2 = 8.1717302E12; % Eve


% Planetary orbits m
R1 = 13599840256; %Kerbin
R2 = 20726155264; %Duna (note: orbit is not round)
%R_2 = 21783189163; % Duna App
%R_2 = 19669121365; % Duna Per
%R_2 = 9832684544; %Eve (note: orbit is not round)

% % Orbital period s
% Tp1 = 9203545; % Kerbin
% Tp2 = 17315400; % Duna
% %Tp2 = 5657?995; % Eve
% 
% % Angular velosity rad/s
% Wp1 = 2*pi/Tp1; % Kerbin
% Wp2 = 2*pi/Tp2; % Duna

% Planetary Velocities m/s
Vp1 = 9284.5; %Kerbin
Vp2 = (7147 + 7915)./2; %Duna (note: room for error 768 m/s)
%Vp_2 = 7147; % Duna App
%Vp_2 = 7915; % Duna Per
%V_2 = (10?811 + 11?029)./2; %Eve (note: room for error 218 m/s)

% Planet Radius m
Rad1 = 600000; % Kerbin 
Rad2 = 320000; % Duna
%Rad_2 = 700000; % Eve

% Atmosphere altitude
Hatm1 = 70000; % Kerbin
Hatm2 = 50000; % Duna
%Hatm_2 = 90000; % Eve

% Sphere of influence
Rsoi1 = 84159286; % Kerbin
Rsoi2 = 47921949; %Duna
%Rsoi2 = 85109365; %Eve

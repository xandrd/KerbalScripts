%% Load constants
Constants;
clc; % clear screen
%% Oribal velocity in Kerbin SOI
H = 80E3; % Initial orbit
V_LEO  =  Vround(mu1, Rad1 + H);
V_Esc  =  Vparapolic(mu1, Rad1 + H);
%V_Esc  =  VOrbital(mu1, Rsoi1, Rad1 + H);
V_SOI  =  VEconst(mu1,V_Esc,Rad1 + H,Rsoi1);
deltaV_Esc = abs(V_LEO - V_Esc);

%% Velocity outside of Kerbin SOI
V_Kerbin = Vround(mu0, R1);
V_Homman = VHomman(mu0,R1,R2);
%% Printf
fprintf('== Kerbin ==\n');
fprintf('Orbit altitude:\t\t\t %d km\nLEO velocity:\t\t\t %3.1f m/s\nPlanetary velocity:\t\t %3.1f m/s\nHomman orbit velocity:\t %3.1f m/s (+ %3.1f m/s)\n',...
     H/1e3, V_LEO, V_Kerbin, V_Homman, abs(V_Kerbin - V_Homman)   );

%% velocity after SOI burn outside
V_exit = V_Kerbin + V_SOI;
deltaV_Homman = abs(V_exit - V_Homman);

fprintf('== Burn after SOI ==\n')
fprintf('Escape velocity:\t\t %3.1f m/s (deltaV: %3.1f m/s) \nSOI velocity:\t\t\t %3.1f m/s \n',...
     V_Esc, deltaV_Esc, V_SOI);
fprintf('Exit velocity:\t\t\t %3.1f m/s\nHomman trasfer:\t\t\t (+deltaV: %3.1f m/s) \nTotal delta V:\t\t\t %3.1f m/s\n',...
    V_exit, deltaV_Homman, deltaV_Esc + deltaV_Homman );

%% velocity after SOI burn inside
V_SOIGo = abs(V_Homman - V_Kerbin);
V_EscGo  = VEconst(mu1,V_SOIGo,Rsoi1,Rad1 + H);
deltaV_EscGo = abs(V_EscGo - V_LEO);
V_exitGo = V_SOIGo + V_Kerbin;

fprintf('== Burn at LEO ==\n');
fprintf('Escape velocity:\t\t %3.1f m/s (deltaV: %3.1f m/s) \nSOI velocity:\t\t\t %3.1f m/s \n',...
     V_EscGo, deltaV_EscGo, V_SOIGo);
fprintf('Exit velocity:\t\t\t %3.1f m/s\nTotal delta V:\t\t\t %3.1f m/s\n',...
    V_exitGo, deltaV_EscGo );

%% Plots of delta V efficenty:
v = [1:1:2000];

v_soi = VEconst(mu1,V_Esc+v,Rad1 + H,Rsoi1);

V_par  = v_soi - V_SOI;
V_sign = sign(v_soi.^2 - (V_Homman - V_Kerbin).^2);
V_perp = V_sign.*sqrt( V_sign.*(v_soi.^2 - (V_Homman - V_Kerbin).^2) );


figure('Position',[100 100 450 600],'defaultLineLineWidth',2);
ax = subplot(3,1,[1:2]);
hold on;
plot(v,v);
plot(v,V_par);
plot(v,V_perp);
ax.YLim = [-1000 4000];
ax.XTick = [0:200:ax.XLim(end)];
grid on;
title('Velocity augmentation'); ylabel('V, m/s');
legend('Burn after SOI','Collinear acceleration','Perpendicular acceleration','Location','best');
ax = subplot(3,1,3);
hold on;
plot(v,100.*v./v);
plot(v,100.*V_par./v);
plot(v,100.*V_perp./v);
title('Effecency'); xlabel('\Delta V, m/s'); ylabel('%');
ax.YLim = [-500 900];
ax.YTick = [-500:200:900];
ax.XTick = [0:200:ax.XLim(end)];
grid on;
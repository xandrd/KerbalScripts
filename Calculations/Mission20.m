%% Mission 20 (Kerbal-Go)
% Kerbin, Mun, Minmus, Sun

%% Constants
global Kerbin Mun Minmus Kerbol

% define mu constants
Kerbin.mu = 3.531600e12;
Minmus.mu = 1.765800e9;
Mun.mu = 6.5138398e10;
Kerbol.mu = 1.1723328e18;

% moons and planets radii

Kerbin.R = 600e3;
Minmus.R = 60e3;
Mun.R = 200e3;

% Position
Kerbin.a = 13599840256;
Minmus.a = 47e6;
Mun.a = 12e6;

Minmus.h = Minmus.a - Kerbin.R;
Mun.h = Mun.a - Kerbin.R;

% SOI
Kerbin.soi = 84159286;
Minmus.soi = 2247428;
Mun.soi = 2429559;

% Orbits 
Klo = r(Kerbin,80e3);
mlo = r(Minmus,10e3);
Mlo = r(Mun,14e3);

Kho = r(Kerbin,Kerbin.soi*0.9);
mho = r(Minmus,Minmus.soi*0.9);
Mho = r(Mun,Mun.soi*0.9);

% Randevo orbits
KRl = r(Kerbin,70e3);
KRh = r(Kerbin,120e3);

%reentry orbit
Kro = r(Kerbin,30e3);

%reentry velocity
vp_K_Kro_Ksoi = VOrbital(Kerbin.mu,(Kerbin.soi+Kro)/2,Kro);
va_K_Kro_Ksoi = VOrbital(Kerbin.mu,(Kerbin.soi+Kro)/2,Kerbin.soi);


% Velocity
Kerbin.v = Vround(Kerbol.mu,Kerbin.a);
Minmus.v = Vround(Kerbin.mu, Minmus.a);
Mun.v = Vround(Kerbin.mu, Mun.a);

%% notation
%<velocity>_<celestial>_<p>_<a>
%[velocity]: (a|p), v(p) - default for round
%[Celestial]: K, m, M, S
%[a, p]: Klo, mlo, Mlo, Ksoi, msoi, Msoi  Kho, mho, Mho, m, M
% round - vp_<celestial>_<p>

%% 
% Orbital velocities
vp_K_Klo = Vround(Kerbin.mu, Klo);
vp_m_mlo = Vround(Minmus.mu, mlo);
vp_M_Mho = Vround(Mun.mu, Mho);

% Hohmann trasfer velocities
vp_K_Klo_M = VOrbital(Kerbin.mu, (Klo+Mun.a)/2, Klo);
va_K_Klo_M = VOrbital(Kerbin.mu, (Klo+Mun.a)/2, Mun.a);

vp_K_Klo_m = VOrbital(Kerbin.mu, (Klo+Minmus.a)/2, Klo);
va_K_Klo_m = VOrbital(Kerbin.mu, (Klo+Minmus.a)/2, Minmus.a);

vp_K_M_m = VOrbital(Kerbin.mu, (Mun.a+Minmus.a)/2, Mun.a);
va_K_M_m = VOrbital(Kerbin.mu, (Mun.a+Minmus.a)/2, Minmus.a);

% Kerbol transfer velocities
vp_K_Klo_Ksoi = VOrbital(Kerbin.mu,(Kerbin.soi+Klo)/2,Klo);
vp_K_m_Ksoi   = VOrbital(Kerbin.mu,(Kerbin.soi+Minmus.a)/2,Minmus.a);
vp_K_M_Ksoi   = VOrbital(Kerbin.mu,(Kerbin.soi+Mun.a)/2,Mun.a);

va_K_Klo_Ksoi = VOrbital(Kerbin.mu,(Kerbin.soi+Klo)/2,Kerbin.soi);
va_K_m_Ksoi   = VOrbital(Kerbin.mu,(Kerbin.soi+Minmus.a)/2,Kerbin.soi);
va_K_M_Ksoi   = VOrbital(Kerbin.mu,(Kerbin.soi+Mun.a)/2,Kerbin.soi);

% soi transfer velocities
vp_m_mlo_msoi = VOrbital(Minmus.mu,(mlo+Minmus.soi)/2,mlo);
va_m_mlo_msoi = VOrbital(Minmus.mu,(mlo+Minmus.soi)/2,Minmus.soi);

vp_M_Mho_Msoi = VOrbital(Mun.mu,(Mho+Mun.soi)/2,Mho);
va_M_Mho_Msoi = VOrbital(Mun.mu,(Mho+Mun.soi)/2,Mun.soi);

%% Kerbin->Minmus
delta1 = abs(vp_K_Klo_m - vp_K_Klo);
va_m_mlo_enter = Minmus.v - va_K_Klo_m;
vp_m_mlo_enter = VEconst(Minmus.mu,va_m_mlo_enter,Minmus.soi,mlo);
delta2 = abs(vp_m_mlo_enter - vp_m_mlo);
delta = delta1 + delta2;
t_Klo_m = ts(t(Kerbin,(Klo + Minmus.a)/2)/2);
fprintf('Kerbin Klo->Minmus mlo [%.0f m/s] = %.0f+%.0fm/s, travel: %s \n', delta, delta1, delta2, t_Klo_m);

%% Kerbin->Mun
delta1 = abs(vp_K_Klo_M - vp_K_Klo);
va_M_Mho_enter = Mun.v - va_K_Klo_M;
vp_M_Mho_enter = VEconst(Mun.mu,va_M_Mho_enter,Mun.soi,Mho);
delta2 = abs(vp_M_Mho_enter - vp_M_Mho);
delta = delta1 + delta2;
t_Klo_M = ts(t(Kerbin,(Klo + Mun.a)/2)/2);
fprintf('Kerbin Klo->Mun Mho [%.0f m/s] = %.0f+%.0fm/s, travel: %s\n', delta,delta1,delta2,t_Klo_M);

%% Kerbin->Sun
deltav = abs(vp_K_Klo - vp_K_Klo_Ksoi);
t_Klo_Ksoi = ts(t(Kerbin,(Klo+Kerbin.soi)/2)/2);
fprintf('Kerbin Klo->Kerbol Ksoi [%.0fm/s], travel: %s \n',delta,t_Klo_Ksoi);

%% Minmus->Mun
va_m_mlo_exit = va_K_M_m + Minmus.v;
vp_m_mlo_exit = VEconst(Minmus.mu,va_m_mlo_exit,Minmus.soi,mlo);
if(vp_m_mlo_exit < vp_m_mlo_msoi), vp_m_mlo_exit = vp_m_mlo_msoi; fprintf('(Minmus-Mun) overestimated transfer'); end;
delta1 = abs(vp_m_mlo - vp_m_mlo_exit);

va_M_Mho_enter = vp_K_M_m - Mun.v;
vp_M_Mho_enter = VEconst(Mun.mu,va_M_Mho_enter,Mun.soi,Mho);
delta2 = abs(vp_M_Mho - vp_M_Mho_enter);
delta = delta1 + delta2;
t_M_m = ts(t(Kerbin,(Minmus.a + Mun.a)/2)/2);
fprintf('Minmus mlo->Mun Mho [%.0fm/s] = %.0f+%.0fm/s, travel: %s \n',delta,delta1,delta2, t_M_m);
%% Mun->Minmus
va_M_Mho_exit = vp_K_M_m - Mun.v;
vp_M_Mho_exit = VEconst(Mun.mu,va_M_Mho_exit,Mun.soi,Mho);
if(vp_M_Mho_exit < vp_M_Mho_Msoi), vp_M_Mho_exit = vp_M_Mho_Msoi; fprintf('(Mun-Minmus) overestimated transfer\n'); end;
delta1 = abs(vp_M_Mho - vp_M_Mho_exit);

va_m_mlo_enter = va_K_M_m + Minmus.v;
vp_m_mlo_enter = VEconst(Minmus.mu,va_m_mlo_enter,Minmus.soi,mlo);
delta2 = abs(vp_m_mlo - vp_m_mlo_enter);
delta = delta1 + delta2;
fprintf('Mun Mho->Minmus mlo [%.0fm/s] = %.0f+%.0fm/s, travel: %s\n',delta,delta1,delta2, t_M_m);

%% Minmus->Sun
va_m_mlo_exit = vp_K_m_Ksoi - Minmus.v;
vp_m_mlo_exit = VEconst(Minmus.mu,va_m_mlo_exit,Minmus.soi,mlo);
delta = abs(vp_m_mlo - vp_m_mlo_exit);
t_m_Ksoi = ts(t(Kerbin,(Minmus.a + Kerbin.soi)/2)/2);
fprintf('Minmus mlo->Kerbol Ksoi [%.0fm/s], travel: %s \n',delta,t_m_Ksoi);

%% Mun->Sun
va_M_Mho_exit = vp_K_M_Ksoi - Mun.v;
vp_M_Mho_exit = VEconst(Mun.mu,va_M_Mho_exit,Mun.soi,Mho);
delta = abs(vp_M_Mho - vp_M_Mho_exit);
t_M_Ksoi = ts(t(Kerbin,(Mun.a + Kerbin.soi)/2)/2);
fprintf('Mun Mho->Kerbol Ksoi [%.0fm/s], travel: %s\n',delta,t_M_Ksoi);

%% [Kerbin-Sun]-Kerbin
delta = va_K_Klo_Ksoi + va_K_Kro_Ksoi;
t_Kro_Ksoi = ts(t(Kerbin,(Kerbin.soi + Kro)/2)/2);
fprintf('Kerbin->Kerbol->Kerbol Kro [%.0fm/s], travel: %s\n',delta, t_Kro_Ksoi);

%% [Mun->Sun]->Kerbin
delta = va_K_M_Ksoi + va_K_Kro_Ksoi;
fprintf('Mun->Kerbol->Kerbol Kro [%.0fm/s], travel: %s\n',delta, t_Kro_Ksoi);

%% [Minmus->Sun]->Kerbin
delta = va_K_m_Ksoi + va_K_Kro_Ksoi;
fprintf('Minmus->Kerbol->Kerbol Kro [%.0fm/s], travel: %s\n',delta, t_Kro_Ksoi);

%% Reentry
fprintf('Reentry Kerbol Kro v = [%.0fm/s]\n',vp_K_Kro_Ksoi);

%% Randevu
vp_K_KRl = Vround(Kerbin.mu,KRl);
vp_K_KRh = Vround(Kerbin.mu,KRh);
vp_K_KRl_KRh = VOrbital(Kerbin.mu,(KRl+KRh)/2,KRl);
va_K_KRl_KRh = VOrbital(Kerbin.mu,(KRl+KRh)/2,KRh);
delta1 = abs(vp_K_KRl - vp_K_KRl_KRh);
delta2 = abs(vp_K_KRh - va_K_KRl_KRh);
delta = 4*(delta1+delta2);
fprintf('Randevu Kerbol KRl KRh v=[%.0fm/s]=2x(2x(%.0f + %.0f))m/s \n',delta,delta1,delta2);

%% Minmus landing
va_m_0_mlo = VOrbital(Minmus.mu,(mlo+Minmus.R)/2,mlo);
vp_m_0_mlo = VOrbital(Minmus.mu,(mlo+Minmus.R)/2,Minmus.R);
delta1 = abs(vp_m_mlo - va_m_0_mlo);
delta2 = vp_m_0_mlo;
delta = delta1+delta2;
fprintf('Suicide Minmus landing v=[%.0fm/s]=%.0f + %.0fm/s \n',delta,delta1,delta2);

%% Orbital times
t_m = ts(t(Kerbin,Minmus.a));
fprintf('Minmus orbital period: %s \n',t_m);
t_M = ts(t(Kerbin,Mun.a));
fprintf('Mun orbital period: %s \n',t_M);
t_Klo = ts(t(Kerbin,Klo));
fprintf('Kerbin Klo: %s \n',t_Klo);
t_mlo = ts(t(Minmus,mlo));
fprintf('Minmus mlo: %s \n',t_mlo);
t_Mho = ts(t(Mun,Mho));
fprintf('Mun Mho: %s \n',t_Mho);


%% delta V

% p1 = 1207E3
% a1 = 2886E3
% p2 = 2886E3
% a2 = 2886E3

p1 = 100E3
a1 = 100E3
p2 = 100E3
a2 = 5000E3


R  = p1

Rk = 0.6E6;

mu = 3.53E12;

R  = R + Rk;
A1 = (a1 + p1)/2+Rk;
A2 = (a2 + p2)/2+Rk;

V_parab = sqrt(mu * (2/R))

V1= sqrt(mu * (2/R - 1/A1))
V2= sqrt(mu * (2/R - 1/A2))
   
abs(V1 - V2)
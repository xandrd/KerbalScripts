%% delta V

p1 = 100E3
a1 = 100E3

%p1 = 339E3
%a1 = 339E3


R  = p1

Rk = 0.6E6;
mu = 3.53E12;

%Rk = 0.06E6;
%mu = 1.7658000E9;


R  = R + Rk;
A1 = (a1 + p1)/2+Rk;


V1= sqrt(mu * (2/R - 1/A1))
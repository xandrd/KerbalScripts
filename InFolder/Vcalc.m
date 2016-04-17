function [ V1 ] = Vcalc( R1, R2 , varargin)
%VCALC calculates V for Kerbin

if(nargin == 2)
    Body = 'Kerbin';
else
    Body = varargin{1};
end

p1 = R1;
a1 = R2;

R  = p1;

%p1 = 339E3
%a1 = 339E3


switch(Body)
    case 'Kerbin'
    Rk = 0.6E6;
    mu = 3.53E12;
    case 'Minmus'
    Rk = 60E3;
    mu = 1.7658000E9;
end
        

%Rk = 0.06E6;
%mu = 1.7658000E9;


R  = R + Rk;
A1 = (a1 + p1)./2+Rk;


V1= sqrt(mu .* (2./R - 1./A1));

end


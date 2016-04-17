function [ A ] = AfromT( T, varargin )
%AFROMT Cslculate asix from time

if(nargin == 1)
    Body = 'Kerbin';
else
    Body = varargin{1};
end


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

A = 2.*((mu.*( (T.^2) ./ (4.*pi.^2) )).^(1/3) - Rk);


end


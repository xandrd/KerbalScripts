function V1  = VHomman( mu, R1, R2 )
%VHOMMAN Get velosity of Homman transfer at the point R1 (peregi or apogi
%only)
a = (R1 + R2) ./2;
V1 = VOrbital(mu,a,R1);

end


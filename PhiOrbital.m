function phi = PhiOrbital( e, a, R )
%PHI get true anomaly of at the position R

cos_phi = a.*(1-e.^2) ./ (e.*R) - 1./e;
cos_phi (cos_phi > 1) = NaN;
cos_phi (cos_phi < -1) = NaN;
phi = acos(cos_phi);

end


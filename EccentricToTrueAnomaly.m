function phi  = EccentricToTrueAnomaly( e, E )
%MEANTOTRUEANOMALY Calculate True anomaly from Eccentric

cos_phi = (e - cos(E)) ./ (e.*cos(E) - 1);
phi = acos(cos_phi);

end


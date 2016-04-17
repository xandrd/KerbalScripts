function E  = TrueToEccentricAnomaly(  e, phi )
%TRUETOMEANANOMALY Calculate Mean anomaly from true
cos_E = (e + cos(phi)) ./ (1+e.*cos(phi));
E = acos(cos_E);
end


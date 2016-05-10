function phi  = MeanToTrueAnomaly( e, M)
%MEANTOTRUEANOMALY Calculate true anomlay from mean
E = MeanToEccentricAnomaly(e, M);
phi = EccentricToTrueAnomaly(e, E);
end


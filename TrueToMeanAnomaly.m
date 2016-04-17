function M = TrueToMeanAnomaly( e, phi )
%TRUETOMEANANOMALY Calculate mean anomaly
E = TrueToEccentricAnomaly(e, phi);
M = EccentricToMeanAnomaly(e, E);
end


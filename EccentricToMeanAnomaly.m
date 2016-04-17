function M  = EccentricToMeanAnomaly( e, E)
%ECCENTRICTOMEANANOMALY Calculate mean anomaly from Eccentric
    M = E - e.*sin(E);
end


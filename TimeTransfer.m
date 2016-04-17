function T = TimeTransfer( mu, a, e, phi1, phi2 )
%TIMETRANSFER Calcaulte trasfer time based on the orbital parameters and
%true anomalies

M0 = TrueToMeanAnomaly(e, phi1);
M1 = TrueToMeanAnomaly(e, phi2);

T = TimeMeanAnomaly( mu, a, M0, M1 );

end


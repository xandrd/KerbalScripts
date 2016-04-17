function T = TimeMeanAnomaly( mu, a, M0, M1 )
%TIMEMEANANOMALY Calculate time between mean anomalies

n = sqrt(mu./a.^3);
T = (M1 - M0)./n;

end


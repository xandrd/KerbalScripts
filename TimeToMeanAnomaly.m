function M1 = TimeToMeanAnomaly( mu, a, M0, T )
%TIMETOMEANANOMALY Calculate chnage of mean anomaly from time
n = sqrt(mu./a^3);
M1 = M0 + n.*T;
end


function [ E ] = MeanToEccentricAnomaly( e, M )
%MEANTOECCENTRICANOMALY firs approximation of Mean To Eccentirc anomaly
% ??? ?. ???????? ?? ???????. 1981
% Roi A. Dvizhenie po orbitam. 1981

% first order
E0 = M;
% second
E = M +e.*sin(E0);

counter = 0;
while( abs(E0 - E) > 1E-4 || counter > 10)
    E0 = E;
    E = M +e.*sin(E0);
    counter = counter+1;
end

end


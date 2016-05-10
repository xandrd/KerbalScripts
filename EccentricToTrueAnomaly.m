function phi  = EccentricToTrueAnomaly( e, E )
%MEANTOTRUEANOMALY Calculate True anomaly from Eccentric



cos_phi = (e - cos(E)) ./ (e.*cos(E) - 1);
phi = acos(cos_phi);

    % correction of the anomaly to full 2*pi
    if(rem(E,2*pi) >= pi)
        phi = 2*pi - phi;
    end
end


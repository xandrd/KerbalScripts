function V = VOrbital( mu, a, R )
%VORBITAL get orbital velosity by position

V = sqrt(mu.* (2./R - 1./a) );

end


function res = a(Obj, a, p)
% returns semi-major for orbits around Obj
% altitudes: a - apoapsis, p - periapsis
    res = ( (Obj.R + a) + (Obj.R + p) ) / 2;
end

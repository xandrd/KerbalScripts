function [ t_str ] = ts( T )
%return formated string from orbital period

Tmin = floor(T/60);
Dy  = floor(Tmin/60/6);
Hr  = floor((Tmin - Dy*6*60)/60);
Mn  = floor(Tmin - Dy*6*60 - Hr*60);

t_str = sprintf('%dd %dh %dm',Dy,Hr,Mn);



end


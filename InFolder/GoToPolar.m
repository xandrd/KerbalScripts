% calculate orbit to the polar

SOI = 84159000;
R   = 100E3:10E3:SOI;


V1 = Vcalc(100E3,100E3);

V_transfer = Vcalc(100E3,R);
V_orbit    = Vcalc(R,100E3);
V_orbit_1    = Vcalc(R,343E3);
V_orbit_2    = Vcalc(343E3,R);
V_orbit_3    = Vcalc(343E3,343E3);

%V_result = abs(V_transfer - V1).*2 + sqrt(2).*V_orbit;
V_result = abs(V_transfer - V1) + sqrt(2).*V_orbit + abs(V_orbit_1 - V_orbit) + abs(V_orbit_2 - V_orbit_3);

hf=figure;
hf.Position(3) = 1100;
subplot(1,2,1)
plot(R./1e3,V_result,'.');
set(gca,'XScale','log');
ylabel('\Delta V, m\\s');
xlabel('Orbit hight, km');
%set(gca,'YScale','log','YLim',[1000 3000]);

subplot(1,2,2)
plot(R./1e3,V_result,'.');
set(gca,'XScale','linear','YLim',[1700 2000],'XLim',[1e3 8e4]);
ylabel('\Delta V, m\\s');
xlabel('Orbit hight, km');
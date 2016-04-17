% calculation of reentry
t_70 = 2*pi*sqrt( (70E3+600E3)^3 / (3.53E12) );

v0 = 2403; % inital orbital speed
d = 0.2;   % drag of the part
tp = t_70 / 2;% time to periapse

h0 = 70E3; % initial altitude
hv0 = 0; % vertical initial velocity
p0 = 0; % initial phase

R = 600E3; % Kerbin Radius
H = 5000; % preasure altitute
a = 0.008; %magic coeff of drag to mass relation
ro = 1.22309; % preasure coefficient
g = 9.8; %Gravity const

W = 2*pi./(6*3600);

dt = 0.1;
t = [0:dt:3*60];

h=nan(size(t));
v=nan(size(t));
w=nan(size(t));

h(1) = h0;
v(1) = hv0;
w(1) = v0 / R;
p(1) = p0;

for it=2:numel(t)
    h(it) = dt * v(it-1) + h(it-1);
    v(it) = -1*dt*g + dt*0.5*ro*exp(-1*h(it-1)/H)*(v(it-1)^2)*d*a + v(it-1);
    w(it) = -dt*0.5*ro*exp(-1*h(it-1)/H)*((R*w(it-1))^2)*d*a/R + w(it-1);
    p(it) = dt * w(it-1) + p(it-1);
end
[~,h_idx] = min(abs(h - 30E3));
[~,p_idx] = min(abs(h));

subplot(2,2,1)
plot(t,h,'-',[t(1) t(end)],[0 0],'g--',t(h_idx),h(h_idx),'kx'); ylabel('h, m');xlabel('time, s');
grid on;
subplot(2,2,2)
plot(t,v,'-',t,w*R,'r-',t(h_idx),v(h_idx),'xk',t(h_idx),w(h_idx)*R,'xk'); ylabel('v, m/s');xlabel('time, s');
grid on;
legend('v_y','v_x')
subplot(2,2,3)
plot(t,w*180/pi); ylabel('\omega, \circ');xlabel('time, s');
grid on;
subplot(2,2,4)
plot(t,p*180/pi,'-',t(p_idx),p(p_idx)*180/pi,'gx',t(h_idx),p(h_idx)*180/pi,'xk'); ylabel('\phi, \circ');xlabel('time, s');
title(sprintf('\\phi = %2.1f\\circ, \\Delta\\phi = %2.1f\\circ,',p(p_idx)*180/pi, (abs(p(p_idx)-p(h_idx)) + W*(abs(t(p_idx)-t(h_idx)) + tp))*180/pi ));
grid on;
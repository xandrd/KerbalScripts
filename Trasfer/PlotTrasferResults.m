if(ip == 1), LEGEND = true; else LEGEND = false; end;
XLimit = [min(deltaV), max(deltaV)]; % ??
ax = subplot(4,1,1); hold on;

Cl = ax.ColorOrder;

plot(deltaV,T/60/60/24,'LineWidth',2,'Color',Cl(ip+1,:));
ax.XLim = XLimit; 
if(LEGEND), legend('Orbit left turn','Orbit right acceleration', 'location','best'); end;
%ax.YLim = [min(T), max(T)];
xlabel('\Delta V, m/s'); ylabel('Time, d');
ax = subplot(4,1,2); hold on;
plot(deltaV,M.*180./pi,'LineWidth',2,'Color',Cl(ip+1,:));
ax.XLim = XLimit;
%ax.YLim = [min(M), max(M)]*180/pi;
xlabel('\Delta V, m/s'); ylabel('Planet \Phi_0');
ax = subplot(4,1,3); hold on;
plot(deltaV,M0.*180./pi,'LineWidth',1,'LineStyle','--','Color',Cl(ip+1,:));
ax.XLim = XLimit;
%ax.YLim = [min(M), max(M)]*180/pi;
xlabel('\Delta V, m/s'); ylabel('Planet \Phi_0');
ax = subplot(4,1,4); hold on;
plot(deltaV,phi1.*180./pi,'LineWidth',2,'Color',Cl(ip+1,:));
ax.XLim = XLimit;
%ax.YLim = [min(phi1), max(phi1)]*180/pi;
xlabel('\Delta V, m/s'); ylabel('Intersection phase \phi_1 + \phi_0');
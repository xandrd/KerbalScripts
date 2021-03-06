if(ip == 1), LEGEND = true; else LEGEND = false; end;
XLimit = [min(deltaV), max(deltaV)]; % ??
ax = subplot(4,1,1); hold on;

Cl = ax.ColorOrder;

plot(deltaV,T/60/60/24,'LineWidth',2,'Color',Cl(ip+1,:));
ax.XLim = XLimit;
if(LEGEND), legend('Left turn','Right accel.', 'location','best'); end;
ax.YLim = [0 100]; ax.YTick = [0:25:100];
xlabel('\Delta V, m/s'); ylabel('Time, d');
ax = subplot(4,1,2); hold on;  
plot(deltaV,M.*180./pi,'LineWidth',2,'Color',Cl(ip+1,:));
ax.XLim = XLimit; 
%ax.YLim = [0 100]; ax.YTick = [0:25:100];
%ax.YLim = [50 450]; ax.YTick = [50:100:450];
xlabel('\Delta V, m/s'); ylabel('Initial \newline Planet \Phi_0');
ax = subplot(4,1,3); hold on; 
plot(deltaV,M0.*180./pi,'LineWidth',1,'LineStyle','--','Color',Cl(ip+1,:));
ax.XLim = XLimit;  
%ax.YLim = [50 300]; ax.YTick = [50:50:300];
%ax.YLim = [200 350]; ax.YTick = [200:25:350];
xlabel('\Delta V, m/s'); ylabel('Source \newline Planet \Phi_{end}');
ax = subplot(4,1,4); hold on;  
plot(deltaV,phi1.*180./pi,'LineWidth',2,'Color',Cl(ip+1,:));
ax.XLim = XLimit; 
%ax.YLim = [50 200]; ax.YTick = [50:50:200];
%ax.YLim = [0 200]; ax.YTick = [0:50:200];
xlabel('\Delta V, m/s'); ylabel('Intersection \newline phase \phi_1 + \phi_0');
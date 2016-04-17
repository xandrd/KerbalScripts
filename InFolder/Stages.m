%% plot deltaV and TWR
M_fuel = [1:1:100];
M_0 = 41.8;
Isp = 320;F_eng = 215;M_eng = 1.25;
%Isp = 300;F_eng = 50;M_eng = 0.5;
%Isp = 325;F_eng = 230;M_eng = 1.5;
%Isp = 350;F_eng = 90;M_eng = 0.75;
Isp = 320;F_eng = 350;M_eng = 2;
TWR_max = 1.5;

g = 9.8;
a = 1/9;
Narr = [1 3];
N = 3;

    deltaV = Isp * g * log( (M_0 + N * (M_eng + M_fuel * (a+1))) ./ (M_0 + N * (M_eng + M_fuel * (a))));
    TWR    = (N * F_eng) ./ (g * (M_0 + N * (M_eng + M_fuel * (a+1))) ) ;
    max(deltaV( TWR > TWR_max ) )
    max((a+1)*M_fuel( TWR > TWR_max ) )
    
    

return;

figure;
for n = 1:numel(Narr),
    subplot(1,numel(Narr),n); N = Narr(n);
    
    deltaV = Isp * g * log( (M_0 + N * (M_eng + M_fuel * (a+1))) ./ (M_0 + N * (M_eng + M_fuel * (a))));
    TWR    = (N * F_eng) ./ (g * (M_0 + N * (M_eng + M_fuel * (a+1))) ) ;
    [ax,h1,h2] = plotyy(M_fuel,deltaV,M_fuel,TWR); grid on;
    ax(1).YTick = [0:500:3000]; ax(2).YTick = [0:0.5:5];
    ax(1).YLim = [0 3000]; ax(2).YLim  = [0 5];
    legend('\Delta V','TWR');
    title(['N = ' num2str(N)]);
    
end

%% terminal velocity
%M_stage = 4.832-0.9;
M_stage = 9.882-0.3;
M_para = [0.15:0.15:1.5];
D_stage = 0.1;
D_para  = 500;
g = 9.8; p = 1.22; a = 0.008;

D_total = ( M_stage.*D_stage + M_para*D_para ) ./ (M_stage+M_para);
v_terminal = sqrt(2.*g./p./a./D_total);

figure;
plot(M_para,v_terminal,'o');xlabel('M_{para}'); ylabel('V_{terminal} m/s');
title(['Min N = ' num2str(min(find(v_terminal < 7)))]);
%% min para on mass
M_stage = [0.1:0.1:20];
N_para  = [1:1:10];
M_para = 0.15;
D_stage = 0.1;
D_para  = 500;
v_term  = 12;
g = 9.8; p = 1.22; a = 0.008;
b = 2*g / (p * a * v_term^2);

%figure;
hold on;
    N = M_stage.*(D_stage - b) ./ M_para ./ (b - D_para);
    plot(M_stage,N,'-')
    
xlabel('M_{stage}'); ylabel(['N (' num2str(v_term) 'm/s)']);
set(gca,'ytick',N_para); set(gca,'xtick',[0:1:M_stage(end)]); grid on;

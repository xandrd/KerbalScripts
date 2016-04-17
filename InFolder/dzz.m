% Script identifyed the best oribit for scanning
mu = 3.5316000E12;% гравитационный параметр
R=600E3;% радиус планеты
T=6*3600;% период планеты
fov = 3 * pi / 180;
H_MAX  = 500; 
H_MIN  = 70;
H_STEP = .1; % шаг
N_it = 10000; %  оличество иттераций
N = [1:1:N_it];

h = [H_MIN:H_STEP:H_MAX]*1E3; % массив высот

S = 2.*pi.*R; % окружность планеты

x= S.*2.*pi.*sqrt((R+h).^3./mu)./T; % смещение

L = 2.*tan( fov ).*h; % „то мы видим

bins = fix(S ./ (L/2)); % если спутник попал в бин шириной L/2, он область перекрыта
max(bins)

%матрица расчета (x,n) n - количество орбит
xn = repmat(x,N_it,1) .* repmat(N,numel(x),1)';
size(xn)

%c=fix(a/b) - деление нацело; 
%d=a-b*c - остаток. 
xn_C = fix(xn./S);
xn_D = xn./S - xn_C; % коорбитната бина
size(xn_D)

percent = zeros(numel(h),1);     % numel(h) == numel(bins)
totaltime   = zeros(numel(h),1); % numel(h) == numel(bins)

size(percent)

tic
% количество бинов мен€етс€ от высоты, придетс€ использовать цикл, по другому
% никак
for ibin = 1:numel(bins)
%for ibin = 1:1
    disp(h(ibin))
    % теперь мы находимс€ в рамках одной высоты
    bin_D = repmat(1:bins(ibin), N_it,1  );
    x_D   = repmat(xn_D(:,ibin), 1, bins(ibin));
    [~, I] = min(abs( 1./bin_D' - x_D' )); % определ€ем бин
    
    [U,iI] = unique(I); % кол-во уникальных бинов
    
    percent(ibin) = numel(U)./bins(ibin) * 100; % примерный процент покрыти€
    totaltime(ibin)   = max(iI) .* 2.*pi.*sqrt(((R+h(ibin)).^3.)/mu) ./ 3600; % примерное врем€ регистрации
end
toc
figure
subplot(1,2,1)
plot(h/1000,percent)
xlabel('¬ысота, км');
ylabel('ѕроцент регистрации, %')
subplot(1,2,2)
plot(h/1000,totaltime,'k')
xlabel('¬ысота, км');
ylabel('¬рем€ регистрации, час')

[m,im] = max(percent);
m
totaltime(im)


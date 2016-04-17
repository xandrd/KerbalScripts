% Script identifyed the best oribit for scanning
mu = 3.5316000E12;% �������������� ��������
R=600E3;% ������ �������
T=6*3600;% ������ �������
fov = 3 * pi / 180;
H_MAX  = 500; 
H_MIN  = 70;
H_STEP = .1; % ���
N_it = 10000; % ���������� ���������
N = [1:1:N_it];

h = [H_MIN:H_STEP:H_MAX]*1E3; % ������ �����

S = 2.*pi.*R; % ���������� �������

x= S.*2.*pi.*sqrt((R+h).^3./mu)./T; % ��������

L = 2.*tan( fov ).*h; % ��� �� �����

bins = fix(S ./ (L/2)); % ���� ������� ����� � ��� ������� L/2, �� ������� ���������
max(bins)

%������� ������� (x,n) n - ���������� �����
xn = repmat(x,N_it,1) .* repmat(N,numel(x),1)';
size(xn)

%c=fix(a/b) - ������� ������; 
%d=a-b*c - �������. 
xn_C = fix(xn./S);
xn_D = xn./S - xn_C; % ����������� ����
size(xn_D)

percent = zeros(numel(h),1);     % numel(h) == numel(bins)
totaltime   = zeros(numel(h),1); % numel(h) == numel(bins)

size(percent)

tic
% ���������� ����� �������� �� ������, �������� ������������ ����, �� �������
% �����
for ibin = 1:numel(bins)
%for ibin = 1:1
    disp(h(ibin))
    % ������ �� ��������� � ������ ����� ������
    bin_D = repmat(1:bins(ibin), N_it,1  );
    x_D   = repmat(xn_D(:,ibin), 1, bins(ibin));
    [~, I] = min(abs( 1./bin_D' - x_D' )); % ���������� ���
    
    [U,iI] = unique(I); % ���-�� ���������� �����
    
    percent(ibin) = numel(U)./bins(ibin) * 100; % ��������� ������� ��������
    totaltime(ibin)   = max(iI) .* 2.*pi.*sqrt(((R+h(ibin)).^3.)/mu) ./ 3600; % ��������� ����� �����������
end
toc
figure
subplot(1,2,1)
plot(h/1000,percent)
xlabel('������, ��');
ylabel('������� �����������, %')
subplot(1,2,2)
plot(h/1000,totaltime,'k')
xlabel('������, ��');
ylabel('����� �����������, ���')

[m,im] = max(percent);
m
totaltime(im)


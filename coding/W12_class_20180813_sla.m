%% 
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
clear;clc;clf
%% 
% Column  1: DATETIME is Time String
% Column  2: TIME is Time Coordinates (days since 01-JAN-1950 00:00:00)   BAD FLAG : -1.E+34
% Column  3: LON is Longitude (degrees_east)   BAD FLAG : -1.E+34
% Column  4: LAT is Latitude (degrees_north)   BAD FLAG : -1.E+34
% Column  5: SLA is Sea level anomaly (m)   BAD FLAG : -1.E+34
filename = '20180813_sla.txt';

fid = fopen(filename,'r');

sla_20180813 = textscan(fid, '%s %f %f %f %f','headerLines', 10,'Delimiter',',');

fclose(fid);

sla_20180813 = cell2mat(sla_20180813(3:5));
% sla_20180813������ : xlon ylat sla
%% Set variables
xlon = sla_20180813(:,1);
ylat = sla_20180813(:,2);
sla = sla_20180813(:,3);  % sla
%% Reshape variables and fix data on land
% ��ƪ��Ŷ��ѪR�� �G 0.25 �סA�ҥH�b�d��(4 ��)�A4/0.25 = 16�A
% �N�g�n�צU�ۤ���16����ơC
xlon = reshape(xlon,16,16); %% change size to: 16x16
ylat = reshape(ylat,16,16); %% change size to: 16x16
sla = reshape(sla,16,16);   %% change size to: 16x16

sla(find(sla == -1.000000000000000e+34)) = NaN;
%% Plot SLA map
figure(1)
LATLIM = [22:1:26];
LONGLIM = [121:1:125];
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % ø�s����(�զ�)
m_pcolor(xlon,ylat,sla);
shading flat;
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %ø�s���a
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');

% axis('equal')
colormap('parula')
cb = colorbar;
cb.Label.String = 'Sea level anomaly (m)';
hold off;
title('20180813_sla','Interpreter','none')
print('W12_class01_20180813_sla','-dpng')
%% Geostrophic Equations (height gradients , unit : m)
% ��ƪ��Ŷ��ѪR�� �G 0.25 ��
% �N�ѪR�׳��q���ഫ������ ( 1�X = 110 km )
% �A�N�����ഫ������

% �@�Ӻ��檺 x�By ��� : 
dx=0.25*110*1000; % [(�ѪR��)*(�@�Ӹg�ת��Z���A���O����)*(1����)]
dy=0.25*110*1000; % [(�ѪR��)*(�@�ӽn�ת��Z���A���O����)*(1����)]

%% Calculate the gradient of adt in x and y-dir
% 16 x 16 data �� 15 x 15 data

% y-dir : �n�צb��Ʈ��I�W�O�Ѥp��j�V�k�ƦC
dhdy = (sla(:,2:end)-sla(:,1:end-1))/dy; %% size: 16x15
% y ��V(�n�פ�V)���������ײ��`(SLA)���

% x-dir : �g�צb��Ʈ��I�W�O�Ѥp��j�V�U�ƦC
dhdx = (sla(2:end,:)-sla(1:end-1,:))/dx; %% size: 15x16
% x ��V(�g�פ�V)���������ײ��`(SLA)���

% ���F�� dhdy �M dhdx ����ƺ��׬ۦP�A��h�X�Ӫ���ƥh��
dhdy = dhdy(2:end,:); %% change size to: 15x15
dhdx = dhdx(:,2:end); %% change size to: 15x15
%% Set Parameters : �a�y���t��(Omega)�B���Ѽ�( f = 2�[sin(�X) )
% 23 hr 56 min = 86160 sec
omega = 7.29115*10^-5; % �a�y���t��(Omega)
% omega = (2 x pi)/T = 2 x 3.14/86160 = 7.29 x 10^-5 (s^-1)
g = 9.8;
f = 2*omega*sind(ylat(2:end,2:end)); %% size : 15x15
%%  Calculate velocities and speeds (��ADT�o��y�t)
v = g * dhdx./f;   % v ��V���a��y�t
u = - g * dhdy./f; % u ��V���a��y�t
spd = sqrt(u.^2 + v.^2);
avg_spd = nanmean(reshape(spd,225,1));
kuroshio_avg_spd = nanmean(spd(spd>=0.4)); % �p��¼�y�b�����y�t
% �¼�y�b�����y�t�Hcolorbar��b���H�W��@�H��(threshold value)
%% Show estimated speed (colors) and velocities (vectors) in a figure
xlon = xlon(2:end,2:end); %% change size to: 15x15
ylat = ylat(2:end,2:end); %% change size to: 15x15
figure(2)
% subplot(1,2,1)
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % ø�s����(�զ�)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_pcolor(xlon,ylat,spd); % ��ܦa��y�t
shading flat;
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %ø�s���a
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');

% axis('equal')
colormap('parula')
cb_spd = colorbar;
cb_spd.Label.String = 'Estimated Speed (m/s)';
hold on;
m_quiver(xlon,ylat,u,v,'k')
hold off;
avg_spd_str = num2str(avg_spd);
kuroshio_avg_spd_str = num2str(kuroshio_avg_spd);
xlabel({['Flow field mean speed : ' avg_spd_str(1:5) ' (m/s)'];...
    ['Kuroshio mean speed : ' kuroshio_avg_spd_str(1:5) ' (m/s)']}...
    ,'color','b','fontsize',10);
title('20180813_sla_current_speed','Interpreter','none')
print('W12_class02_20180813_sla','-dpng')
%% 
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
clear;clc;clf
%% 
filename = '20180115_adt.txt';

fid = fopen(filename, 'r');

adt_20180115 = textscan(fid, '%s %f %f %f %f','headerLines', 10,'Delimiter',',');

fclose(fid);

adt_20180115 = cell2mat(adt_20180115(3:5));
% adt_20180115������ : xlon ylat adt(absolute dynamic topography)
%% Set variables
xlon = adt_20180115(:,1);
ylat = adt_20180115(:,2);
adt = adt_20180115(:,3); % adt(absolute dynamic topography)
%% Reshape variables and fix data on land
xlon = reshape(xlon,16,16); %% change size to: 16x16
ylat = reshape(ylat,16,16); %% change size to: 16x16
adt = reshape(adt,16,16);   %% change size to: 16x16

adt(find(adt<0))=NaN;

% I=findall(adt.<0);
% 
% adt[I].=NaN;
%% Plot ADT map
figure(1)
LATLIM = [22:1:26];
LONGLIM = [121:1:125];
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % ø�s����(�զ�)
m_pcolor(xlon,ylat,adt);
shading flat;
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %ø�s���a
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');

% axis('equal')
colormap('parula')
cb = colorbar;
cb.Label.String = 'Absolute dynamic topography (m)';
hold off;
title('20180115_adt','Interpreter','none')
print('W11_hw01_20180115_adt','-dpng')
%% Geostrophic Equations (height gradients , unit : m)
% ��ƪ��Ŷ��ѪR�� �G 0.25 ��
% �N�ѪR�׳��q���ഫ������ ( 1�X = 110 km )
% �A�N�����ഫ������

dx=0.25*110*1000; % [(�ѪR��)*(�@�Ӹg�ת��Z���A���O����)*(1����)]
dy=0.25*110*1000; % [(�ѪR��)*(�@�ӽn�ת��Z���A���O����)*(1����)]

%% Calculate the gradient of adt in x and y-dir
% 16 x 16 data �� 15 x 15 data

% y-dir : �n�צb��Ʈ��I�W�O�Ѥp��j�V�k�ƦC
dhdy = (adt(:,2:end)-adt(:,1:end-1))/dy; %% size: 16x15
% y ��V(�n�פ�V)������ʤO����(ADT)���

% x-dir : �g�צb��Ʈ��I�W�O�Ѥp��j�V�U�ƦC
dhdx = (adt(2:end,:)-adt(1:end-1,:))/dx; %% size: 15x16
% x ��V(�g�פ�V)������ʤO����(ADT)���

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
title('20180115_adt_current_speed','Interpreter','none')
print('W11_hw02_20180115_adt','-dpng')
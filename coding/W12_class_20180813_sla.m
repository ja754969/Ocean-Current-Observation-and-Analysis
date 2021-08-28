%% 
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
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
% sla_20180813的行資料 : xlon ylat sla
%% Set variables
xlon = sla_20180813(:,1);
ylat = sla_20180813(:,2);
sla = sla_20180813(:,3);  % sla
%% Reshape variables and fix data on land
% 資料的空間解析度 ： 0.25 度，所以在範圍內(4 度)，4/0.25 = 16，
% 將經緯度各自分成16筆資料。
xlon = reshape(xlon,16,16); %% change size to: 16x16
ylat = reshape(ylat,16,16); %% change size to: 16x16
sla = reshape(sla,16,16);   %% change size to: 16x16

sla(find(sla == -1.000000000000000e+34)) = NaN;
%% Plot SLA map
figure(1)
LATLIM = [22:1:26];
LONGLIM = [121:1:125];
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
m_pcolor(xlon,ylat,sla);
shading flat;
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %繪製陸地
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
% 資料的空間解析度 ： 0.25 度
% 將解析度單位從度轉換成公里 ( 1° = 110 km )
% 再將公里轉換為公尺

% 一個網格的 x、y 資料 : 
dx=0.25*110*1000; % [(解析度)*(一個經度的距離，單位是公里)*(1公里)]
dy=0.25*110*1000; % [(解析度)*(一個緯度的距離，單位是公里)*(1公里)]

%% Calculate the gradient of adt in x and y-dir
% 16 x 16 data → 15 x 15 data

% y-dir : 緯度在資料格點上是由小到大向右排列
dhdy = (sla(:,2:end)-sla(:,1:end-1))/dy; %% size: 16x15
% y 方向(緯度方向)的海面高度異常(SLA)梯度

% x-dir : 經度在資料格點上是由小到大向下排列
dhdx = (sla(2:end,:)-sla(1:end-1,:))/dx; %% size: 15x16
% x 方向(經度方向)的海面高度異常(SLA)梯度

% 為了讓 dhdy 和 dhdx 的資料維度相同，把多出來的資料去除
dhdy = dhdy(2:end,:); %% change size to: 15x15
dhdx = dhdx(:,2:end); %% change size to: 15x15
%% Set Parameters : 地球角速度(Omega)、科氏參數( f = 2Ωsin(Φ) )
% 23 hr 56 min = 86160 sec
omega = 7.29115*10^-5; % 地球角速度(Omega)
% omega = (2 x pi)/T = 2 x 3.14/86160 = 7.29 x 10^-5 (s^-1)
g = 9.8;
f = 2*omega*sind(ylat(2:end,2:end)); %% size : 15x15
%%  Calculate velocities and speeds (由ADT得到流速)
v = g * dhdx./f;   % v 方向的地轉流速
u = - g * dhdy./f; % u 方向的地轉流速
spd = sqrt(u.^2 + v.^2);
avg_spd = nanmean(reshape(spd,225,1));
kuroshio_avg_spd = nanmean(spd(spd>=0.4)); % 計算黑潮流軸平均流速
% 黑潮流軸平均流速以colorbar位在綠色以上當作閾值(threshold value)
%% Show estimated speed (colors) and velocities (vectors) in a figure
xlon = xlon(2:end,2:end); %% change size to: 15x15
ylat = ylat(2:end,2:end); %% change size to: 15x15
figure(2)
% subplot(1,2,1)
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_pcolor(xlon,ylat,spd); % 顯示地轉流速
shading flat;
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %繪製陸地
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
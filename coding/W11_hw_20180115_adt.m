%% 
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
clear;clc;clf
%% 
filename = '20180115_adt.txt';

fid = fopen(filename, 'r');

adt_20180115 = textscan(fid, '%s %f %f %f %f','headerLines', 10,'Delimiter',',');

fclose(fid);

adt_20180115 = cell2mat(adt_20180115(3:5));
% adt_20180115的行資料 : xlon ylat adt(absolute dynamic topography)
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
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
m_pcolor(xlon,ylat,adt);
shading flat;
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %繪製陸地
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
% 資料的空間解析度 ： 0.25 度
% 將解析度單位從度轉換成公里 ( 1° = 110 km )
% 再將公里轉換為公尺

dx=0.25*110*1000; % [(解析度)*(一個經度的距離，單位是公里)*(1公里)]
dy=0.25*110*1000; % [(解析度)*(一個緯度的距離，單位是公里)*(1公里)]

%% Calculate the gradient of adt in x and y-dir
% 16 x 16 data → 15 x 15 data

% y-dir : 緯度在資料格點上是由小到大向右排列
dhdy = (adt(:,2:end)-adt(:,1:end-1))/dy; %% size: 16x15
% y 方向(緯度方向)的絕對動力高度(ADT)梯度

% x-dir : 經度在資料格點上是由小到大向下排列
dhdx = (adt(2:end,:)-adt(1:end-1,:))/dx; %% size: 15x16
% x 方向(經度方向)的絕對動力高度(ADT)梯度

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
title('20180115_adt_current_speed','Interpreter','none')
print('W11_hw02_20180115_adt','-dpng')
%% ���J��� uv_gps_00781035.txt
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
% Export data: 1st bin, Velocity (East and North)
% and Lat/Lon. (save file as ��uv_gps.txt�� for an
% example)
clear;clc;clf
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\WinADCP')
filename = 'uv_gps_00781035.txt';
ds1 = datastore(filename); %���J��1�����data1�A�s���ds1 (type : TabularTextDatastore)
uv_gps_00781035 = read(ds1); % Ū����1�����ds1�A�s���traj1 (type : table)
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
%% ���y��g�n�׸��(uv_gps_00781035.txt)
uv_gps_00781035(1:2,:) = []; % �R���e��檺�h����
first_lat = str2double(uv_gps_00781035.FLat);
% str2double : �N�o�̪� cell array �ഫ�� Double-precision array
first_lon = str2double(uv_gps_00781035.FLon);

last_lat = str2double(uv_gps_00781035.LLat);
% str2double : �N�o�̪� cell array �ഫ�� Double-precision array
last_lon = str2double(uv_gps_00781035.LLon);

avg_lat = (first_lat + last_lat)/2;
avg_lon = (first_lon + last_lon)/2;

u = str2double(uv_gps_00781035.Eas);
v = str2double(uv_gps_00781035.Nor);
%% ø�s�a��(�t�s�q����)
LATLIM = [24.7:0.25:25.3];
LONGLIM = [121.7:0.25:122.5];
% subplot(1,2,1)
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % ø�s����(�զ�)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_f('patch',[.2 .2 .2],'edgecolor','k');    %ø�s���a
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
hold on;
% (1:185,:)
% [avg_lon,avg_lat] = meshgrid(avg_lon,avg_lat);

m_plot(avg_lon,avg_lat,'-','Color',[0.3010 0.7450 0.9330]);hold on;
m_plot(avg_lon,avg_lat,'.','Color',[0.8500 0.3250 0.0980]);hold on;
q = m_quiver(avg_lon,avg_lat,u,v,2,'Color',[0.8500 0.3250 0.0980]);

hold on;
% m_plot(avg_lon(1),avg_lat(1),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% m_plot(avg_lon(end),avg_lat(end),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% m_text(avg_lon(1),avg_lat(1)-0.025,{'17/06/28';'18:40:08'},'color','b','fontsize',7);
% m_text(avg_lon(end),avg_lat(end)+0.025,{'17/06/29';'13:05:08'},'color','b','fontsize',7);
hold off;
% axis equal;
xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W8_class';'2247_ship_track';'2017/06/28 (18:40:08) ~ 2017/06/29 (13:05:08)'}...
    ,"FontSize",12,'Interpreter','none')

%% ���J��� uv_gps_00781035.txt
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
% Export data: 1st bin, Velocity (East and North)
% and Lat/Lon. (save file as ��uv_gps.txt�� for an
% example)
clear;clc;clf
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\WinADCP')
filename = 'uv_gps_00781035.txt';
ds1 = datastore(filename); %���J��1�����data1�A�s���ds1 (type : TabularTextDatastore)
uv_gps_00781035 = read(ds1); % Ū����1�����ds1�A�s���traj1 (type : table)
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
%% ���y��g�n�׸��(uv_gps_00781035.txt)
uv_gps_00781035(1:2,:) = []; % �R���e��檺�h����
first_lat = str2double(uv_gps_00781035.FLat);
% str2double : �N�o�̪� cell array �ഫ�� Double-precision array
first_lon = str2double(uv_gps_00781035.FLon);

last_lat = str2double(uv_gps_00781035.LLat);
% str2double : �N�o�̪� cell array �ഫ�� Double-precision array
last_lon = str2double(uv_gps_00781035.LLon);

avg_lat = (first_lat + last_lat)/2;
avg_lon = (first_lon + last_lon)/2;

u = str2double(uv_gps_00781035.Eas);
v = str2double(uv_gps_00781035.Nor);
%% ø�s�a��(�t�s�q����)
LATLIM = [24.7:0.25:25.3];
LONGLIM = [121.7:0.25:122.5];
% subplot(1,2,1)
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % ø�s����(�զ�)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_f('patch',[.2 .2 .2],'edgecolor','k');    %ø�s���a
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
hold on;
% (1:185,:)
% [avg_lon,avg_lat] = meshgrid(avg_lon,avg_lat);

m_plot(avg_lon,avg_lat,'-','Color',[0.3010 0.7450 0.9330]);hold on;
m_plot(avg_lon,avg_lat,'.','Color',[0.8500 0.3250 0.0980]);hold on;
q = m_quiver(avg_lon,avg_lat,u,v,2,'Color',[0.8500 0.3250 0.0980]);

hold on;
% m_plot(avg_lon(1),avg_lat(1),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% m_plot(avg_lon(end),avg_lat(end),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% m_text(avg_lon(1),avg_lat(1)-0.025,{'17/06/28';'18:40:08'},'color','b','fontsize',7);
% m_text(avg_lon(end),avg_lat(end)+0.025,{'17/06/29';'13:05:08'},'color','b','fontsize',7);
hold off;
% axis equal;
xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W8_class';'2247_ship_track';'2017/06/28 (18:40:08) ~ 2017/06/29 (13:05:08)'}...
    ,"FontSize",12,'Interpreter','none')
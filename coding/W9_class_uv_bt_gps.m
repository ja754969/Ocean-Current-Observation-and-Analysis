%%
% help m_map
%% 載入資料 uv_bt_gps_w9_90_109_00781035.txt、uv_relative_water_velocities_w9_90_109_00781035.txt

cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
% Export data: 1st bin, Velocity (East and North)
% and Lat/Lon. (save file as “uv_bt_90_120_00781035.txt” for an
% example)
clear;clc;clf
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\WinADCP')
filename = 'uv_bt_gps_w9_90_109_00781035.txt';
ds1 = datastore(filename); %載入第1筆資料data1，存放到ds1 (type : TabularTextDatastore)
uv_bt_gps_w9_90_109_00781035 = read(ds1); % 讀取第1筆資料ds1，存放到uv_bt_90_120_00781035 (type : table)
filename2 = 'uv_relative_water_velocities_w9_90_109_00781035.txt';
ds2 = datastore(filename2); %載入第1筆資料data1，存放到ds1 (type : TabularTextDatastore)
uv_relative_water_velocities_w9_90_109_00781035 = read(ds2); % 讀取第1筆資料ds1，存放到uv_bt_90_120_00781035 (type : table)
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% 航行軌跡由 ADCP_bottom_track 和 ship_gps 測得的船速資料(uv_bt_gps_w9_90_109_00781035.txt)
uv_bt_gps_w9_90_109_00781035(1:2,:) = []; % 刪除前兩行的多於資料
uv_relative_water_velocities_w9_90_109_00781035(1:2,:) = []; % 刪除前兩行的多於資料
BTE_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.BTE);
% str2double : 將這裡的 cell array 轉換為 Double-precision array
BTN_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.BTN);
NVE_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.NVE);
% str2double : 將這裡的 cell array 轉換為 Double-precision array
NVN_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.NVN);
u_rel_vel_adcp_90_109 = str2double(uv_relative_water_velocities_w9_90_109_00781035.Eas);
v_rel_vel_adcp_90_109 = str2double(uv_relative_water_velocities_w9_90_109_00781035.Nor);
%% Calculating α and β

ub = BTE_90_109(90:109,:);
vb = BTN_90_109(90:109,:);
ug = NVE_90_109(90:109,:);
vg = NVN_90_109(90:109,:);

tan_alpha = mean(ub.*vg-vb.*ug)/mean(ub.*ug+vb.*vg);

alpha = atand(tan_alpha); % Misalignment Angle

beta = sqrt(mean(ug.^2+vg.^2)/mean(ub.^2+vb.^2)); % 


%% Calculating the absolute water velocities
ur = u_rel_vel_adcp_90_109(90:109,:);
vr = v_rel_vel_adcp_90_109(90:109,:);

% the absolute water velocities (bottom track)
%Removing bottom-track ship velocities:
uw_bt=beta*((ur+ub)*cosd(alpha)-(vr+vb)*sind(alpha));
vw_bt=beta*((ur+ub)*sind(alpha)+(vr+vb)*cosd(alpha));

% the absolute water velocities (GPS)
%Removing GPS ship velocities:
uw_gps=beta*(ur*cosd(alpha)-vr*sind(alpha))+ug;
vw_gps=beta*(ur*sind(alpha)+vr*cosd(alpha))+vg;
%% Plot results
% Comparing the current velocities after
% removing bottom-tracked ship velocities and
% GPS ship velocities.
subplot(2,1,1)
plot(uw_bt);hold on;
plot(uw_gps);hold off;
ylabel('U-velocity (mm/s)');
legend('Bottom-track','GPS','Location','best');
axis([0 20 150 350]);
title({'W9_class';'Comparing the current velocities';...
    'after removing bottom-tracked ship velocities';'and GPS ship velocities'},'Interpreter','none')
subplot(2,1,2)
plot(vw_bt);hold on;
plot(vw_gps);hold off;
ylabel('V-velocity (mm/s)');
xlabel('Ensemble');
axis([0 20 -100 200]);


% 
% last_lat_bt_w9_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.LLat);
% % str2double : 將這裡的 cell array 轉換為 Double-precision array
% last_lon_bt_w9_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.LLon);
% 
% avg_lat_bt_w9_90_109 = (first_lat_bt_90_120 + last_lat_bt_90_120)/2;
% avg_lon_bt_w9_90_109 = (first_lon_bt_90_120 + last_lon_bt_90_120)/2;
% 
% u_bt_w9_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.Eas);
% v_bt_w9_90_109 = str2double(uv_bt_gps_w9_90_109_00781035.Nor);
% %% 繪製地圖(removing the "bottom-track" ship velocities,龜山島附近)
% LATLIM1 = [24.75:0.25:25];
% LONGLIM1 = [121.75:0.25:122.25];
% subplot(2,2,1)
% m_proj('miller','lon',[LONGLIM1(1) LONGLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
% % ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
% m_gshhs_f('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
% m_grid('linewi',1,'linestyle','none','tickdir','out',...
%             'xtick',LONGLIM1,'ytick',LATLIM1,...
%             'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
% hold on;
% % (1:185,:)
% % [avg_lon,avg_lat] = meshgrid(avg_lon,avg_lat);
% m_plot(avg_lon_bt_90_120(90:120,:),avg_lat_bt_90_120(90:120,:),'.','Color',[0.8500 0.3250 0.0980]);hold on;
% q = m_quiver(avg_lon_bt_90_120(90:120,:),avg_lat_bt_90_120(90:120,:),...
%     u_bt_90_120(90:120,:),v_bt_90_120(90:120,:),2,'Color',[0 0.4470 0.7410],'MarkerSize',15,'LineWidth',1);hold on;
% 
% % m_plot(avg_lon(1),avg_lat(1),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% % m_plot(avg_lon(end),avg_lat(end),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% m_text(avg_lon_bt_90_120(90),avg_lat_bt_90_120(90)-0.075,{'17/06/29';'02:05:08'},'color','b','fontsize',7);
% m_text(avg_lon_bt_90_120(120),avg_lat_bt_90_120(120)+0.075,{'17/06/29';'04:35:08'},'color','b','fontsize',7);
% hold off;
% axis('image') %固定圖案的縮放(在縮放視窗時不會變形)
% % axis equal;
% xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
% ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
% title({'W8_hw';'2247track_removing the bottom-track';'from the 90th ensemble to the 120th ensemble'}...
%     ,"FontSize",12,'Interpreter','none')
% %% zoom in (uv_bt_90_120_00781035.txt)
% % get(gca,'position') % 左 底部 寬度 高度
% % axes('position',[0.062 0.5925 0.4 0.325])
% LATLIM1_zoom_in = [24.835:0.025:24.905];
% LONGLIM1_zoom_in = [122:0.025:122.05];
% subplot(2,2,2)
% m_proj('miller','lon',[LONGLIM1_zoom_in(1) LONGLIM1_zoom_in(end)],'lat',[LATLIM1_zoom_in(1) LATLIM1_zoom_in(end)]); % 繪製海面(白色)
% m_gshhs_c('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
% m_grid('linewi',1,'linestyle','none','tickdir','out',...
%             'xtick',LONGLIM1_zoom_in,'ytick',LATLIM1_zoom_in,...
%             'XaxisLocation','bottom','YaxisLocation','right','box','fancy');
% hold on;
% m_plot(avg_lon_bt_90_120(90:120,:),avg_lat_bt_90_120(90:120,:),'-k');hold on;
% m_plot(avg_lon_bt_90_120(90:120,:),avg_lat_bt_90_120(90:120,:),'.b',...
%     'Color',[0.8500 0.3250 0.0980],'MarkerSize',10);hold on;
% q_zoom_in = m_quiver(avg_lon_bt_90_120(90:120,:),avg_lat_bt_90_120(90:120,:),...
%     u_bt_90_120(90:120,:),v_bt_90_120(90:120,:),2,'Color',[0 0.4470 0.7410],'MarkerSize',15,'LineWidth',1);hold off;
% % set(gca,'yAxisLocation','left');
% % xlabel('Longitude',"FontSize",16,"FontName",'times')
% % ylabel('Latitude',"FontSize",16,"FontName",'times')
% title({'zoomed in from the left figure';'(Remove "bottom-track" ship velocities)'})
% axis('image') %讓圖形在縮放之後不會變形
% % axis([LONLIM1(1) LONLIM1(end) LATLIM1(1) LATLIM1(end)])
% % text(120.25,23.5,'Taiwan','FontSize',9,'FontName','times','Color','b')%在圖中標示台灣
% % set(gca,'LineWidth',4)%坐標軸設定粗細
% 
% %% 載入資料 uv_gps_90_120_00781035.txt
% cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
% % Export data: 1st bin, Velocity (East and North)
% % and Lat/Lon. (save file as “uv_gps.txt” for an
% % example)
% cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\WinADCP')
% filename = 'uv_gps_90_120_00781035.txt';
% ds1 = datastore(filename); %載入第1筆資料data1，存放到ds1 (type : TabularTextDatastore)
% uv_gps_90_120_00781035 = read(ds1); % 讀取第1筆資料ds1，存放到uv_bt_90_120_00781035 (type : table)
% cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
% %% 航行軌跡經緯度資料(uv_bt_90_120_00781035.txt)
% uv_gps_90_120_00781035(1:2,:) = []; % 刪除前兩行的多於資料
% first_lat_gps_90_120 = str2double(uv_gps_90_120_00781035.FLat);
% % str2double : 將這裡的 cell array 轉換為 Double-precision array
% first_lon_gps_90_120 = str2double(uv_gps_90_120_00781035.FLon);
% 
% last_lat_gps_90_120 = str2double(uv_gps_90_120_00781035.LLat);
% % str2double : 將這裡的 cell array 轉換為 Double-precision array
% last_lon_gps_90_120 = str2double(uv_gps_90_120_00781035.LLon);
% 
% avg_lat_gps_90_120 = (first_lat_bt_90_120 + last_lat_bt_90_120)/2;
% avg_lon_gps_90_120 = (first_lon_bt_90_120 + last_lon_bt_90_120)/2;
% 
% u_gps_90_120 = str2double(uv_gps_90_120_00781035.Eas);
% v_gps_90_120 = str2double(uv_gps_90_120_00781035.Nor);
% %% 繪製地圖(removing the "GPS" ship velocities,龜山島附近)
% subplot(2,2,3)
% m_proj('miller','lon',[LONGLIM1(1) LONGLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
% % ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
% m_gshhs_f('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
% m_grid('linewi',1,'linestyle','none','tickdir','out',...
%             'xtick',LONGLIM1,'ytick',LATLIM1,...
%             'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
% hold on;
% % (1:185,:)
% % [avg_lon,avg_lat] = meshgrid(avg_lon,avg_lat);
% m_plot(avg_lon_gps_90_120(90:120,:),avg_lat_gps_90_120(90:120,:),'.');hold on;
% q2 = m_quiver(avg_lon_gps_90_120(90:120,:),avg_lat_gps_90_120(90:120,:),...
%     u_gps_90_120(90:120,:),v_gps_90_120(90:120,:),2,'MarkerSize',15,'LineWidth',1);hold on;
% % q = quiver(1:100,1:100);
% 
% % m_plot(avg_lon(1),avg_lat(1),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% % m_plot(avg_lon(end),avg_lat(end),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
% m_text(avg_lon_gps_90_120(90),avg_lat_gps_90_120(90)-0.075,{'17/06/29';'02:05:08'},'color','b','fontsize',7);
% m_text(avg_lon_gps_90_120(120),avg_lat_gps_90_120(120)+0.075,{'17/06/29';'04:35:08'},'color','b','fontsize',7);
% hold off;
% axis('image') %固定圖案的縮放(在縮放視窗時不會變形)
% % axis equal;
% xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
% ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
% title({'W8_hw';'2247track_removing the "GPS" ship velocities';'from the 90th ensemble to the 120th ensemble'}...
%     ,"FontSize",12,'Interpreter','none')
% %% zoom in (uv_gps_90_120_00781035.txt)
% % get(gca,'position') % 左 底部 寬度 高度
% % axes('position',[0.062 0.5925 0.4 0.325])
% subplot(2,2,4)
% m_proj('miller','lon',[LONGLIM1_zoom_in(1) LONGLIM1_zoom_in(end)],'lat',[LATLIM1_zoom_in(1) LATLIM1_zoom_in(end)]); % 繪製海面(白色)
% m_gshhs_c('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
% m_grid('linewi',1,'linestyle','none','tickdir','out',...
%             'xtick',LONGLIM1_zoom_in,'ytick',LATLIM1_zoom_in,...
%             'XaxisLocation','bottom','YaxisLocation','right','box','fancy');
% hold on;
% m_plot(avg_lon_gps_90_120(90:120,:),avg_lat_gps_90_120(90:120,:),'-k');hold on;
% m_plot(avg_lon_gps_90_120(90:120,:),avg_lat_gps_90_120(90:120,:),'.',...
%     'Color',[0 0.4470 0.7410],'MarkerSize',10);hold on;
% q2_zoom_in = m_quiver(avg_lon_gps_90_120(90:120,:),avg_lat_gps_90_120(90:120,:),...
%     u_gps_90_120(90:120,:),v_gps_90_120(90:120,:),2,'MarkerSize',15,'LineWidth',1);hold on;
% % set(gca,'yAxisLocation','left');
% % xlabel('Longitude',"FontSize",16,"FontName",'times')
% % ylabel('Latitude',"FontSize",16,"FontName",'times')
% title({'zoomed in from the left figure';'(Remove "GPS" ship velocities)'})
% axis('image') %讓圖形在縮放之後不會變形
% % axis([LONLIM1(1) LONLIM1(end) LATLIM1(1) LATLIM1(end)])
% % text(.25,23.5,'Taiwan','FontSize',9,'FontName','times','Color','b')%在圖中標示台灣
% % set(gca,'LineWidth',4)%坐標軸設定粗細
% 
% print('W8_hw_uv','-dpng')
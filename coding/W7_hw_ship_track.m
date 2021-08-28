%% 載入資料 cr2247001_000000
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
% Using the ADCP data (cr2247001 OOOOOO.LTA) 
% given in the server, plot the ship track. How 
% long did the ship sail (in hours) based on these 
% ADCP data?
clear;clc;clf
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\WinADCP')
filename = 'ADCP_WEEK7_hw.txt';
ds1 = datastore(filename); %載入第1筆資料data1，存放到ds1 (type : TabularTextDatastore)
cr2247001_000000 = read(ds1); % 讀取第1筆資料ds1，存放到cr2247001_000000 (type : table)
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% 繪製地圖(龜山島附近)
LATLIM = [24.5:0.5:25.5];
LONGLIM = [121.5:0.5:122.5];
% subplot(1,2,1)
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_h('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
hold on;
%% 航行軌跡經緯度資料(cr2247001_000000)
cr2247001_000000(1:2,:) = []; % 刪除前兩行的多於資料
lat = str2double(cr2247001_000000.LLat); 
% str2double : 將這裡的 cell array 轉換為 Double-precision array
lon = str2double(cr2247001_000000.LLon);
m_plot(lon,lat,'.');hold on;
m_plot(lon(1),lat(1),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
m_plot(lon(end),lat(end),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
m_text(lon(1),lat(1)-0.025,{'17/06/28';'18:40:08'},'color','b','fontsize',7);
m_text(lon(end),lat(end)+0.025,{'17/06/29';'13:05:08'},'color','b','fontsize',7);
hold off;
xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W7_hw';'2247_ship_track';'2017/06/28 (18:40:08) ~ 2017/06/29 (13:05:08)'}...
    ,"FontSize",12,'Interpreter','none')


% subplot(1,2,2)
% m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
% % ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
% m_gshhs_h('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
% m_grid('linewi',1,'linestyle','none','tickdir','out',...
%             'xtick',LONGLIM,'ytick',LATLIM,...
%             'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
% hold on;
% lat = str2double(cr2247001_000000.FLat); 
% % str2double : 將這裡的 cell array 轉換為 Double-precision array
% lon = str2double(cr2247001_000000.FLon);
% m_plot(lon,lat);
% m_text(lon(1),lat(1),{'17/06/28';'18:40:08'},'color','b','fontsize',7);
% m_text(lon(end),lat(end),{'17/06/29';'113:05:08'},'color','b','fontsize',7);
% hold off;
% xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
% ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
% title({'W7_hw';'2247_ship_track'}...
%     ,"FontSize",12,'Interpreter','none')


print('W7_hw_ship_track','-dpng')
%% 載入資料 cr2252001_000000
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
% Using the ADCP data (cr2252001 OOOOOO.LTA) 
% given in the server, plot the ship track. How 
% long did the ship sail (in hours) based on these 
% ADCP data?
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\WinADCP')
filename2 = 'ADCP_WEEK7_class.txt';
ds2 = datastore(filename2); %載入第1筆資料data1，存放到ds2 (type : TabularTextDatastore)
cr2252001_000000 = read(ds2); % 讀取第1筆資料ds1，存放到cr2252001_000000 (type : table)
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% 繪製地圖(北方三島附近)
figure(2)
LATLIM2 = [24.5:0.5:26];
LONGLIM2 = [121.5:0.5:123];
% subplot(1,2,1)
m_proj('miller','lon',[LONGLIM2(1) LONGLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % 繪製海面(白色)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_h('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM2,'ytick',LATLIM2,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
hold on;
%% 航行軌跡經緯度資料(cr2252001_000000)
cr2252001_000000(1:2,:) = []; % 刪除前兩行的多於資料
lat2 = str2double(cr2252001_000000.LLat); 
% str2double : 將這裡的 cell array 轉換為 Double-precision array
lon2 = str2double(cr2252001_000000.LLon);
m_plot(lon2,lat2,'.');hold on;
m_plot(lon2(1),lat2(1),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
m_plot(lon2(end),lat2(end),'*b','MarkerFaceColor','b','MarkerSize',2);hold on;
m_text(lon2(1),lat2(1)-0.025,{'17/07/21';'15:55:15'},'color','b','fontsize',7);
m_text(lon2(end),lat2(end)+0.025,{'17/07/25';'09:35:25'},'color','b','fontsize',7);
hold off;
xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W7_class';'2252_ship_track';'2017/07/21 (15:55:15) ~ 2017/07/25 (09:35:25)'}...
    ,"FontSize",12,'Interpreter','none')
% 
% 
% % subplot(1,2,2)
% % m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
% % % ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
% % m_gshhs_h('patch',[.2 .2 .2],'edgecolor','k');    %繪製陸地
% % m_grid('linewi',1,'linestyle','none','tickdir','out',...
% %             'xtick',LONGLIM,'ytick',LATLIM,...
% %             'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
% % hold on;
% % lat = str2double(cr2247001_000000.FLat); 
% % % str2double : 將這裡的 cell array 轉換為 Double-precision array
% % lon = str2double(cr2247001_000000.FLon);
% % m_plot(lon,lat);
% % m_text(lon(1),lat(1),{'17/06/28';'18:40:08'},'color','b','fontsize',7);
% % m_text(lon(end),lat(end),{'17/06/29';'113:05:08'},'color','b','fontsize',7);
% % hold off;
% % xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
% % ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
% % title({'W7_hw';'2247_ship_track'}...
% %     ,"FontSize",12,'Interpreter','none')
% 
% 
print('W7_class_ship_track','-dpng')

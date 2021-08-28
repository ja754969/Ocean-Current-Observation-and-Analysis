% 分組任務競賽 (00781035)
% (30 mins, if still have time, 
% bonus for 1st accomplished group: 3%) 
%% 第1題
% ? Find out a drifter trajectory that was near to a 
% typhoon track. Calculate the mean speed of the 
% drifter during the typhoon period. 
clear;clc;clf
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
load W6_Taiwan.dat % 載入台灣海岸線資料

LATLIM = [10:5:35];
LONGLIM = [115:5:135];

% lon = W6_Taiwan(:,1); %台灣海岸線資料的經度
% lat = W6_Taiwan(:,2); %台灣海岸線資料的緯度
% % m_gshhs_i('patch','g');
% % fill(lon,lat,[0 0 0]);hold on; % fill : 塗色
% plot(lon,lat,'k');hold on;
% axis([LONGLIM(1) LONGLIM(2) LATLIM(1) LATLIM(2)])
% axis('image')

m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_i('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left',...
            'box','fancy');

hold on;
%%
data1 = 'drifting-buoys-2101653.csv'; %第1筆浮球資料的檔名，存放到data1
% data1 = 'drifting-buoys-2201558.csv'; %第1筆浮球資料的檔名，存放到data1
% data1 = 'drifting-buoys-5100829.csv'; %第1筆浮球資料的檔名，存放到data1
% data1 = 'drifting-buoys-5201701.csv'; %第1筆浮球資料的檔名，存放到data1

cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200409_152835_9808096') % 設定檔案路徑
ds1 = datastore(data1); %載入第1筆浮球資料data1，存放到ds1 (type : TabularTextDatastore)
traj1 = read(ds1); % 讀取第1筆浮球資料ds1，存放到traj1 (type : table)
lat1_traj = traj1.LATITUDE_degree_north_; % 第1筆浮球資料traj1的緯度，存放到lat1_traj
% lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
lon1_traj = traj1.LONGITUDE_degree_east_; % 第1筆浮球資料traj1的經度，存放到lon1_traj

traj_p1 = m_plot(lon1_traj,lat1_traj);hold on;


xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
% title({'W6_bonus';'MITAG : 2019/09/27~2019/10/03'}...
%     ,"FontSize",14,'Interpreter','none')

cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑

%%  第2題
% Show a figure with the typhoon track and dates. 
figure(2)
imshow('MITAG_typhoon_track_and_dates.png')
% https://rdc28.cwb.gov.tw/TDB/public/typhoon_detail?typhoon_id=201918
%% 第3題 
% Show the drifter trajectory and the mean speed of the drifter.

% 地球圓周長 : 40,075 公里
% 地球 1 緯度 = 111 km
% 地球 1 經度 = 地球圓周長 * cos(所在緯度) / 360
% 例 : 在北緯90度，1經度的距離為0
% 例 : 在赤道(0度)，1經度的距離為 40,075/360 = 111 公里
distance_MITAG = 0;
% for i = 1:332
%    distance_MITAG = distance_MITAG + ...
%        sqrt(((lat1_traj(i+1) - lat1_traj(i))*111.32*1000)^2 + ...
%        (1000*(lon1_traj(i+1) - lon1_traj(i))*40075*cosd(lat1_traj(i)))^2); 
%    % 單位 : m 
% end
% for i = 1:332
%     if (lat1_traj(i) == lat1_traj(i+1)) & (lon1_traj(i) == lon1_traj(i+1))
%         fprintf('error')
%     end
% end

for i = 1:332
    two_point_dist = distance(lat1_traj(i),lon1_traj(i),lat1_traj(i+1),lon1_traj(i+1))/180*pi*6370*1000;
    if two_point_dist == 0
        fprintf('error\n')
    end
    distance_MITAG = distance_MITAG + two_point_dist;
    % 單位 : m 
        
end

speed_MITAG = distance_MITAG / ((7*24-1)*60*60) ; % 單位 : m/s
 

%  浮標時間範圍 :'2019-09-27T00:00:00Z' ~ '2019-10-03T23:00:00Z'
% 9/27 9/28 9/29 9/30 10/01 10/02 10/03 10/04
% 7*24 -1 (hr) = 167 (hr)
figure(1)
title({'W6_bonus';'MITAG : 2019/09/27~2019/10/03';...
    ['drifter mean speed : ' num2str(speed_MITAG) '(m/s)']}...
    ,"FontSize",14,'Interpreter','none')

%% 疊加米塔颱風軌跡圖
data2 = 'MITAG_table2019.xlsx';
ds2 = datastore(data2); %載入第1筆浮球資料data1，存放到ds1 (type : TabularTextDatastore)
typhoon2019_data = read(ds2); % 讀取第1筆浮球資料ds1，存放到traj1 (type : table)
MITAG_data = typhoon2019_data(find(typhoon2019_data.Var5 == 1918),:);
MITAG_data = MITAG_data(1:48,:);
MITAG_lat = table2array(MITAG_data(:,8));
% MITAG_lat = MITAG_lat(find(MITAG_data(:,8)<=LATLIM(end)),:);
MITAG_lon = table2array(MITAG_data(:,9));
% MITAG_lon = MITAG_lon(find(MITAG_data(:,9)<=LONGLIM(end)),:);
figure(1)
MITAG_track = m_plot(MITAG_lon,MITAG_lat);hold on;
MITAG_track_point = m_plot(MITAG_lon(find(MITAG_data.Var4 == 0),:),...
    MITAG_lat(find(MITAG_data.Var4 == 0),:),'*','color',[0.8500 0.3250 0.0980]);
% m_text(MITAG_lon(find(MITAG_data.Var4 == 0  & (MITAG_data.Var3 < 3 | MITAG_data.Var3 > 27)),:),...
%     MITAG_lat(find(MITAG_data.Var4 == 0  & (MITAG_data.Var3 < 3 | MITAG_data.Var3 > 27)),...
%     {'0928'},{'0929'},{'0930'},{'1001'},{'1002'},'color',[0.8500 0.3250 0.0980],'fontsize',7);
m_text(MITAG_lon(find(MITAG_data.Var4 == 0  & (MITAG_data.Var3 < 3 | MITAG_data.Var3 > 27)),:)+0.5,...
    MITAG_lat(find(MITAG_data.Var4 == 0  & (MITAG_data.Var3 < 3 | MITAG_data.Var3 > 27)),:),...
    {'0928','0929','0930','1001','1002'},'color',[0.8500 0.3250 0.0980],'fontsize',7);
% axis([LONGLIM(1) LONGLIM(end) LATLIM(1) LATLIM(end)])
m_text(lon1_traj(1)-0.5,lat1_traj(1)-0.5,{'0927'},'color','b','fontsize',7);
m_text(lon1_traj(end),lat1_traj(end),{'1003'},'color','b','fontsize',7);
legend([traj_p1,MITAG_track]...
    ,['platform1' data1(15:end-4)],['MITAG_track']...
    ,'Location','best','FontSize',6,'TextColor','b','Interpreter','none');
axis('image')
print('W6_bonus_drifter_typhon_track','-dpng') 
% the drifter trajectory and the mean speed of the drifter.
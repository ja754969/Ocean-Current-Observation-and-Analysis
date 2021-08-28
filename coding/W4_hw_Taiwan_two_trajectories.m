%% The range of map : 20~27 N  118~125 E
clear;clc;clf
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
load W4_hw_Taiwan.dat % 載入台灣海岸線資料

LATLIM = [20 27];
LONGLIM = [118 125];
lon = W4_hw_Taiwan(:,1); %台灣海岸線資料的經度
lat = W4_hw_Taiwan(:,2); %台灣海岸線資料的緯度
% fill(lon,lat,[1 1 1]);hold on; % fill : 塗色
plot(lon,lat,'k');hold on;
axis([LONGLIM(1) LONGLIM(2) LATLIM(1) LATLIM(2)])
axis('image')

print('W4_hw4_coastline','-dpng') % Taiwan coastline
%% drifter trajectories near to Taiwan
% The range of drifter trajectories : 20~27 N  118~125 E
data1 = 'drifting-buoys-2101650.csv'; %第1筆浮球資料的檔名，存放到data1

cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200327_071146_9750269') % 設定檔案路徑
ds1 = datastore(data1); %載入第1筆浮球資料data1，存放到ds1 (type : TabularTextDatastore)
traj1 = read(ds1); % 讀取第1筆浮球資料ds1，存放到traj1 (type : table)
lat1_traj = traj1.LATITUDE_degree_north_; % 第1筆浮球資料traj1的緯度，存放到lat1_traj
% lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
lon1_traj = traj1.LONGITUDE_degree_east_; % 第1筆浮球資料traj1的經度，存放到lon1_traj

traj_p1 = plot(lon1_traj,lat1_traj);hold on;
%% 
data2 = 'drifting-buoys-2201576.csv'; %第2筆浮球資料的檔名，存放到data2
ds2 = datastore(data2); %載入第2筆浮球資料data2，存放到ds2 (type : TabularTextDatastore)
traj2 = read(ds2); % 讀取第2筆浮球資料ds2，存放到traj2 (type : table)
lat2_traj = traj2.LATITUDE_degree_north_; % 第2筆浮球資料traj2的緯度，存放到lat2_traj
% lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
lon2_traj = traj2.LONGITUDE_degree_east_; % 第2筆浮球資料traj2的經度，存放到lon2_traj
traj_p2 = plot(lon2_traj,lat2_traj);hold off;
% m_grid('box','fancy')
legend([traj_p1,traj_p2]...
    ,['platform1' data1(15:end-4)],['platform2' data2(15:end-4)]...
    ,'Location','northwest','FontSize',6,'TextColor','b');
legend('boxoff')

xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W4_hw4';'Platform1 : 2019/11/01~2019/11/27';'Platform2 : 2019/10/27~2019/11/14'}...
    ,"FontSize",14,'Interpreter','none')

cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
print('W4_hw4_trajectories','-dpng') %Two drifter trajectories near to Taiwan
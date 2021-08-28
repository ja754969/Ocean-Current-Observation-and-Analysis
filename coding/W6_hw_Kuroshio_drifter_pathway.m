%% Homework (2019/04/17)  
% Compare the pattern of Kuroshio pathway in the 
% periods from 1st November 2015 to 28th March 2016 
% and from 1st November 2017 to 28th March 2018. 
% (Hint: using drifter trajectories to study the Kuroshio)
%%
clear;clc;clf
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
% load W6_Taiwan.dat % 載入海岸線資料

% LATLIM = [0 45]; %浮球資料緯度範圍
% LONGLIM = [118 165]; %浮球資料經度範圍
LATLIM = [10:10:45];
LONGLIM = [115:10:165];
%% function : W6_function_hw_traj_plot.m
%% from 1st November 2015 to 28th March 2016 (浮球資料夾 : DataSelection_20200410_074812_9808579)
subplot(1,2,1)
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_i('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
hold on;
folder1 = 'C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200410_074812_9808579'; 
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200410_074812_9808579') % 設定檔案路徑
db1 = dir('drifting-buoys-*');
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
% db1.name;
for i = 1:length(db1)
  [lon1_traj1,lat1_traj1] = W6_function_hw_traj_plot(db1(i).name,folder1);
end

% [lon1_traj1,lat1_traj1] = W6_function_hw_traj_plot(db1(2).name,folder1); %第1筆浮球資料的檔名，存放到data1
% traj1_p1 = m_plot(lon1_traj1,lat1_traj1);hold on;
% data1 = 'drifting-buoys-21599.csv'; %第1筆浮球資料的檔名，存放到data1
% data1 = 'drifting-buoys-21637.csv'; %第1筆浮球資料的檔名，存放到data1

% data1 = 'drifting-buoys-5100829.csv'; %第1筆浮球資料的檔名，存放到data1
% data1 = 'drifting-buoys-5201701.csv'; %第1筆浮球資料的檔名，存放到data1
% 
% cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200410_074812_9808579') % 設定檔案路徑
% ds1 = datastore(data1); %載入第1筆浮球資料data1，存放到ds1 (type : TabularTextDatastore)
% traj1 = read(ds1); % 讀取第1筆浮球資料ds1，存放到traj1 (type : table)
% lat1_traj = traj1.LATITUDE_degree_north_; % 第1筆浮球資料traj1的緯度，存放到lat1_traj
% % lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
% lon1_traj = traj1.LONGITUDE_degree_east_; % 第1筆浮球資料traj1的經度，存放到lon1_traj
hold off;
xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
% ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W6_hw';'2015/11/01~2016/03/28'}...
    ,"FontSize",14,'Interpreter','none')

cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑

%% from 1st November 2017 to 28th March 2018 (浮球資料夾 : DataSelection_20200410_081743_9808766)
subplot(1,2,2)
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
% ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_i('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','right','box','fancy');
hold on;
folder2 = 'C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200410_081743_9808766';
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200410_081743_9808766') % 設定檔案路徑
db2 = dir('drifting-buoys-*');
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
% db2.name;
for i = 1:length(db2)
  [lon1_traj2,lat1_traj2] = W6_function_hw_traj_plot(db2(i).name,folder2);
end
hold off;


xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W6_hw';'2017/11/01~2018/03/28'}...
    ,"FontSize",14,'Interpreter','none')
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
print('W6_hw','-dpng')
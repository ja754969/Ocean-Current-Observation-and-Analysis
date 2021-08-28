function [lon1_traj,lat1_traj] = W6_function_hw_traj_plot(data,folder)
cd(folder) % 設定檔案路徑
ds1 = datastore(data); %載入浮球資料data，存放到ds1 (type : TabularTextDatastore)
traj1 = read(ds1); % 讀取第1筆浮球資料ds1，存放到traj1 (type : table)
lat1_traj = traj1.LATITUDE_degree_north_; % 浮球資料traj1的緯度，存放到lat1_traj
% lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
lon1_traj = traj1.LONGITUDE_degree_east_; % 浮球資料traj1的經度，存放到lon1_traj
traj1_p = m_plot(lon1_traj,lat1_traj);hold on;
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding') % 設定檔案路徑
end
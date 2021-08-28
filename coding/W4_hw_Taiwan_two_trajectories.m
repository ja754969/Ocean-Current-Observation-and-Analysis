%% The range of map : 20~27 N  118~125 E
clear;clc;clf
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding') % �]�w�ɮ׸��|
load W4_hw_Taiwan.dat % ���J�x�W�����u���

LATLIM = [20 27];
LONGLIM = [118 125];
lon = W4_hw_Taiwan(:,1); %�x�W�����u��ƪ��g��
lat = W4_hw_Taiwan(:,2); %�x�W�����u��ƪ��n��
% fill(lon,lat,[1 1 1]);hold on; % fill : ���
plot(lon,lat,'k');hold on;
axis([LONGLIM(1) LONGLIM(2) LATLIM(1) LATLIM(2)])
axis('image')

print('W4_hw4_coastline','-dpng') % Taiwan coastline
%% drifter trajectories near to Taiwan
% The range of drifter trajectories : 20~27 N  118~125 E
data1 = 'drifting-buoys-2101650.csv'; %��1���B�y��ƪ��ɦW�A�s���data1

cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding\DataSelection_20200327_071146_9750269') % �]�w�ɮ׸��|
ds1 = datastore(data1); %���J��1���B�y���data1�A�s���ds1 (type : TabularTextDatastore)
traj1 = read(ds1); % Ū����1���B�y���ds1�A�s���traj1 (type : table)
lat1_traj = traj1.LATITUDE_degree_north_; % ��1���B�y���traj1���n�סA�s���lat1_traj
% lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
lon1_traj = traj1.LONGITUDE_degree_east_; % ��1���B�y���traj1���g�סA�s���lon1_traj

traj_p1 = plot(lon1_traj,lat1_traj);hold on;
%% 
data2 = 'drifting-buoys-2201576.csv'; %��2���B�y��ƪ��ɦW�A�s���data2
ds2 = datastore(data2); %���J��2���B�y���data2�A�s���ds2 (type : TabularTextDatastore)
traj2 = read(ds2); % Ū����2���B�y���ds2�A�s���traj2 (type : table)
lat2_traj = traj2.LATITUDE_degree_north_; % ��2���B�y���traj2���n�סA�s���lat2_traj
% lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
lon2_traj = traj2.LONGITUDE_degree_east_; % ��2���B�y���traj2���g�סA�s���lon2_traj
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

cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding') % �]�w�ɮ׸��|
print('W4_hw4_trajectories','-dpng') %Two drifter trajectories near to Taiwan
function [lon1_traj,lat1_traj] = W6_function_hw_traj_plot(data,folder)
cd(folder) % �]�w�ɮ׸��|
ds1 = datastore(data); %���J�B�y���data�A�s���ds1 (type : TabularTextDatastore)
traj1 = read(ds1); % Ū����1���B�y���ds1�A�s���traj1 (type : table)
lat1_traj = traj1.LATITUDE_degree_north_; % �B�y���traj1���n�סA�s���lat1_traj
% lat_traj(LATLIM(1) < lat_traj < LATLIM(2)) = NaN;
lon1_traj = traj1.LONGITUDE_degree_east_; % �B�y���traj1���g�סA�s���lon1_traj
traj1_p = m_plot(lon1_traj,lat1_traj);hold on;
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding') % �]�w�ɮ׸��|
end
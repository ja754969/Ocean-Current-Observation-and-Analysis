%% Homework 8 
% Analyze the PCMI data at the Ml and M3 
% stations from 1994 to 1996, to study the spatial 
% and temporal variations of Kuroshio speeds. 
clear;clc;clf
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\NOAA_WOCE_Current Meters')
a=dir('rcm*'); % * 意思 : 在資料夾中取出任意一個 rcm 開頭的檔案
%% 載入資料 rcm02876_m1_90.str
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% for 迴圈讀檔法
% for i = 1
%     filename = a(i).name;
%     fid = fopen(filename,'r') %讀檔 (設定 file id)
% %     rcm02876_m1_90 = textscan(fid,[repmat('%f',1,11)],'headerLines',22);
% %     % repmat : Repeat copies of array
%     while strcmp(fgetl(fid),'line count') == 0
%     %一行一行讀取資料，直到讀取到'*END*'字串為止
%         isEND = feof(fid); %測試檔案是否已讀取到末端(是回應1，否回應0)
%     end
%     rcm = fscanf(fid,'%f'); %接續前面的資料讀取中斷點，繼續往下讀取檔案fid裡的資料
%                             %並且得到一個行向量
%     rcm_m1{i} = rcm;                         
% %     rcm{i} = reshape(ctd_row,8,length(ctd_row)/8)'; %趁機把檔案排序變成(3-2)~(10-2)
%     fclose(fid);
% end
%% 讀檔 rcm02876_m1_90.str
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\NOAA_WOCE_Current Meters')
filename = 'rcm02876_m1_90.str';
fid = fopen(filename,'r') %讀檔 (設定 file id)
rcm02876_m1_90 = textscan(fid,[repmat('%f',1,11)],'headerLines',22);
% repmat : Repeat copies of array
fclose(fid);
rcm02876_m1_90 = cell2mat(rcm02876_m1_90);
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% Data we need: year, month, date, hour, speeds. 
m1_90_year = rcm02876_m1_90(:,4);
m1_90_month = rcm02876_m1_90(:,3);
m1_90_date = rcm02876_m1_90(:,2);
m1_90_hour = rcm02876_m1_90(:,1)/100;
m1_90_speeds = rcm02876_m1_90(:,5); %(cm/sec)
m1_90_speeds(m1_90_speeds < 0) = NaN;
m1_90_time = datenum(m1_90_year,m1_90_month,m1_90_date,m1_90_hour,0,0);
%% Read and plot the data from each RCM
figure(1)
subplot(3,1,1)
plot(m1_90_time,m1_90_speeds)
hold on
set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks') 
%% 
% doc datetick
%% 讀檔 rcm02891_m3_100.str
% Parameters:  
%       hour 
%       day  
%       month
%       year 
%       speed (cm/sec)    
%       dir (deg true)    
%       u (cm/sec)        
%       v (cm/sec)        
%       temp (deg C)      
%       pressure (db)     
%       line count
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\NOAA_WOCE_Current Meters')
filename4 = 'rcm02891_m3_100.str';
fid = fopen(filename4,'r') %讀檔 (設定 file id)
rcm02891_m3_100 = textscan(fid,[repmat('%f',1,11)],'headerLines',22);
% repmat : Repeat copies of array
fclose(fid);
rcm02891_m3_100 = cell2mat(rcm02891_m3_100);
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% Data we need: year, month, date, hour, speeds. 
m3_100_year = rcm02891_m3_100(:,4);
m3_100_month = rcm02891_m3_100(:,3);
m3_100_date = rcm02891_m3_100(:,2);
m3_100_hour = rcm02891_m3_100(:,1)/100;
m3_100_speeds = rcm02891_m3_100(:,5); %(cm/sec)
m3_100_speeds(m3_100_speeds < 0) = NaN;
m3_100_time = datenum(m3_100_year,m3_100_month,m3_100_date,m3_100_hour,0,0);
%% Read and plot the data from each RCM
plot(m3_100_time,m3_100_speeds)
hold off
set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks') 
%% 
ylabel('Current Speed (cm/s)')
legend('M1-90m','M3-100m','Location','best');
%% rcm02881_m1_190
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\NOAA_WOCE_Current Meters')
filename2 = 'rcm02881_m1_190.str';
fid = fopen(filename2,'r') %讀檔 (設定 file id)
rcm02881_m1_190 = textscan(fid,[repmat('%f',1,10)],'headerLines',21);
% repmat : Repeat copies of array
fclose(fid);
rcm02881_m1_190 = cell2mat(rcm02881_m1_190);
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% Data we need: year, month, date, hour, speeds. 
m1_190_year = rcm02881_m1_190(:,4);
m1_190_month = rcm02881_m1_190(:,3);
m1_190_date = rcm02881_m1_190(:,2);
m1_190_hour = rcm02881_m1_190(:,1)/100;
m1_190_speeds = rcm02881_m1_190(:,5); %(cm/sec)
m1_190_speeds(m1_190_speeds < 0) = NaN;
m1_190_time = datenum(m1_190_year,m1_190_month,m1_190_date,m1_190_hour,0,0);

%%
subplot(3,1,2)
plot(m1_190_time,m1_190_speeds)
hold on
set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks') 
%% rcm02893_m3_200
% Parameters:  
%       hour 
%       day  
%       month
%       year 
%       speed (cm/sec)    
%       dir (deg true)    
%       u (cm/sec)        
%       v (cm/sec)        
%       temp (deg C)      
%       pressure (db)     
%       line count
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\NOAA_WOCE_Current Meters')
filename5 = a(5).name;
fid = fopen(filename5,'r') %讀檔 (設定 file id)
rcm02893_m3_200 = textscan(fid,[repmat('%f',1,11)],'headerLines',22);
% repmat : Repeat copies of array
fclose(fid);
rcm02893_m3_200 = cell2mat(rcm02893_m3_200);
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% Data we need: year, month, date, hour, speeds. 
m3_200_year = rcm02893_m3_200(:,4);
m3_200_month = rcm02893_m3_200(:,3);
m3_200_date = rcm02893_m3_200(:,2);
m3_200_hour = rcm02893_m3_200(:,1)/100;
m3_200_speeds = rcm02893_m3_200(:,5); %(cm/sec)
m3_200_speeds(m3_200_speeds < 0) = NaN;
m3_200_time = datenum(m3_200_year,m3_200_month,m3_200_date,m3_200_hour,0,0);

%%
subplot(3,1,2)
plot(m3_200_time,m3_200_speeds)
hold off
set(gca,'ylim',[0 100]) 
datetick('x',20,'keeplimits','keepticks') 
ylabel('Current Speed (cm/s)')
legend('M1-190m','M3-200m');

%% rcm02883_m1_290
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\NOAA_WOCE_Current Meters')
filename3 = 'rcm02883_m1_290.str';
fid = fopen(filename3,'r') %讀檔 (設定 file id)
rcm02883_m1_290 = textscan(fid,[repmat('%f',1,10)],'headerLines',21);
% repmat : Repeat copies of array
fclose(fid);
rcm02883_m1_290 = cell2mat(rcm02883_m1_290);
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% Data we need: year, month, date, hour, speeds. 
m1_290_year = rcm02883_m1_290(:,4);
m1_290_month = rcm02883_m1_290(:,3);
m1_290_date = rcm02883_m1_290(:,2);
m1_290_hour = rcm02883_m1_290(:,1)/100;
m1_290_speeds = rcm02883_m1_290(:,5); %(cm/sec)
m1_290_speeds(m1_290_speeds < 0) = NaN;
m1_290_time = datenum(m1_290_year,m1_290_month,m1_290_date,m1_290_hour,0,0);
%%
subplot(3,1,3)
plot(m1_290_time,m1_290_speeds)
hold on
set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks')
%% rcm02895_m3_400
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\NOAA_WOCE_Current Meters')
filename6 = a(6).name;
fid = fopen(filename6,'r') %讀檔 (設定 file id)
rcm02895_m3_400 = textscan(fid,[repmat('%f',1,10)],'headerLines',21);
% repmat : Repeat copies of array
fclose(fid);
rcm02895_m3_400 = cell2mat(rcm02895_m3_400);
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% Data we need: year, month, date, hour, speeds. 
m3_400_year = rcm02895_m3_400(:,4);
m3_400_month = rcm02895_m3_400(:,3);
m3_400_date = rcm02895_m3_400(:,2);
m3_400_hour = rcm02895_m3_400(:,1)/100;
m3_400_speeds = rcm02895_m3_400(:,5); %(cm/sec)
m3_400_speeds(m1_290_speeds < 0) = NaN;
m3_400_time = datenum(m3_400_year,m3_400_month,m3_400_date,m3_400_hour,0,0);
%%
subplot(3,1,3)
plot(m3_400_time,m3_400_speeds)
hold off
set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks')
legend('M1-290m','M3-400m');
ylabel('Current Speed (cm/s)')
xlabel('Date[dd/mm/yy]')
%% 
print('W10_hw','-dpng')
%% 比較同測站的不同深度流速
figure(2)
subplot(2,1,1)
plot(m1_90_time,m1_90_speeds)
hold on
plot(m1_190_time,m1_190_speeds)
hold on
plot(m1_290_time,m1_290_speeds)
hold off

set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks') 
legend('M1-90m','M1-190m','M1-290m');
ylabel('Current Speed (cm/s)')
% -------------------------------------------------------------------------
subplot(2,1,2)
plot(m3_100_time,m3_100_speeds)
hold on
plot(m3_200_time,m3_200_speeds)
hold on
plot(m3_400_time,m3_400_speeds)
hold off

set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks') 
legend('M3-100m','M3-200m','M3-400m');
ylabel('Current Speed (cm/s)')
xlabel('Date[dd/mm/yy]')
print('W10_hw_02','-dpng')
%% Plot arrows emanating from origin (u 、 v)
figure(3)

m1_90_u = rcm02876_m1_90(:,7); %(cm/sec)
m1_90_u(m1_90_u == -999.9) = NaN;
m1_90_v = rcm02876_m1_90(:,8); %(cm/sec)
m1_90_v(m1_90_v == -999.9) = NaN;
subplot(2,3,1)
compass(m1_90_u,m1_90_v,'r')
title('M1-90m');

m3_100_u = rcm02891_m3_100(:,7); %(cm/sec)
m3_100_u(m3_100_u == -999.9) = NaN;
m3_100_v = rcm02891_m3_100(:,8); %(cm/sec)
m3_100_v(m3_100_v == -999.9) = NaN;
subplot(2,3,4)
compass(m3_100_u,m3_100_v,'r')
title('M3-100m');

m1_190_u = rcm02881_m1_190(:,7); %(cm/sec)
m1_190_u(m1_190_u == -999.9) = NaN;
m1_190_v = rcm02881_m1_190(:,8); %(cm/sec)
m1_190_v(m1_190_v == -999.9) = NaN;
subplot(2,3,2)
compass(m1_190_u,m1_190_v,'g')
title('M1-190m');

m3_200_u = rcm02893_m3_200(:,7); %(cm/sec)
m3_200_u(m3_200_u == -999.9) = NaN;
m3_200_v = rcm02893_m3_200(:,8); %(cm/sec)
m3_200_v(m3_200_v == -999.9) = NaN;
subplot(2,3,5)
compass(m3_200_u,m3_200_v,'g')
title('M3-200m');

m1_290_u = rcm02883_m1_290(:,7); %(cm/sec)
m1_290_u(m1_290_u == -999.9) = NaN;
m1_290_v = rcm02883_m1_290(:,8); %(cm/sec)
m1_290_v(m1_290_v == -999.9) = NaN;
subplot(2,3,3)
compass(m1_290_u,m1_290_v,'b')
title('M1-290m');

m3_400_u = rcm02895_m3_400(:,7); %(cm/sec)
m3_400_u(m3_400_u == -999.9) = NaN;
m3_400_v = rcm02895_m3_400(:,8); %(cm/sec)
m3_400_v(m3_400_v == -999.9) = NaN;
subplot(2,3,6)
compass(m3_400_u,m3_400_v,'b')
title('M3-400m');
print('W10_hw_03','-dpng')
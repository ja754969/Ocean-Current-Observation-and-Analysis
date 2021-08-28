%%
% help m_map
%% 載入資料 rcm02876_m1_90.str
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
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
clear;clc;clf
% load('rcm02876_m1_90.str');
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
plot(m1_90_time,m1_90_speeds)
hold on
set(gca,'ylim',[0 100],'xlim',[datenum(94,9,1) datenum(96,7,1)]) 
datetick('x',20,'keeplimits','keepticks') 
%% 
% doc datetick
%% rcm02881_m1_190
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
%       line count
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
plot(m1_190_time,m1_190_speeds)
hold on
set(gca,'ylim',[0 100]) 
datetick('x',20,'keeplimits','keepticks') 
%% rcm02883_m1_290
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
%       line count
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
plot(m1_290_time,m1_290_speeds)
hold on
set(gca,'ylim',[0 100]) 
datetick('x',20,'keeplimits','keepticks')
%% 
ylabel('Current Speed (cm/s)')
legend('90m','190m','290m');
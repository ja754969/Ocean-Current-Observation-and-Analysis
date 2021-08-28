%% DataSelection_20200528_014158_9991089
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
clear;clc;clf
%% Read data and skip heading lines (for loop method)
% No salinity data for Argo 2902975
% 1 : PLATFORM	
% 2 : ARGOS_ID	
% 3 : DATE (YYYY-MM-DDTHH:MI:SSZ)	
% 4 : LATITUDE (degree_north)	
% 5 : LONGITUDE (degree_east)	
% 6 : PRES (decibar)	
% 7 : TEMP (degree_Celsius)	
% 8 : PSAL (psu)
% 9 : QC	
% 10 : STATION_PARAMETERS	
% 11 : VERTICAL_SAMPLING_SCHEME	
% 12 : CONFIG_MISSION_NUMBER	
% 13 : PROFILE_NUMBER
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200528_014158_9991089')
argo = dir('argo-profiles-*');
for i = 1:4
    ds{i} = datastore(argo(i).name);
    argo_profiles{i} = read(ds{i});
%     argo_profiles_cell{i} = table2cell(argo_profiles{i}(:,:));
%     argo_profiles_array{i} = cell2array(argo_profiles_ds{i});
    eval(['xlon_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,5));']);
    eval(['ylat_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,4));']);
    eval(['p_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,6));']);
    eval(['t_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,7));']);
end
%% Get Variable ( 變數一個一個拿 )
% xlon_2902975 = table2array(argo_profiles{1}(:,5));
% ylat_2902975 = table2array(argo_profiles{1}(:,4));
% p_2902975 = table2array(argo_profiles{1}(:,6));
% t_2902975 = table2array(argo_profiles{1}(:,7));
%% Read data and skip heading lines 
% filename = 'argo-profiles-2903193.csv';
% fid = fopen(filename, 'r');
% argo_profiles_2903193 = textscan(fid, '%f %f %s %f %f %f %f %f %f %s %s %f %f',...
%     'headerLines', 1,'Delimiter',',');
% fclose(fid);
% xlon_2903193 = argo_profiles_2903193{:,5};
% ylat_2903193 = argo_profiles_2903193{:,4};
% p_2903193 = argo_profiles_2903193{:,6};
% t_2903193 = argo_profiles_2903193{:,7};
% cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%%
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
%% T-P diagram (溫度、深度) Plot temperature profiles
figure(1)
for i = 1:4
   eval(['tp_profiles_' argo(i).name(end-10:end-5) '= plot(t_'...
       argo(i).name(end-10:end-4) ',p_'...
       argo(i).name(end-10:end-4) ',''.-'');']);
   hold on;
end
hold off;
set(gca,'ydir','reverse', 'ylim',[0,1000])
title('Temperature v.s Pressure','Interpreter','none')
xlabel('Temperature(^{\circ}C)');ylabel('Depth(m)')
% for i = 1:4
%     eval(['legend({' 'tp_profiles_' argo(i).name(end-10:end-5) ...
%         '},''argo-profiles-' argo(i).name(end-10:end-5)...
%         ''',''Location'',''best'');']);
% end
% legend({tp_profiles_290297},'argo-profiles-','Location','best');
print('W13_class01_argo_profiles','-dpng')
%% Plot Argo locations
figure(2)
LATLIM = [23:2.5:28];
LONGLIM = [125:2.5:133];
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
m_plot(xlon_2902990(1,1),ylat_2902990(1,1),'Marker','^','Markersize',10,'MarkerFaceColor','r');hold on;
m_plot(xlon_2902975(1,1),ylat_2902975(1,1),'Marker','*','Markersize',10,'MarkerFaceColor','r');hold on;
m_plot(xlon_2903186(1,1),ylat_2903186(1,1),'Marker','s','Markersize',10,'MarkerFaceColor','r');hold on;
m_plot(xlon_2903193(1,1),ylat_2903193(1,1),'Marker','h','Markersize',10,'MarkerFaceColor','r')
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
title('Location of Profiles','Interpreter','none')
print('W13_class02_argo_profiles','-dpng')

%% Downwelling from section
Tall=t_2902990(1:80); Pall=p_2902990(1:80);xall=xlon_2902990(1:80);
Tall=[Tall t_2903193(1:80)]; Pall=[Pall p_2903193(1:80)];xall=[xall xlon_2903193(1:80)];
Tall=[Tall t_2903186(1:80)]; Pall=[Pall p_2903186(1:80)];xall=[xall xlon_2903186(1:80)];
Tall=[Tall t_2902975(1:80)]; Pall=[Pall p_2902975(1:80)];xall=[xall xlon_2902975(1:80)];
figure(3)
contourf(xall,Pall,Tall,'linecolor','none')
cb = colorbar;
caxis([0 32]);
cb.Label.String = 'Temperature(^{\circ}C)';
set(gca,'ydir','reverse','ylim',[0 1000])
title('');xlabel('Longitude(^{\circ}E)');ylabel('Depth(m)')
print('W13_class03_argo_profiles','-dpng')
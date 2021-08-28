%% 
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
clear;clc;clf
%% Read CTD data and skip heading lines (for loop method)

% 1 : PLATFORM	
% 2 : DATE (YYYY-MM-DDTHH:MI:SSZ)		
% 3 : LATITUDE (degree_north)	
% 4 : LONGITUDE (degree_east)	
% 5 : PRES (decibar)	
% 6 : TEMP (degree_Celsius)	
% 7 : PSAL (psu)
% 8 : DOX1 (ml/l)	
% 9 : QC	
% 10 : STATION_NUMBER
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200604_000817_9994417')
%%
filename='ctd-profiles-JGQH.csv';
fid = fopen(filename,'r');
Data = textscan(fid, '%s %s %f %f %f %f %f %f %f %f', 'headerLines', 1,'Delimiter',',');
fclose(fid);
ylat_JGQH = Data{:,3};
xlon_JGQH = Data{:,4};
p = Data{:,5};
t = Data{:,6};
s = Data{:,7};
id = Data{:,10}; % STATION_NUMBER
%%
% CTD = dir('ctd-profiles-*');
% % ds = datastore(CTD);
% for i = 1:2
%     ds{i} = datastore(CTD(i).name);
% %     ctd_profiles{i} = read(ds{i});
% % %     ctd_profiles_cell{i} = table2cell(ctd_profiles{i}(:,:));
% % %     ctd_profiles_array{i} = cell2array(ctd_profiles_ds{i});
% %     eval(['xlon_' CTD(i).name(end-7:end-4) '= table2array(ctd_profiles{i}(:,4));']);
% %     eval(['ylat_' CTD(i).name(end-7:end-4) '= table2array(ctd_profiles{i}(:,3));']);
% %     eval(['p_' CTD(i).name(end-7:end-4) '= table2array(ctd_profiles{i}(:,5));']);
% %     eval(['t_' CTD(i).name(end-7:end-4) '= table2array(ctd_profiles{i}(:,6));']);
% %     eval(['s_' CTD(i).name(end-7:end-4) '= table2array(ctd_profiles{i}(:,7));']);
% %     eval(['id_' CTD(i).name(end-7:end-4) '= table2array(ctd_profiles{i}(:,10));']);
% end
%%
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
figure(1)
plot(xlon_JGQH,ylat_JGQH)
print('W14_class01_ctd','-dpng')
%% Confirm the locations of CTD stations
figure(2)
LATLIM = 21:1.5:37;
LONGLIM = 120:1.5:141;
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面
% m_plot(xlon_JGQH,ylat_JGQH);
m_scatter(xlon_JGQH,ylat_JGQH);
% ,'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_i('patch',[0.7 0.7 0.7],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
title('Location of CTD','Interpreter','none')
% xlabel('Temperature(^{\circ}C)');ylabel('Depth(m)')
% legend({tp_profiles_290297},'argo-profiles-','Location','best');
print('W14_class02_ctd','-dpng')
%% 將 STATION_NUMBER 的所有資料分類
id_unique = unique(id); % station ID
%% Separate each profile into column data
for m = 1:length(id_unique)
    I = find(id == id_unique(m));
    Pall(:,m) = p(I(1:800));
    Tall(:,m) = t(I(1:800));
    Sall(:,m) = s(I(1:800));
    Yall_JGQH(:,m) = ylat_JGQH(I(1:800));
end
%% Plot contour fill for the section of temperature profiles
figure(3)
% max(t)
% min(t)
contourf(Yall_JGQH,Pall,Tall,[2:0.5:30],'linecolor','none')
colorbar;
caxis([0 30]); 
hold on;
colormap jet
[C,h] = contour(Yall_JGQH,Pall,Tall,[2:0.5:30],'linecolor','k'); 
clabel(C,h); 
set(gca,'ydir','reverse');
hold off;

title('The section of temperature profiles');
xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
print('W14_class03_ctd','-dpng')
%% Calculate Temperature Vertical Gradient (dT/dz)
figure(4)
dTdz = diff(Tall,1,1)./diff(Pall,1,1);
contourf(Yall_JGQH(1:end-1,:),Pall(1:end-1,:),-dTdz,[-0.1:0.05:0.3],'linecolor','none');
colorbar;
caxis([-0.1 0.3]);
set(gca,'ydir','reverse');
title('Temperature Vertical Gradient (dT/dz)');
xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
print('W14_class04_ctd','-dpng')
%% Plot contour fill for the section of salinity profiles
figure(5)
% max(s)
% min(s)
contourf(Yall_JGQH,Pall,Sall,[34:0.05:35],'linecolor','none')
colorbar;
caxis([34 35]);
hold on;
colormap jet
[C,h] = contour(Yall_JGQH,Pall,Sall,[34:0.05:35],'linecolor','k'); 
clabel(C,h); 
set(gca,'ydir','reverse');
hold off;

title('The section of salinity profiles');
xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
print('W14_class05_ctd','-dpng')


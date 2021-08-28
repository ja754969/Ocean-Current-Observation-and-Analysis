%% DataSelection_20200606_121421_10003113
% 2008/12/20 ~ 12/31
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
%% 5901579 (黑潮) 行資料名稱
% PLATFORM,
% ARGOS_ID,
% DATE (YYYY-MM-DDTHH:MI:SSZ),
% LATITUDE (degree_north),
% LONGITUDE (degree_east),
% PRES (decibar),
% TEMP (degree_Celsius),
% PSAL (psu),
% PRES_ADJUSTED (decibar),
% TEMP_ADJUSTED (degree_Celsius),
% PSAL_ADJUSTED (psu),
% QC,
% STATION_NUMBER,
% BATHY,
% PARAMETER,
% PREDEPLOYMENT_CALIB_EQUATION,
% PREDEPLOYMENT_CALIB_COEFFICIENT,
% PREDEPLOYMENT_CALIB_COMMENT,
% BATHY_QC,
% STATION_PARAMETERS,
% STATION_GLOBAL_QC,
% CALIBRATION_DATE,
% VERTICAL_SAMPLING_SCHEME,
% CONFIG_MISSION_NUMBER,
% PROFILE_NUMBER,
% DATA_MODE
%% 2901169 (南中國海) 行資料名稱
% PLATFORM,
% ARGOS_ID,
% DATE (YYYY-MM-DDTHH:MI:SSZ),
% LATITUDE (degree_north),
% LONGITUDE (degree_east),
% PRES (decibar),
% TEMP (degree_Celsius),
% PSAL (psu),
% PRES_ADJUSTED (decibar),
% TEMP_ADJUSTED (degree_Celsius),
% PSAL_ADJUSTED (psu),
% QC,
% STATION_NUMBER,
% PARAMETER,
% PREDEPLOYMENT_CALIB_EQUATION,
% PREDEPLOYMENT_CALIB_COEFFICIENT,
% PREDEPLOYMENT_CALIB_COMMENT,
% STATION_PARAMETERS,
% CALIBRATION_DATE,
% VERTICAL_SAMPLING_SCHEME,
% CONFIG_MISSION_NUMBER,
% PROFILE_NUMBER,
% DATA_MODE
%% 讀取變數
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding\DataSelection_20200606_121421_10003113')
argo = dir('argo-profiles-*');
% ds = datastore(argo(10).name);
% argo_profiles = read(ds);
% %     argo_profiles_cell{i} = table2cell(argo_profiles{i}(:,:));
% %     argo_profiles_array{i} = cell2array(argo_profiles_ds{i});
% eval(['xlon_' argo(10).name(15:end-4) '= table2array(argo_profiles(:,5));']);
% eval(['ylat_' argo(10).name(15:end-4) '= table2array(argo_profiles(:,4));']);
% eval(['p_' argo(10).name(15:end-4) '= table2array(argo_profiles(:,6));']);
% eval(['t_' argo(10).name(15:end-4) '= table2array(argo_profiles(:,7));']);
for i = [7,10]
    ds{i} = datastore(argo(i).name);
    argo_profiles{i} = read(ds{i});
%     argo_profiles_cell{i} = table2cell(argo_profiles{i}(:,:));
%     argo_profiles_array{i} = cell2array(argo_profiles_ds{i});
    eval(['xlon_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,5));']);
    eval(['ylat_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,4));']);
    eval(['p_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,6));']);
    eval(['t_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,7));']);
    eval(['s_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,8));']);
end
% 抓出不同的緯度 : argo_profiles{i}(:,4)，用來區別測點位置
for i = [7,10]
    eval(['id_ylat_' argo(i).name(15:end-4) '= unique(table2array(argo_profiles{i}(:,4)));']); % ,''stable''
    for j = 1:length(eval(['id_ylat_' argo(i).name(15:end-4)]))
        eval(['id_row_' argo(i).name(15:end-4) '_' num2str(j) '= find(ylat_' argo(i).name(15:end-4) '== id_ylat_' argo(i).name(15:end-4) '(j));']);
    end
%     eval(['p_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,6));']);
%     eval(['t_' argo(i).name(15:end-4) '= table2array(argo_profiles{i}(:,7));']);
end
%% Read data and skip heading lines 
% filename = 'argo-profiles-2902990.csv';
% fid = fopen(filename, 'r');
% argo_profiles_2902990 = textscan(fid, '%f %f %s %f %f %f %f %f %f %s %s %f %f',...
%     'headerLines', 1,'Delimiter',',');
% fclose(fid);
% xlon_2902990 = argo_profiles_2902990{:,5};
% ylat_2902990 = argo_profiles_2902990{:,4};
% p_2902990 = argo_profiles_2902990{:,6};
% t_2902990 = argo_profiles_2902990{:,7};
%%
cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
% eval(['plot(xlon_' argo(2).name(15:end-4) '(1,1),ylat_' argo(2).name(15:end-4) '(1,1),''.'');']);
% for i=1:4
%     eval(['plot(xlon_' argo(i).name(15:end-4) '(1,1),ylat_' argo(i).name(15:end-4) '(1,1),''.'',''MarkerSize'',10);hold on;']);
% end
% hold off;

%% Plot Argo locations
figure(1)
LATLIM = [20.5:1.5:28];
LONGLIM = [115:1.5:127];
m_proj('miller','lon',[LONGLIM(1) LONGLIM(end)],'lat',[LATLIM(1) LATLIM(end)]); % 繪製海面(白色)
eval(['j_' argo(7).name(15:end-4) '= [1,2,4];']);
eval(['j_' argo(10).name(15:end-4) '= 9:11;']);
for i = [7,10]
    eval(['id_xlon_' argo(i).name(15:end-4) '= unique(table2array(argo_profiles{i}(:,5)));']); % ,''stable''
    for j = eval(['j_' argo(i).name(15:end-4) ])
    eval(['m_plot(id_xlon_' argo(i).name(15:end-4) '(j,1),id_ylat_' argo(i).name(15:end-4) '(j,1),''.'',''MarkerSize'',12);hold on;']);
    eval(['m_text(id_xlon_' argo(i).name(15:end-4) '(j_' argo(i).name(15:end-4) ...
        '(1),1)+0.25,id_ylat_' argo(i).name(15:end-4) '(j_' argo(i).name(15:end-4) ...
        '(1),1),''argo-profiles-' argo(i).name(15:end-4) ''',''FontSize'',7.5,''Color'',''b'');']);
    end
%     for j = eval(['id_ylat_' argo(i).name(15:end-4) '(end-3)']):eval(['id_ylat_' argo(i).name(15:end-4) '(end)'])
%     eval(['m_text(id_xlon_' argo(i).name(15:end-4) '(j,1)+0.25,id_ylat_' argo(i).name(15:end-4) '(j,1),''argo-profiles-' argo(i).name(15:end-4) ''',''FontSize'',7.5,''Color'',''b'');']);
%     end
    
end
hold off;
m_gshhs_h('patch',[0.7 0.7 0.7],'edgecolor','k');    %繪製陸地
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM,'ytick',LATLIM,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
title({'Location of Profiles';'SCS and Kuroshio';'2008/12/20 ~ 2008/12/31'},'Interpreter','none')
% legend([location(7),location(10)],'7','10','Location','best');
print('W13_hw01_argo_profiles','-dpng')

%% T-P diagram (溫度、深度) Plot temperature profiles
figure(2)
k = 1;
for i = [7,10]
    sp_tp(k) = subplot(1,2,k);
    for j = eval(['j_' argo(i).name(15:end-4) ])
        eval(['t_' argo(i).name(15:end-4) '_' num2str(j) '= t_' argo(i).name(15:end-4) '(find(ylat_' argo(i).name(15:end-4) '== id_ylat_' argo(i).name(15:end-4) '(j)),1);']);
        eval(['s_' argo(i).name(15:end-4) '_' num2str(j) '= s_' argo(i).name(15:end-4) '(find(ylat_' argo(i).name(15:end-4) '== id_ylat_' argo(i).name(15:end-4) '(j)),1);']);
        eval(['p_' argo(i).name(15:end-4) '_' num2str(j) '= p_' argo(i).name(15:end-4) '(find(ylat_' argo(i).name(15:end-4) '== id_ylat_' argo(i).name(15:end-4) '(j)),1);']);
        eval(['tp_profiles_' argo(i).name(end-10:end-5) '= plot(t_' argo(i).name(end-10:end-4) '_' num2str(j) ',p_' argo(i).name(end-10:end-4) '_' num2str(j) ',''.-'');']);
        hold on;
    end
    hold off;
    grid on;
    set(gca,'ydir','reverse');
    xlabel('Temperature(^{\circ}C)');ylabel('Depth(m)');
    k = k + 1;
end
title(sp_tp(1),{'Temperature v.s Pressure';'SCS'},'Interpreter','none');
title(sp_tp(2),{'Temperature v.s Pressure';'Kuroshio'},'Interpreter','none');
print('W13_hw02_argo_profiles','-dpng')

%% Temperature section
figure(4)
k = 1;
for i = [7,10]
    sb_section(k) = subplot(1,2,k);
    eval(['Tall_' argo(i).name(15:end-4) '= [];']);
    eval(['Sall_' argo(i).name(15:end-4) '= [];']);
    eval(['Pall_' argo(i).name(15:end-4) '= [];']);
    eval(['Yall_' argo(i).name(15:end-4) '= [];']);
    for j = eval(['j_' argo(i).name(15:end-4) ])
        eval(['ylat_' argo(i).name(15:end-4) '_' num2str(j) '= ylat_' argo(i).name(15:end-4) '(find(ylat_' argo(i).name(15:end-4) '== id_ylat_' argo(i).name(15:end-4) '(j)),1);']);
        eval(['Tall_' argo(i).name(15:end-4) '= [Tall_' argo(i).name(15:end-4)  ' t_' argo(i).name(15:end-4) '_' num2str(j) '(1:45)];']);
        eval(['Sall_' argo(i).name(15:end-4) '= [Sall_' argo(i).name(15:end-4)  ' s_' argo(i).name(15:end-4) '_' num2str(j) '(1:45)];']);
        eval(['Pall_' argo(i).name(15:end-4) '= [Pall_' argo(i).name(15:end-4)  ' p_' argo(i).name(15:end-4) '_' num2str(j) '(1:45)];']);
        eval(['Yall_' argo(i).name(15:end-4) '= [Yall_' argo(i).name(15:end-4)  ' ylat_' argo(i).name(15:end-4) '_' num2str(j) '(1:45)];']);
%         hold on;
    end
    eval(['contourf(Yall_' argo(i).name(15:end-4) ...
        ',Pall_' argo(i).name(15:end-4) ...
        ',Tall_' argo(i).name(15:end-4) ',200,''linecolor'',''none'');']);
%     shading interp
    cb = colorbar;
    % caxis([0 32]);
    cb.Label.String = 'Temperature(^{\circ}C)';
%     colormap jet;
    set(gca,'ydir','reverse')
    xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
    k = k+1;
end
title(sb_section(1),{'Temperature section';'SCS'},'Interpreter','none');
title(sb_section(2),{'Temperature section';'Kuroshio'},'Interpreter','none');
print('W13_hw04_argo_profiles','-dpng')
%% Salinity section
figure(5)
k = 1;
for i = [7,10]
    sb_section(k) = subplot(1,2,k);
    
    eval(['contourf(Yall_' argo(i).name(15:end-4) ...
        ',Pall_' argo(i).name(15:end-4) ...
        ',Sall_' argo(i).name(15:end-4) ',200,''linecolor'',''none'');']);
%     shading interp
    cb = colorbar;
    % caxis([0 32]);
    cb.Label.String = 'Salinity(psu)';
%     colormap jet;
    set(gca,'ydir','reverse')
    xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
    k = k+1;
end
title(sb_section(1),{'Salinity section';'SCS'},'Interpreter','none');
title(sb_section(2),{'Salinity section';'Kuroshio'},'Interpreter','none');
print('W13_hw05_argo_profiles','-dpng')
%% T-S diagram (溫度、鹽度，密度) 
figure(3)
cd('C:\Users\user\Documents\MATLAB\CTD')
% dense = den_CTD()

cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
dep = 1:45;
k = 1;
for i = [7,10]
    sb_ts(k) = subplot(1,2,k);
    eval(['S{i,1} = linspace(min(Sall_' argo(i).name(15:end-4) ...
        '(:)),max(Sall_' argo(i).name(15:end-4) '(:)),45);']);
    % 從平均鹽度的最大值與最小值之間，創造45筆資料存放到 S{i,1}
    eval(['T{i,1} = linspace(min(Tall_' argo(i).name(15:end-4) ...
        '(:)),max(Tall_' argo(i).name(15:end-4) '(:)),45);']);
    % 從平均溫度的最大值與最小值之間，創造45筆資料存放到 T{i,1}
    [SS{i,1},TT{i,1}] = meshgrid(S{i,1},T{i,1});
    cd('C:\Users\user\Documents\MATLAB\CTD')
    sigma{i,1} = den_CTD(SS{i,1},TT{i,1},dep)-1000; % 函式 den_CTD
    cd('C:\Users\user\Google 雲端硬碟\洋流觀測分析_1082\coding')
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %繪製等位密度線
    clabel(c1,h1);hold on %顯示數值
    for j = eval(['j_' argo(i).name(15:end-4) ])
        eval(['ts_' argo(i).name(end-10:end-5) '= plot(s_' argo(i).name(end-10:end-4) '_' num2str(j) ',t_' argo(i).name(end-10:end-4) '_' num2str(j) ',''.'');']);
        hold on;
    end
    
    hold off;
%     set(gca,'ylim',[,]);
    xlabel('Salinity(psu)');ylabel('Temperature(^{\circ}C)');
    k = k + 1;
end
title(sb_ts(1),{'T-S diagram';'SCS'},'Interpreter','none');
title(sb_ts(2),{'T-S diagram';'Kuroshio'},'Interpreter','none');
% hold off;
% for i = 1:4
%     eval(['legend({' 'tp_profiles_' argo(i).name(end-10:end-5) ...
%         '},''argo-profiles-' argo(i).name(end-10:end-5)...
%         ''',''Location'',''best'');']);
% end
% legend({tp_profiles_290297},'argo-profiles-','Location','best');
print('W13_hw03_argo_profiles','-dpng')
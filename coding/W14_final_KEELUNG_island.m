%% 1082 �������i 2020/06/19
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
clear;clc;clf
load keelung_island.dat
% figure
% keelung_island(keelung_island >= 0) = nan;
% LONLIM = [121 122];LATLIM = [25 26];
% lon = LONLIM(1):5/60:LONLIM(2);
% lat = LATLIM(2):-5/60:LATLIM(1); %�b�n�׸�Ƥ��W�U�A��,�ϥγo�Ӥ�k����L��
% [xx,yy] = meshgrid(lon,lat);
% pcolor(xx,yy,keelung_island);shading flat
% % contourf(xx,yy,taiwan);shading flat
% set(gca,'tickdir','out','LineWidth',4);
% % set(gca,'xtick',[LONLIM(1):6:LONLIM(2)],'ytick',[LATLIM(1):6:LATLIM(2)]);
% colormap('jet')
% colorbar
% caxis([-250 0]);
% axis('image') %���ϧΦb�Y�񤧫ᤣ�|�ܧ�
% title('\it Relief Model of Taiwan','FontSize',20,'FontName','Agency FB');
% xlabel('Lontitude','FontName','Algerian');ylabel('Latitude','FontName','Algerian');
%% �@�~���� (Final Report using ��cr2370.zip��)
% 1.(25%) What are the main direction of the observed currents around the Keelung Island 
% during the cruise experiment of CR2370 (using ��cr2370000_000000.LTA��)?

% 2.(25%) Describe the ocean currents during the cruise experiment.

% 3.(25%) Guess: what is the main force that drives the observed currents 
% around the Keelung Island? 

% 4.(25%) Describe the ocean vertical structure during the cruise experiment 
% (using ��c*-1.txt��). Could we find the thermocline?
%% using ��cr2370000_000000.LTA��
% LTA : ���ɶ��g����ADCP�������(Binary�榡�A�w�]�t�g�n�׸��)
% Ens	
% YR	
% MO	
% DA	
% HH	
% MM	
% SS	
% HH
% 
% "Eas"	"mm/s"   1 mm/s = 0.1 cm/s = 0.001 m/s
% "Nor"	"mm/s"
%
% "FLat"	"deg"
% "FLon"	"deg"
% "LLat"	"deg"
% "LLon"    "deg"									
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\WinADCP')
filename = 'ADCP_WEEK14_hw_uv_gps.txt';
ds1 = datastore(filename); %���J��1�����data1�A�s���ds1 (type : TabularTextDatastore)
ADCP_WEEK14_hw = read(ds1); % Ū����1�����ds1�A�s���ADCP_WEEK14_hw (type : table)
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
%% ���y��g�n�׸��(ADCP_WEEK14_hw.txt)
criuse_id = 'cr2370';
ADCP_WEEK14_hw(1:2,:) = []; % �R���e��檺�h����
eval(['first_lat_' criuse_id '= str2double(ADCP_WEEK14_hw.FLat);']);
% str2double : �N�o�̪� cell array �ഫ�� Double-precision array
eval(['first_lon_' criuse_id '= str2double(ADCP_WEEK14_hw.FLon);']);

eval(['last_lat_' criuse_id '= str2double(ADCP_WEEK14_hw.LLat);']);
% str2double : �N�o�̪� cell array �ഫ�� Double-precision array
eval(['last_lon_' criuse_id '= str2double(ADCP_WEEK14_hw.LLon);']);

eval(['avg_lat_' criuse_id '= (first_lat_' criuse_id '+ last_lat_' criuse_id ')/2;']);
eval(['avg_lon_' criuse_id '= (first_lon_' criuse_id '+ last_lon_' criuse_id ')/2;']);

eval(['u_' criuse_id '= str2double(ADCP_WEEK14_hw.Eas);']); % 
eval(['v_' criuse_id '= str2double(ADCP_WEEK14_hw.Nor);']);

% eval([]);
figure(1) % ����
plot(avg_lon_cr2370(:,:),avg_lat_cr2370(:,:),'.','Color',[0.8500 0.3250 0.0980]);hold on;
print('W14_final_01_ctd','-dpng')
%% ø�s�a�ϡB�y�ڹ� (removing the "GPS" ship velocities , ����)
figure(2)
LATLIM1 = [25.1:0.05:25.25];
LONGLIM1 = [121.7:0.05:121.85];
m_proj('miller','lon',[LONGLIM1(1) LONGLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % ø�s����(�զ�)
[CS,CH] = m_etopo2('contourf',[-1000:10:0],'edgecolor','none');

m_gshhs_f('patch',[.2 .2 .2],'edgecolor','k');    %ø�s���a
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
hold on;
m_plot(avg_lon_cr2370(:,:),avg_lat_cr2370(:,:),'.','Color',[0.8500 0.3250 0.0980]);hold on;
q = m_quiver([avg_lon_cr2370(:,:);121.725],[avg_lat_cr2370(:,:);25.125],...
    [u_cr2370(:);1000],[v_cr2370(:);0],1,'Color',[0 0.4470 0.7410],'MarkerSize',1,'LineWidth',1);hold on; % mm/s
m_text(121.725,25.12,'1 m/s','FontSize',10,'color','r');hold on; % mm/s
% q2 = m_quiver(121.75,25.125,1,0,1,'Color','r','MarkerSize',1,'LineWidth',1);hold on;% cm/s
% m_northarrow(121,25,40,'type',4,'linewi',.5);
% vecscl=1/52.8;
% % vecscl=1;
% m_vec(vecscl,121.75,25.125,0.01,0,'r','shaftwidth',1,...
%       'key',{'10 mm/s','ADCP'},'centered','yes');hold on;

axis('image') %�T�w�Ϯת��Y��(�b�Y������ɤ��|�ܧ�)
% axis equal;
xlabel('Longitude (^{\circ}E)',"FontSize",12,"FontName",'times')
ylabel('Latitude (^{\circ}N)',"FontSize",12,"FontName",'times')
title({'W14_';'2370track'},"FontSize",12,'Interpreter','none')

% get(gca,'position') % �� ���� �e�� ����
% axes('position',[0.27 0.15 0.2 0.07]);
% hold on
% quiver(1,0,1,0,1,'MarkerSize',1,'LineWidth',1);
% % text('');
% set(gca,'yAxisLocation','right','xAxisLocation','top');
% set(gca,'xticklabels',{},'yticklabels',{});
% % axis([0 5 -1 1]);
hold off;

print('W14_final_02_ctd','-dpng')
%% Read CTD data and skip heading lines (for loop method)
% name 0 = timeS: Time, Elapsed [seconds]
% name 1 = longitude: Longitude [deg]
% name 2 = latitude: Latitude [deg]
% name 3 = prDM: Pressure, Digiquartz [db]
% name 4 = depSM: Depth [salt water, m]
% name 5 = t090C: Temperature [ITS-90, deg C]
% name 6 = sal00: Salinity, Practical [PSU]
% name 7 = timeJ: Julian Days
% name 8 = flag:  0.000e+00
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding\cr2370\ctd\cr2370')
%% CTD�Ѽ�
ctd_data = dir('c*-1.txt');
% ds = datastore(CTD);
for i = 1:4
    filename2 = ctd_data(i).name;
    fid2 = fopen(filename2,'r')
    while strcmp(fgetl(fid2),'*END*') == 0
    %�@��@��Ū����ơA����Ū����'*END*'�r�ꬰ��
        isEND2 = feof(fid2); %�����ɮ׬O�_�wŪ���쥽��(�O�^��1�A�_�^��0)
    end
    ctd_row = fscanf(fid2,'%f'); %����e�������Ū�����_�I�A�~�򩹤UŪ���ɮ�fid�̪����
                            %�åB�o��@�Ӧ�V�q
    ctd{i} = reshape(ctd_row,9,length(ctd_row)/9)';
    fclose(fid2);
    eval(['ylat_c' num2str(i) '= ctd{i}(:,3);']);
    eval(['xlon_c' num2str(i) '= ctd{i}(:,2);']);
    eval(['p_c' num2str(i) '= ctd{i}(:,4);']);
    eval(['t_c' num2str(i) '= ctd{i}(:,6);']);
    eval(['s_c' num2str(i) '= ctd{i}(:,7);']);
    % id = Data{:,10}; % STATION_NUMBER

end
%%
cd('C:\Users\user\Google ���ݵw��\�v�y�[�����R_1082\coding')
%% Confirm the locations of CTD stations
figure(3)
m_proj('miller','lon',[LONGLIM1(1) LONGLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % ø�s����
for i = 1:4
    eval(['ctd_location_' num2str(i) '=m_plot(xlon_c' num2str(i) '(1),ylat_c' num2str(i) '(1),''.'');hold on;']);
end    
% ,'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_f('patch',[0.2 0.2 0.2],'edgecolor','k');    %ø�s���a
m_grid('linewi',1,'linestyle','none','tickdir','out',...
            'xtick',LONGLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
title('Location of CTD','Interpreter','none')
legend([ctd_location_1,ctd_location_2,ctd_location_3,ctd_location_4],...
    'c1','c2','c3','c4','Location','best');
print('W14_final_03_ctd','-dpng')
%% �NCTD���`�׸�Ƥ��ά���ơA�A�N�W���P�U�񪺷��Q�ƾڥ����p��
for i = 1:4
    for j = 1:fix(max(ctd{i}(:,4))+1)
    
        dp_index{j} = find(ctd{i}(:,4) > (j-1) & ctd{i}(:,4) < j); %�C�Ӵ������`�׸�Ư��ޭ�
        avg_T(j,i) = mean(ctd{i}(dp_index{j},6)); %�N�U�������ūפ@�C�@�C�x�s�b�x�}avg_T
        avg_S(j,i) = mean(ctd{i}(dp_index{j},7)); %�N�U�������Q�פ@�C�@�C�x�s�b�x�}avg_S
        avg_D(j,i) = mean(ctd{i}(dp_index{j},4)); %�N�U�������K�פ@�C�@�C�x�s�b�x�}avg_D
    end
    dep_ctd{i,1} = (1:fix(max(ctd{i}(:,4))+1))'; %�C�Ӵ������`�׸��
%     ylat_All = [ylat_c1(length(avg_D),1) ylat_c2(length(avg_D),1) ylat_c3(length(avg_D),1) ylat_c4(length(avg_D),1)];
%     subplot(2,2,1) %CTD�W�U�������(�ϥ� 1-1 ~ 8-1 )
%     [ax,h11,h12] = plotyy(dep{i,1},avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
%         dep{i,1},avg_S(i,1:fix(max(ctd{i}(:,1))+1)))
%     % ax = gca
%     set(gca,'View',[90 90]) % �վ���y�Ϫ���쨤�B����
%     set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
%     set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
%     xlabel('depth (m)');
% %     ax.XTickLabelRotation = 45
% %     ax.XTick = 1:1:max(ctd{i}(:,1))
%     subplot(2,2,2) % �W���P�U�񪺸��(�ϥ� s1-1 ~ s8-1 )
%     [ax2,h21,h22] = plotyy(ctd_s{i}(:,1),ctd_s{i}(:,4),ctd_s{i}(:,1),ctd_s{i}(:,5));
%     set(gca,'View',[90 90],'tickdir','out') % �վ�϶b����쨤�B����
%     set(get(ax2(1),'Ylabel'),'String','Temperature (^oC)');
%     set(get(ax2(2),'Ylabel'),'String','Salinity (psu)');
%     xlabel('depth (m)');
%     subplot(2,2,3) % �K�׵����u�B���Q��
%     S{i,1} = linspace(min(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
%     %�N�U�������Q�׸��avg_S(i,1:fix(max(ctd{i}(:,1))+1)))�ѳ̤p��̤j���ͤ@�Ӫ��׬�dep{i,1}(end)���M�}�C
%     T{i,1} = linspace(min(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
%     %�N�U�������ū׸��avg_T(i,1:fix(max(ctd{i}(:,1))+1)))�ѳ̤p��̤j���ͤ@�Ӫ��׬�dep{i,1}(end)���M�}�C
%     [SS{i,1},TT{i,1}] = meshgrid(S{i,1},T{i,1});
%     sigma{i,1} = den_CTD(SS{i,1},TT{i,1},1.01325+dep{i}*(1.01325*1/10))-1000; % �禡 den_CTD
%     [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %ø�s����K�׽u
%     clabel(c1,h1);hold on %��ܼƭ�
%     plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
%         'k','LineWidth',2);hold off
%     title(['T-S diagram (' num2str(i) '-1)']);
%     xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
% 
%     subplot(2,2,4)
%     m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % ø�s����(�զ�)
%     ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,...
%         'MarkerFaceColor','b')
%     m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a
% 
%     m_grid('linewi',2,'linestyle','none','tickdir','out',...
%             'xtick',LONLIM1,'ytick',LATLIM1,...
%             'XaxisLocation','bottom','YaxisLocation','left');
% 
%     title([num2str(i) '-1 Location']);
% 
% %     print(['D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% �Q��CTD����ư��X�šB�Q�B�K�׭孱��(C1�BC2�BC3�BC4 �����孱)
% �ϥ�contour
% Y �b : �`��(m)
% X �b : ������m(�������Z��)(m)
% �����u : �ūסB�Q�סB����K��
figure(4)
% t2dep = 1:101; % ø�ϲ`��
avg_D(avg_D==0)=nan; %��avg_T��0���ܬ�NAN��
avg_S(avg_S==0)=nan; %��avg_T��0���ܬ�NAN��
avg_T(avg_T==0)=nan; %��avg_T��0���ܬ�NAN��
ylat_All = [ylat_c1(1:length(avg_D),1) ylat_c2(1:length(avg_D),1)...
    ylat_c3(1:length(avg_D),1) ylat_c4(1:length(avg_D),1)];
contourf(ylat_All,avg_D,avg_T,200,'linecolor','none'); %ø�s�ū׭孱
cb_T = colorbar;
% caxis([0 30]); 
hold on;
colormap jet
% [C,h] = contour(ylat_All,avg_D,avg_T,'linecolor','k'); 
% clabel(C,h); 
cb_T.Label.String = 'Temperature(^{\circ}C)';
% shading interp
set(gca,'ydir','reverse','tickdir','out'); % �վ�϶b����쨤�B����
axis([-inf inf 0 80]);

title('The section of temperature profiles');
xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
print('W14_final_04_ctd','-dpng')
%% �Q�׭孱
figure(5)
contourf(ylat_All,avg_D,avg_S,200,'linecolor','none'); %ø�s�Q�׭孱
cb_S = colorbar;
% caxis([0 30]); 
hold on;
colormap jet
% [C,h] = contour(ylat_All,avg_D,avg_S,'linecolor','k'); 
% clabel(C,h); 
% shading interp
cb_S.Label.String = 'Salinity(psu)';
set(gca,'ydir','reverse','tickdir','out'); % �վ�϶b����쨤�B����
axis([-inf inf 0 80]);

title('The section of salinity profiles');
xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
print('W14_final_05_ctd','-dpng')
%% �N STATION_NUMBER ���Ҧ���Ƥ���
% id_unique = unique(id); % station ID
%% Separate each profile into column data
% for m = 1:length(id_unique)
%     I = find(id == id_unique(m));
%     Pall(:,m) = p(I(1:800));
%     Tall(:,m) = t(I(1:800));
%     Sall(:,m) = s(I(1:800));
%     Yall_JGQH(:,m) = ylat_JGQH(I(1:800));
% end
%% Plot contour fill for the section of temperature profiles
% figure(3)
% % max(t)
% % min(t)
% contourf(Yall_JGQH,Pall,Tall,[2:0.5:30],'linecolor','none')
% colorbar;
% caxis([0 30]); 
% hold on;
% colormap jet
% [C,h] = contour(Yall_JGQH,Pall,Tall,[2:0.5:30],'linecolor','k'); 
% clabel(C,h); 
% set(gca,'ydir','reverse');
% hold off;
% 
% title('The section of temperature profiles');
% xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
% print('W14_class03_ctd','-dpng')
%% Calculate Temperature Vertical Gradient (dT/dz)
% figure(4)
% dTdz = diff(Tall,1,1)./diff(Pall,1,1);
% contourf(Yall_JGQH(1:end-1,:),Pall(1:end-1,:),-dTdz,[-0.1:0.05:0.3],'linecolor','none');
% colorbar;
% caxis([-0.1 0.3]);
% set(gca,'ydir','reverse');
% title('Temperature Vertical Gradient (dT/dz)');
% xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
% print('W14_class04_ctd','-dpng')
%% Plot contour fill for the section of salinity profiles
% figure(5)
% % max(s)
% % min(s)
% contourf(Yall_JGQH,Pall,Sall,[34:0.05:35],'linecolor','none')
% colorbar;
% caxis([34 35]);
% hold on;
% colormap jet
% [C,h] = contour(Yall_JGQH,Pall,Sall,[34:0.05:35],'linecolor','k'); 
% clabel(C,h); 
% set(gca,'ydir','reverse');
% hold off;
% 
% title('The section of salinity profiles');
% xlabel('Latitude(^{\circ}N)');ylabel('Depth(m)');
% print('W14_class05_ctd','-dpng')


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
% q = m_quiver(avg_lon_cr2370(:,:),avg_lat_cr2370(:,:),...
%     u_cr2370(:),v_cr2370(:),1,'Color',[0 0.4470 0.7410],'MarkerSize',1,'LineWidth',1);hold on; % mm/s

q = m_quiver([avg_lon_cr2370(:,:);121.83],[avg_lat_cr2370(:,:);25.23],...
    [u_cr2370(:);-500],[v_cr2370(:);0],1,'Color',[0 0.4470 0.7410],'MarkerSize',1,'LineWidth',1);hold on; % mm/s

% q2 = m_quiver(121.75,25.125,1,0,1,'Color','r','MarkerSize',1,'LineWidth',1);hold on;% cm/s
% m_northarrow(121,25,40,'type',4,'linewi',.5);
vecscl=1/52.8;
% vecscl=1;
m_vec(vecscl,121.75,25.125,0.01,0,'r','shaftwidth',1,...
      'key',{'10 mm/s','ADCP'},'centered','yes');hold on;

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
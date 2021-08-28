%% test
clear;clc;
% clf;
%%
figure(11)
%%
% Argo stuff
% Go to:
%         http://www.usgodae.org/cgi-bin/argo_select.pl
% Select area you want and date range, download all profiles
% tar -xvzf them into directory...
basname='./argo';

% base map
m_proj('lambert','lons',[-150 -124],'lat',[40 60],'grid','on');
[cs,h]=m_etopo2('contourf',[-7000:500:0],'edgecolor','none');
m_gshhs_l('patch',[.5 .8 0],'edgecolor','none');
% m_grid('linewi',2,'layer','top');
caxis([-7000 000]);
m_contfbar(.92,[.2 .5],cs,h,'endpiece','no','axfrac',.02);
colormap(m_colmap('blue'));   
title('Argo float trajectories NE Pacific (2017)');

% Add ARGO float trajectories
%  1) draw a scale arrow
vecscl=0.015;
m_vec(vecscl ,-126,58,-0.01,0,'r','headlength',10);
% m_vec(vecscl ,-126,58,-0.01,0,'r','shaftwidth',2,'headlength',10,...
%       'key',{'1 cm/s','Mean Drift'},'centered','yes');
%  
% dirs=dir(basname);
% m=0;
% for k=3:length(dirs)
%    profname=dir([dirs(k).folder '/' dirs(k).name]);
%    for l=3:length(profname)
%        fname=[profname(l).folder '/' profname(l).name '/' profname(l).name '_Rtraj.nc'];
%        %ncdisp(fname);
%        
%        argo.id=ncread(fname,'PLATFORM_NUMBER');
%        argo.mtime=ncread(fname,'JULD')+datenum(1950,1,1);
%        argo.lat=ncread(fname,'LATITUDE');
%        argo.lon=ncread(fname,'LONGITUDE');
%         
%        % Long are stored between -180 and +180; this removes artificial
%        % jumps which might happen just left of the map limits.
%        argo.lon(argo.lon>0)=argo.lon(argo.lon>0)-360;
%        
%         
%        ii=find(isfinite(argo.lon));
%        if any(ii )
%           m_line(argo.lon(ii),argo.lat(ii),'color',[0 0 0]);
%           
%           % Sometimes first point is an error of some sort so skip it
%           Dlon=argo.lon(ii([2 end]));
%           Dlat=argo.lat(ii([2 end]));
%           t=diff(argo.mtime(ii([2 end]))); % time between the points
%          
%           % Distance between the points
%           [d,a12]=m_idist(Dlon(1),Dlat(1),Dlon(2),Dlat(2));
%           
%           % Store stuff
%           m=m+1;
%           spd(m)=d/(t*86400) ;% m/s 
%                    
%           % Find midpoint on geodesic and store as well
%           [Clon(m),Clat(m),a21(m)]=m_fdist(Dlon(1),Dlat(1),a12,d/2);
%         end
%    end
%           
% end
% Clon=rem(Clon-360,360); % Get it into the right range
% a21=rem(a21-180,360);   % I need the opposite direction
% 
% % Draw all the 'mean speed' arrows, centered at the midpoint of the
% % geodesic between first and last points.
% m_vec(vecscl ,Clon,Clat,spd.*sind(a21),spd.*cosd(a21),'r',...
%            'centered','yes','shaftwidth',2,'headlength',10);
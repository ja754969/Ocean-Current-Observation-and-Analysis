******************************************************************
		    ---	     DataSelection Export Read-me file               ---
******************************************************************
You have opened your data export file from one of our dataSelection applications.
This file's name is DataSelection_yyyymmdd_hhmiss.tgz.

Please find below the explanation of what you will find in each file of the archive.

When you ask for an ascii csv export, your files will be in a .csv format, when you ask for an
NetCDF argo export, your files will be in a .nc format.

If you asked for an export from the Gosud DataSelection application, you will 
find one unique file named gosud_trajectory_yyyymmdd_hhmiss.nc/.csv. This file contains
all the data from your selection.

If you asked for an export from another DataSelection application, you will find different 
files corresponding to each data following a classification described below.

Remark on Argo floats data : these data are NOT the original Argo data.
They are the Argo floats data collected in Coriolis database.
Additional Coriolis quality control is applied to Argo floats data (objective analysis).
The original Argo data are available at :
http://www.argodatamgt.org/Access-to-data
 
Here are the different files you can find:
- argo-profiles.csv /.nc
- xbt-profiles.csv / .nc
- ctd-profiles.csv / .nc
- glider-profiles.csv / .nc 
- animal-profiles.csv / .nc
- other-profiles.csv / .nc
- argo-trajectory.csv / .nc
- drifting-buoys.csv / .nc
- tsg.csv / .nc
- mooring-buoys-time-series.csv / .nc
- bottles.csv / .nc
- other-time-series-or-trajectories.csv / .nc

The classification is used to group stations and time-series in different observation categories.

Vertical profiles:
- Argo profile
Float type platform stations  
platform_type.platform_type = 45 and station.format_code égal PF
- XBT profile
Non CTD vessel stations
platform_type.platform_type in (30,…,39) and station.format_code different from CT or OC
- CTD profile
CT or OC type stations
platform_type.platform_type in  (30,…,39) and station.format_code equal to CT or OC
- Glider profiles
platform_type.platform_type = 4A
- Animal profiles
platform_type.platform_type = 4B
- Other profiles
stations type different from above

Time series
- Argo trajectory
Location.instrument_family = PF
- Drifting buoy
Location.instrument_family = DB
- TSG
Location.instrument_family = TS
- Mooring buoys time series
Location.instrument_family = MO
- Bottles
Location.instrument_family = BO
- Other time-series or trajectories
Location.instrument_family different from above


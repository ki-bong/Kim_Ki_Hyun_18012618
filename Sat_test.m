clc
close all

%% GPS
load('GPS_geodetic');

figure(1);
geoscatter(GPS_r_Geodetic(:,1),GPS_r_Geodetic(:,2));
title('GPS Groundtrack')

Radar_p  = [37 127 1000];
GPS_r_ENU = lla2enu(GPS_r_Geodetic,Radar_p,'ellipsoid');
elmask = 10;

GPS_el =  elevation(GPS_r_ENU,elmask);
GPS_az =  azimuth(GPS_r_ENU);

figure(2);
skyplot(GPS_az,GPS_el);
title('GPS Skyplot')
%% BDS
load('BDS_geodetic');

figure(3);
geoscatter(BDS_r_Geodetic(:,1),BDS_r_Geodetic(:,2));
title('BDS Groundtrack')

Radar_p  = [37 127 1000];
BDS_r_ENU = lla2enu(BDS_r_Geodetic,Radar_p,'ellipsoid');
elmask = 10;

BDS_el =  elevation(BDS_r_ENU,elmask);
BDS_az =  azimuth(BDS_r_ENU);

figure(4);
skyplot(BDS_az,BDS_el);
title('BDS Skyplot')
%% QZSS
load('QZSS_geodetic');

figure(5);
geoscatter(QZSS_r_Geodetic(:,1),QZSS_r_Geodetic(:,2));
title('QZSS Groundtrack')

Radar_p  = [37 127 1000];
QZSS_r_ENU = lla2enu(QZSS_r_Geodetic,Radar_p,'ellipsoid');
elmask = 10;

QZSS_el =  elevation(QZSS_r_ENU,elmask);
QZSS_az =  azimuth(QZSS_r_ENU);

figure(6);
skyplot(QZSS_az,QZSS_el);
title('QZSS Skyplot')
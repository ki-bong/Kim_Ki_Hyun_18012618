clc
close all
clear all

load('nav');


GPS_a = (nav.GPS.a) / 10^3;                                          %% semi-major axis(km)
GPS_e = nav.GPS.e;                                                   %% eccentricity
GPS_p = GPS_a * (1- GPS_e^2);                                        %% p
GPS_i = rad2deg(nav.GPS.i);                                          %% t_oc, inclination(deg)
GPS_arg = rad2deg(nav.GPS.omega);                                    %% t_oc, argument of perigee(deg)
GPS_RAAN = rad2deg(nav.GPS.OMEGA);                                   %% t_oc, RAAN(deg)

GPS_M0 = nav.GPS.M0;                                                 %% t_oc, Mean anomaly(rad)

GPS_t0 = datetime(nav.GPS.toc);
flighttime = datetime([2023 4 30 0 0 0]);                            %% 86400 1일 기준 (24*60*60)

GPS_true_v1 = orbitp2anomaly(GPS_a,GPS_e,GPS_M0,GPS_t0,flighttime);

flightime = flighttime - GPS_t0;
flightime.Format = 's';
t = seconds(flightime);

for i = 1:1:t
    
    GPS_r_PQW(:,i) = solveRangeInPerifocalFrame(GPS_a,GPS_e,rad2deg(GPS_true_v1(i,1)));
    time(i,:) = nav.GPS.toc + [0 0 0 0 0 i];
    time_dt = datetime(time,'TimeZone','UTC');
    
end

[y M d] = ymd(time_dt);
[h m s] = hms(time_dt);
    
time_utc = [y M d h m s];

GPS_r_ECI = PQW2ECI(GPS_arg,GPS_i,GPS_RAAN) * GPS_r_PQW;

for i = 1:1:t

ECEF_R(3*i-2:3*i,1:3) = ECI2ECEF_DCM(time_utc(i,:));
GPS_r_ECEF(:,i) = ECEF_R(3*i-2:3*i,1:3) * GPS_r_ECI(:,i);

end

GPS_r_Geodetic = ecef2lla((GPS_r_ECEF)' .* 10^3,'WGS84');

figure(1);
geoscatter(GPS_r_Geodetic(:,1),GPS_r_Geodetic(:,2));

Radar_p  = [37 127 1000];
GPS_r_ENU = lla2enu(GPS_r_Geodetic,Radar_p,'ellipsoid');
elmask = 10;

GPS_el =  elevation(GPS_r_ENU,elmask);
GPS_az =  azimuth(GPS_r_ENU);

figure(2);
skyplot(GPS_az,GPS_el);
clc
close all
clear all

load('nav');


QZSS_a = (nav.QZSS.a) / 10^3;                                          %% semi-major axis(km)
QZSS_e = nav.QZSS.e;                                                   %% eccentricity
QZSS_p = QZSS_a * (1- QZSS_e^2);                                        %% p
QZSS_i = rad2deg(nav.QZSS.i);                                          %% t_oc, inclination(deg)
QZSS_arg = rad2deg(nav.QZSS.omega);                                    %% t_oc, argument of perigee(deg)
QZSS_RAAN = rad2deg(nav.QZSS.OMEGA);                                   %% t_oc, RAAN(deg)

QZSS_M0 = nav.QZSS.M0;                                                 %% t_oc, Mean anomaly(rad)

QZSS_t0 = datetime(nav.QZSS.toc);
flighttime = datetime([2023 5 10 2 0 0]);                            %% 86400 1일 기준 (24*60*60)

QZSS_true_v1 = orbitp2anomaly(QZSS_a,QZSS_e,QZSS_M0,QZSS_t0,flighttime);

flightime = flighttime - QZSS_t0;
flightime.Format = 's';
t = seconds(flightime);

for i = 1:1:t
    
    QZSS_r_PQW(:,i) = solveRangeInPerifocalFrame(QZSS_a,QZSS_e,rad2deg(QZSS_true_v1(i,1)));
    time(i,:) = nav.QZSS.toc + [0 0 0 0 0 i];
    time_dt = datetime(time,'TimeZone','UTC');
    
end

[y M d] = ymd(time_dt);
[h m s] = hms(time_dt);
    
time_utc = [y M d h m s];

QZSS_r_ECI = PQW2ECI(QZSS_arg,QZSS_i,QZSS_RAAN) * QZSS_r_PQW;

for i = 1:1:t

ECEF_R(3*i-2:3*i,1:3) = ECI2ECEF_DCM(time_utc(i,:));
QZSS_r_ECEF(:,i) = ECEF_R(3*i-2:3*i,1:3) * QZSS_r_ECI(:,i);

end

QZSS_r_Geodetic = ecef2lla((QZSS_r_ECEF)' .* 10^3,'WGS84');

geoscatter(QZSS_r_Geodetic(:,1),QZSS_r_Geodetic(:,2));
figure(1);

Radar_p  = [37 127 1000];
QZSS_r_ENU = lla2enu(QZSS_r_Geodetic,Radar_p,'ellipsoid');
elmask = 10;

QZSS_el =  elevation(QZSS_r_ENU,elmask);
QZSS_az =  azimuth(QZSS_r_ENU);

figure(2);
skyplot(QZSS_az,QZSS_el);
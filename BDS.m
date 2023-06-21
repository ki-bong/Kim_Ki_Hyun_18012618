clc
close all
clear all

load('nav');


BDS_a = (nav.BDS.a) / 10^3;                                          %% semi-major axis(km)
BDS_e = nav.BDS.e;                                                   %% eccentricity
BDS_p = BDS_a * (1- BDS_e^2);                                        %% p
BDS_i = rad2deg(nav.BDS.i);                                          %% t_oc, inclination(deg)
BDS_arg = rad2deg(nav.BDS.omega);                                    %% t_oc, argument of perigee(deg)
BDS_RAAN = rad2deg(nav.BDS.OMEGA);                                   %% t_oc, RAAN(deg)

BDS_M0 = nav.BDS.M0;                                                 %% t_oc, Mean anomaly(rad)

BDS_t0 = datetime(nav.BDS.toc);
flighttime = datetime([2023 2 27 0 0 0]);                            %% 86400 1일 기준 (24*60*60)

BDS_true_v1 = orbitp2anomaly(BDS_a,BDS_e,BDS_M0,BDS_t0,flighttime);

flightime = flighttime - BDS_t0;
flightime.Format = 's';
t = seconds(flightime);

for i = 1:1:t
    
    BDS_r_PQW(:,i) = solveRangeInPerifocalFrame(BDS_a,BDS_e,rad2deg(BDS_true_v1(i,1)));
    time(i,:) = nav.BDS.toc + [0 0 0 0 0 i];
    time_dt = datetime(time,'TimeZone','UTC');
    
end

[y M d] = ymd(time_dt);
[h m s] = hms(time_dt);
    
time_utc = [y M d h m s];

BDS_r_ECI = PQW2ECI(BDS_arg,BDS_i,BDS_RAAN) * BDS_r_PQW;

for i = 1:1:t

ECEF_R(3*i-2:3*i,1:3) = ECI2ECEF_DCM(time_utc(i,:));
BDS_r_ECEF(:,i) = ECEF_R(3*i-2:3*i,1:3) * BDS_r_ECI(:,i);

end

BDS_r_Geodetic = ecef2lla((BDS_r_ECEF)' .* 10^3,'WGS84');

figure(1);
geoscatter(BDS_r_Geodetic(:,1),BDS_r_Geodetic(:,2))


Radar_p  = [37 127 1000];
BDS_r_ENU = lla2enu(BDS_r_Geodetic,Radar_p,'ellipsoid');
elmask = 10;

BDS_el =  elevation(BDS_r_ENU,elmask);
BDS_az =  azimuth(BDS_r_ENU);

figure(2);
skyplot(BDS_az,BDS_el);
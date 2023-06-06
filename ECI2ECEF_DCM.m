%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Week#13 Homework
%% 우주궤도역학(001)
%% 18012618 김기현
%% Coordinate Transform Functions(ECI to ECEF)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [DCM] = ECI2ECEF_DCM(time)

jd = juliandate(time);

theta_g = siderealTime(jd);

DCM = [cos(deg2rad(theta_g)) sin(deg2rad(theta_g)) 0;
      -sin(deg2rad(theta_g)) cos(deg2rad(theta_g)) 0;
      0 0 1];
end
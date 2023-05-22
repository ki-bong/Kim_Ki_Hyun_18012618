%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Week#11 Homework
%% 우주궤도역학(001)
%% 18012618 김기현
%% Perifocal frame to ECI frame(rotation function)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Rmatrix] = PQW2ECI(arg_prg,inc_angle,RAAN)

R_arg_3 = [cos(deg2rad(arg_prg)), sin(deg2rad(arg_prg)), 0;
          -sin(deg2rad(arg_prg)), cos(deg2rad(arg_prg)), 0;
           0, 0, 1];                                                      %% W

R_inc_1 = [1, 0, 0;
           0, cos(deg2rad(inc_angle)), sin(deg2rad(inc_angle));
           0, -sin(deg2rad(inc_angle)), cos(deg2rad(inc_angle))];         %% I
       
R_RAAN_3 = [cos(deg2rad(RAAN)), sin(deg2rad(RAAN)), 0;
           -sin(deg2rad(RAAN)), cos(deg2rad(RAAN)), 0;
           0, 0, 1];                                                      %% OMEGA

Rmatrix = (R_arg_3 * R_inc_1 * R_RAAN_3)';
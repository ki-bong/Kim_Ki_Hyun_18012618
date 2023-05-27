%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Week#12 Homework
%% 우주궤도역학(001)
%% 18012618 김기현
%% slove velocity In Perifocal Frame(function)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [velocityInPQW] = solveVelocityInPerifocalFrame(semimajor_axis,eccentricity,true_anomaly)

p = semimajor_axis * (1 - eccentricity^2);

mu = 3.986004418 * 10e5;

velocityInPQW = sqrt(mu / p) * [-sin(deg2rad(true_anomaly)), eccentricity + cos(deg2rad(true_anomaly)), 0]';
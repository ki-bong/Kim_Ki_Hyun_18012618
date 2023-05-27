%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Week#12 Homework
%% 우주궤도역학(001)
%% 18012618 김기현
%% slove Range In Perifocal Frame(function)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [rangeInPQW] = solveRangeInPerifocalFrame(semimajor_axis,eccentricity,true_anomaly)

p = semimajor_axis * (1 - eccentricity^2);

r = p / (1 + eccentricity * cos(deg2rad(true_anomaly)));

rangeInPQW = [r * cos(deg2rad(true_anomaly)), r * sin(deg2rad(true_anomaly)), 0]';
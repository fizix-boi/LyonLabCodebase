%{
Code used for running experiments related to resistive thermometry

Experiments slated to be performed in the big glass dewar

Matt Schulz
%}

addpath(genpath(strcat(pwd, '\Instrument_Utilities')));
addpath(genpath(strcat(pwd, '\MeasurementUtilities')));
addpath(genpath(strcat(pwd, '\PlotUtilities')));
addpath(genpath(strcat(pwd, '\resThermoHelpers')));
warning('off','all');

port = 1234;

SR830_Address = '172.29.117.103';
SR830 = SR830(port, SR830_Address);

%DMM_Address = '172.29.117.104';
%DMM = TCPIP_Connect(DMM_Address, port);

%AWG_Address = '172.29.117.108';
%AWG = TCPIP_Connect(AWG_Address, port);

%fclose(SR830);
%fclose(DMM);
%fclose(AWG);
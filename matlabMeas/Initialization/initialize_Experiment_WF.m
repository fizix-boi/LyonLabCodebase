%% Script used to initialize an experiment.

port = 1234;

% SR830
SR830_Address = '172.29.117.103';
SR830 = SR830(port,SR830_Address);

% DAC
sigDACPort = 'COM4';
DAC = sigDAC(sigDACPort,16);
% this GUI only shows the voltage after being updated
DACGUI = sigDACGUI;

% SIM900
% connect to SIM900 via RS232
comPort = 'COM5';
SIM900 = SIM900(comPort);
% simply call functions in SIM900, e.g. querySIM900Voltage(SIM900,7)
% rampSIM900Voltage(SIM900,port,voltage, pauser, delta)

% If needed run setupENA in folder as well.
% connect ethernet cable behind to VNA





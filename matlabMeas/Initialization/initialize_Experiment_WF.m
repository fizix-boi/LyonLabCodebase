%% Script used to initialize an experiment.

port = 1234;

% SR830
SR830_Address = '172.29.117.103';
SR830 = SR830(port,SR830_Address);
% sweep1DMeasSR830Fast({'SM'},
% first argument only changes the axis names


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

% SDG5122
% connect to SDG5122 via USB-B
SDGPort = 'COM';
SDG5122 = SDG5122(SDGPort);

% If needed run setupENA in folder as well.
% connect ethernet cable behind to VNA





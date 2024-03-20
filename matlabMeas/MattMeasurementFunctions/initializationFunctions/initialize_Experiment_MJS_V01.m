%% Script used to initialize an experiment.

port = 1234;
% 
SR830_Address = '172.29.117.102';
SR830 = SR830(port,SR830_Address);

DMM_Address = '172.29.117.104';
Thermometer = TCPIP_Connect(DMM_Address,port);

sigDACPort = 'COM4';
DAC = sigDAC(sigDACPort,16,'DAC');
DACGUI = sigDACGUI;

USBAddress = 'USB0::0xF4ED::0xEE3A::SDG050D1150018::INSTR';
SDG5122 = SDG5122(USBAddress);

powPort = 5025;
pow_Address = '172.29.117.132';

dcps = SPD330(pow_Address,powPort);

% 
% AWG_Address = '172.29.117.105';
% AWG = Agilent33220A(port,AWG_Address);
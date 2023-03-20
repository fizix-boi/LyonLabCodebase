tStart = tic;
wait = 15;

sweepType = {'ST'};
timeBetweenPoints = 0.5;
repeat = 5;
readSR830 = {VmeasC,VmeasE};
device = DAC;
ports = {StmCPort,StmEPort};
doBackAndForth = 1;


% Transfer Electrons Configuration
DCConfigDAC_ST(DAC,'Transferring',10000);
pause(wait);
DCConfigDAC_ST(DAC,'Transfer',10000);
pause(wait);

% % Sweep Metal Negative
% SweepTopMetal(DAC,VmeasE,VmeasC,'TE',TimeInd);

% STM scan, pinch off
%% BEFORE TAUE     
start = sigDACQueryVoltage(DAC,16);
deltaParam = -0.05;
stop = -0.5;
Tiff_sweep1DMeasSR830(sweepType,start,stop,deltaParam,timeBetweenPoints,repeat,readSR830,device,ports,doBackAndForth);

% open door
doorAWG(VpulsSig,VpulsAgi,1,5,0,'ms')
pause(5)
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors
pause(1)
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors

% STM scan, pinch off
%% AFTER TAUE
deltaParam = -0.025;
stop = -0.4;
Tiff_sweep1DMeasSR830(sweepType,start,stop,deltaParam,timeBetweenPoints,repeat,readSR830,device,ports,doBackAndForth);

% Transferring Back electrons to emitter
DCConfigDAC_ST(DAC,'TransferringBack',10000);
pause(wait)
DCConfigDAC_ST(DAC,'TransferBack',10000);
pause(wait)

doorAWG(VpulsSig,VpulsAgi,5,1,0,'ms')
pause(5)
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors
pause(1)
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors
pause(1)
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors

sigDACRampVoltage(DAC,18,-1.7,10000);
pause(wait)

% open door to transfer back electrons to emitter 
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors
pause(1)
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors
pause(1)
fprintf(VpulsAgi, 'TRIG:SOUR BUS; *TRG');  % to open the doors

% STM scan, pinch off
%% AfterTransferBack
deltaParam = -0.05;
stop = -0.5;
Tiff_sweep1DMeasSR830(sweepType,start,stop,deltaParam,timeBetweenPoints,repeat,readSR830,device,ports,doBackAndForth);

% Transferring electrons
DCConfigDAC_ST(DAC,'Transferring',10000);
pause(wait);
DCConfigDAC_ST(DAC,'Transfer',10000);
pause(wait);

% final STM scan, pinch off
%% AfterTransferring
deltaParam = -0.025;
stop = -0.4;
Tiff_sweep1DMeasSR830(sweepType,start,stop,deltaParam,timeBetweenPoints,repeat,readSR830,device,ports,doBackAndForth);

tEnd = toc(tStart);
fprintf('%d minutes and %f seconds\n', floor(tEnd/60), rem(tEnd,60));

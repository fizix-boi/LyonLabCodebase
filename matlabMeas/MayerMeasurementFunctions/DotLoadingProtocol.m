BackingPlateVoltage = -5;
DPVoltage = 0;
TMDelta = 5;
%DPBias = 1;
numVoltages = 10;
waitTime = 0.03;

setVal(TopMetalDevice,TopMetalPort,BackingPlateVoltage);
rampVal(TopMetalDevice,TopMetalPort,getVal(TopMetalDevice,TopMetalPort),BackingPlateVoltage,-0.1,waitTime);
sweepGatePairs(Door100Device,Res100Device,Door100Port,Res100Port,BackingPlateVoltage+TMDelta,BackingPlateVoltage+TMDelta,numVoltages,waitTime);
sweepGatePairs(Bias100Device,STM100Device,Bias100Port,STM100Port,BackingPlateVoltage+TMDelta,BackingPlateVoltage+TMDelta,numVoltages,waitTime);

sweepGatePairs(Top100Device,Dot100Device,Top100Port,Dot100Port,BackingPlateVoltage + TMDelta,BackingPlateVoltage + TMDelta,numVoltages,waitTime);
DACGUI.updateDACGUI;
SR830GUI.updateSR830App;
drawnow;
%rampVal(Dot100Device,Dot100Port,DPVoltage,1,.1);

input('\nFlash\n')

%disp('Flashing Filament');
%AWG.send33220Trigger();
pause(1);

%
% sweepGate(Dot100Device,Dot100Port,BackingPlateVoltage+TMDelta,BackingPlateVoltage+TMDelta+DPBias,.01,.03);
%pause(10);
sweepGatePairs(Top100Device,Dot100Device,Top100Port,Dot100Port,1,1+DPBias,50,.03);
sweepGatePairs(Door100Device,Res100Device,Door100Port,Res100Port,BackingPlateVoltage+1,BackingPlateVoltage,numVoltages,waitTime);

sweepGatePairs(Bias100Device,STM100Device,Bias100Port,STM100Port,0,0,numVoltages,waitTime);
DACGUI.updateDACGUI;
drawnow;

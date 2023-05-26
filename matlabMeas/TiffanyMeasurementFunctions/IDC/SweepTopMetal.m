function [] = SweepTopMetal(DAC,VmeasE,VmeasC,scanType)
%% This function is meant for sweeping top metal voltage

if scanType == 'TC'
    sweepType = {'TC'};
    
    start = sigDACQueryVoltage(DAC,18);
    deltaParam = 0.1;
    stop = -3;

    timeBetweenPoints = 0.05;
    repeat = 5;
    readSR830 = {VmeasC};
    device = DAC;
    ports = {18};
    doBackAndForth = 1;
    
elseif scanType == 'TE'
    sweepType = {'TE'};
    
    % start = sigDACQueryVoltage(DAC,14);
    start = -1;
    deltaParam = -0.1;
    stop = -2;
    
    timeBetweenPoints = 0.01;
    repeat = 5;
    readSR830 = {VmeasE};
    device = DAC;
    ports = {14};
    doBackAndForth = 1;
end

sweep1DMeasSR830(sweepType,start,stop,deltaParam,timeBetweenPoints,repeat,readSR830,device,ports,doBackAndForth);

end


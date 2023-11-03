% Set freq range
E5071SetStartFreq(ENA,1000); % in MHz
E5071SetStopFreq(ENA,4000); % in MHz

% Set single sweep
fprintf(ENA,':INIT1'); % Set trigger value - for continuous set: ':INIT:CONT ON'
fprintf(ENA,':TRIG:SOUR BUS'); % Set trigger source to "Bus Trigger"
fprintf(ENA,':TRIG:SING'); % Trigger ENA to start sweep cycle
query(ENA,'*OPC?') % Execute *OPC? command and wait until command return 1

% Get mag (log) and phase (deg) data
tag = 'freqSweep';
[fdata,mag,phase] = E5071GetData(ENA,tag);

% Plot data
subPlotFigure = figure(getNextMATLABFigNum());
subplot(1,2,1);
freqvsmag = plotData(fdata,mag,'xLabel',"Frequency (GHz)",'yLabel',"S_{21} (dB)",'color',"bo",'subPlot',1);

subplot(1,2,2)
freqvsphase = plotData(fdata,phase,'xLabel',"Frequency (GHz)",'yLabel',"\phi (^{\circ})",'color',"ro",'subPlot',1);

% plotHandles = {freqvsmag,freqvsphase};
saveData(subPlotFigure,tag); % Save mag and phase data
timeBetweenPoints = 10;

%% ENA parameters
powerIndBm = 5;   % in dBm
startFreq  = 2120; % in MHz
stopFreq   = 2140;  % in MHz
tag        = 'freqSweep';

%% Initialize Thermometer type (this is related to your thermometer you have)
thermometerType = 'X117656';
Thermometer;
Therm = initializeThermometry(thermometerType);
%% Initialize workspace arrays. Must be in workspace to update plots properly.
[time,frequency,temperature] = deal(inf);

%% Create plot for thermometry,IDCs,Emitter and set the data sources for the figure handle below.
subPlotFigure = figure(getNextMATLABFigNum());

freqResHandle = subplot(2,2,1);
freqResPlot = plotData(time,frequency,'xLabel',"Time (minutes)",'yLabel',"Frequency (GHz)",'color',"r-x");

thermHandle = subplot(2,2,2);
thermPlot = plotData(time,temperature,'xLabel',"Time (minutes)",'yLabel',"Temperature (K)",'color',"bx");

axesCell = {freqResHandle,thermHandle};
tempPlotCell = {thermPlot,freqResPlot};

ENACell = {powerIndBm,startFreq,stopFreq,tag};
plotResVsTime(tempPlotCell,subPlotFigure,ENA,timeBetweenPoints,Thermometer,Therm,axesCell,ENACell);

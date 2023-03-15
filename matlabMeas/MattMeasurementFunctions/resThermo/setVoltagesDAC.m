%% Function to bulk set voltages on the DAC

channels = [1, 2, 3, 4, 5, 6, 7, 8];
numSteps = 100;

voltsEmitt = [-4,...  %DAC 1
        -0.3,...   %DAC 2
        0,...   %DAC 3
        0,...   %DAC 4
        0,...   %DAC 5
        0,...   %DAC 6
        -0.75,...   %DAC 7
        0];     %DAC 8

voltsGnd = [0,...  %DAC 1
        0,...   %DAC 2
        0,...   %DAC 3
        0,...   %DAC 4
        0,...   %DAC 5
        0,...   %DAC 6
        0,...   %DAC 7
        0];     %DAC 8

%sigDACRampVoltage(DAC,channels,voltsEmitt,numSteps);

sigDACRampVoltage(DAC,channels,voltsGnd,numSteps);

%{
for i = 1:length(voltUse)
    setVal(DAC,i,voltUse(i));
end
%}
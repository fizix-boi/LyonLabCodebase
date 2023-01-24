function [avgmags] = sweep2DMeasSR830_Func(sweepTypes, starts, stops, deltaParams, devices, portss, timeBetweenPoints,repeat,readSR830)

%% Test command
% sweep2DMeasSR830_Func({'Freq', 'ST'}, {1000, 0}, {10000, 1}, {1000, 0.01}, {'SR830','SR830'}, {{'Freq'},{'Aux1'}})

plotHandle = initializeSR830Meas2D_Func(sweepTypes, starts, stops, deltaParams);

%% Read in Sweep types
% Each argument unpacked here needs braces to function correctly (i.e. sweepTypes = {'Freq', 'STM'})
[sweepType1, sweepType2] = sweepTypes{:};
[start1, start2] = starts{:};
[stop1, stop2] = stops{:};
[deltaParam1, deltaParam2] = deltaParams{:};
[device1, device2] = devices{:};
[ports1, ports2] = portss{:};


%% First set of parameters to probe
if start1 > stop1 && deltaParam1 > 0
    deltaParam1 = -1*deltaParam1;
elseif start1 < stop1 && deltaParam1 < 0
    deltaParam1 = -1*deltaParam1;
end

paramVector1 = start1:deltaParam1:stop1;

%flippedParam1 = fliplr(paramVector1);

if strcmp(sweepType1,'Pair')
    deltaGateParam1 = getVal(device1,ports1{2}) - getVal(device1,ports1{1});
end

%% Second set of parameters to probe
if start2 > stop2 && deltaParam2 > 0
    deltaParam2 = -1*deltaParam2;
elseif start2 < stop2 && deltaParam2 < 0
    deltaParam2 = -1*deltaParam2;
end

paramVector2 = start2:deltaParam2:stop2;

if strcmp(sweepType2,'Pair')
    deltaGateParam2 = getVal(device2,ports2{2}) - getVal(device,ports2{1});
end

%% Index for time axis.
currentAvgIndex = 1;

%% Define a cleanup function that will save data on user interrupt.
startTime = now();

%% Main parameter loop.
currentMainLoopIter = 1;

for valueIndex1 = 1:length(paramVector1) %loops through 1 first
    value1 = paramVector1(valueIndex1);

    for pIndex1 = 1:length(ports1)
        port1 = ports1{pIndex1};
        if pIndex1 == 1
            setVal(device1,port1,value1);
        else
            setVal(device1,port1,value1+deltaGateParam1);
        end
        
    end
    
    evalin("base","DACGUI.updateDACGUI");
    drawnow;
    pause(timeBetweenPoints);

    if mod(currentMainLoopIter, 2) == 1
        valueIndexVector2 = 1:length(paramVector2);
    else
        if mod(currentMainLoopIter, 2) == 0
            valueIndexVector2 = fliplr(1:length(paramVector2));
        end
    end

    for valueIndex2 = valueIndexVector2 %loops through 1 first
        value2 = paramVector2(valueIndex2);
        for pIndex2 = 1:length(ports2)
            port2 = ports2{pIndex2};
            if pIndex2 == 1
                setVal(device2,port2,value2);
            else
                setVal(device2,port2,value2+deltaGateParam2);
            end
            
        end
        
        evalin("base","DACGUI.updateDACGUI");
        drawnow;
        pause(timeBetweenPoints);
        %% Initialize average vectors that gets reset for the repeating for loop
        magVectorRepeat = [];
        %% Repeating for loop - changing repeat increases the number of averages to perform per point.
        for j = 1:repeat
            
            %% Query SR830 for Real/Imag data, calculate Magnitude and place in vectors
            Mag = getSR830MagData(readSR830);
            
            %% Place data in repeat vectors that get averaged
            magVectorRepeat(j)  = Mag;
        end

        plotHandle.CData((length(paramVector1) * (valueIndex1)) + valueIndex2) = mean(magVectorRepeat);
    end
end
saveData(gcf,genSR830PlotName([sweepType1, '_over_', sweepType2]))
end

function mag = getSR830MagData(readSR830)
    mag = sqrt(readSR830.SR830queryX()^2 + readSR830.SR830queryY()^2);
    pause(.001);
end
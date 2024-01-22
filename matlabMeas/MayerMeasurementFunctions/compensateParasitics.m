function [] = compensateParasitics(device, doorDevice,startPhase,stopPhase,phaseStepSize,startAmp,stopAmp,ampStepSize)

if phaseStepSize < .001
    disp('Minimum phase step size is 1e-3! Exiting compensation function!')
    return;
end

startPhaseStepExp = determineExponent(phaseStepSize);
phaseArr = logspace(startPhaseStepExp,-3,startPhaseStepExp+4);


startAmpStepExp = determineExponent(ampStepSize);
ampStepSizeArr = logspace(startAmpStepExp,-5,startAmpStepExp+6);

if length(ampStepSizeArr) < length(phaseArr)
    totalIterations = length(ampStepSizeArr);

else
    totalIterations = length(phaseArr);
end

for i = 1:totalIterations
    if i ~= 1
        phaseRange = phaseArr(i)*30;
        startPhase = optPhase - phaseRange/2;
        stopPhase = optPhase + phaseRange/2;

        ampRange = ampStepSizeArr(i)*30;
        startAmp = optAmp - ampRange/2;
        stopAmp = optAmp + ampRange/2;
    end
    %% Find best phase first
    optPhase = sweepOptimize(device, doorDevice, phaseArr(i), startPhase, stopPhase, 'Phase');
    doorDevice.set33220Phase(optPhase);

    delay(0.5);
    device.adjustSensitivity(device.SR830queryY(),1);
    
    optAmp = sweepOptimize(device, doorDevice, ampStepSizeArr(i), startAmp, stopAmp, 'Amp');
    doorDevice.set33220Amplitude(optAmp,'VRMS');
    
    delay(0.5);
    device.adjustSensitivity(device.SR830queryY(),1);
end

    function exponent = determineExponent(num)
        numStr = sprintf('%10e',num);
        splitArr = split(numStr,'e');
        exponent = splitArr(2);
        exponent = exponent{1};
        exponent = str2double(exponent);
    end
end
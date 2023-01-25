function [ZL,ZU] = getZCoefficients(thermometerType)
    if strcmp(thermometerType,'X117656')
            ZL = 2.68491328511;
            ZU = 3.88972245339;
    else
        disp('Your thermometer calibration does not exist!');
    end
end


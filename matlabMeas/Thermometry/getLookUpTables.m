function [tempTable,resTable] = getLookUpTables(thermometerType)
    if strcmp(thermometerType,'939801')
        tempTable = [300.195,290.175,280.179,270.174,260.159,250.166,240.169,230.160,220.146,210.148,200.150,190.143,180.139,170.135,160.130,150.126,140.123,130.112,120.118,110.112,100.109,95.1121,90.1171,85.1188,80.1236,75.1270,70.1272,65.1226,60.1235,55.1268,50.1328,48.1370,45.1399,42.1306,39.1341,36.1284,33.1218,31.0134,29.2049,27.5888,25.9700,24.3486,22.7294,21.1554,20.0916,19.1256,18.1637,17.2051,16.2403,15.2715,14.2960];
        resTable = [48.7227,50.1074,51.5820,53.1735,54.8948,56.7402,58.7451,60.9216,63.2924,65.8806,68.7078,71.8229,75.2529,79.0546,83.2882,88.0240,93.3492,99.4033,106.308,114.291,123.624,128.914,134.684,141.035,148.056,155.863,164.597,174.472,185.716,198.655,213.707,220.445,231.498,243.877,257.761,273.541,291.632,306.023,319.646,333.054,347.808,364.154,382.353,402.208,417.053,431.729,447.600,464.915,484.076,505.459,529.497];
    else
        disp('Your thermometer calibration does not exist!');
    end
end
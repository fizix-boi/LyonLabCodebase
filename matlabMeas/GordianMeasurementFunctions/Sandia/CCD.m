% Script for moving electrons from Sommer-Tanner to first diff. meas. region
DCPinout;
deltaVal = 0.25; % voltage step for ramp
waitTime = 0.001; % set wait time after each voltage step
Vopen = 2; % holding voltage of ccd
Vclose = -1; % closing voltage of ccd

ccd_units = 63; % number of repeating units in ccd array

for i = 1:ccd_units 
    rampVal(ccd2.Device,ccd2.Port,getVal(ccd2.Device,ccd2.Port),Vopen,deltaVal,waitTime); % open phi2
    rampVal(ccd1.Device,ccd1.Port,getVal(ccd1.Device,ccd1.Port),Vclose,deltaVal,waitTime); % close phi1
    rampVal(ccd3.Device,ccd3.Port,getVal(ccd3.Device,ccd3.Port),Vopen,deltaVal,waitTime); % open phi3
    rampVal(ccd2.Device,ccd2.Port,getVal(ccd2.Device,ccd2.Port),Vclose,deltaVal,waitTime); % close phi2
    rampVal(ccd1.Device,ccd1.Port,getVal(ccd1.Device,ccd1.Port),Vopen,deltaVal,waitTime); % open phi1
    rampVal(ccd3.Device,ccd3.Port,getVal(ccd3.Device,ccd3.Port),Vclose,deltaVal,waitTime); % close phi3
    fprintf(['CCD unit: ', num2str(i),'\n']);
end
fprintf(['Electrons moved ', num2str(ccd_units), ' ccd units.\n']);
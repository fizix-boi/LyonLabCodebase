%% HEMT voltages

% turn on HEMTs when cold
interleavedRamp([supplyDAC,supplyDAC,supplyDAC],[24,13,23],[1.94,1.9,0.6],5,0.1)
interleavedRamp([supplyDAC,supplyDAC,supplyDAC],[14,15,16],[2,2,0.5],5,0.1)

% turn on HEMTs at room temperature
interleavedRamp([supplyDAC,supplyDAC,supplyDAC],[24,13,23],[2,2.3,0.5],5,0.1)
interleavedRamp([supplyDAC,supplyDAC,supplyDAC],[14,15,16],[2,2.3,0.5],5,0.1)


% turn off HEMTS
interleavedRamp([supplyDAC,supplyDAC,supplyDAC],[24,13,23],[0,0,0],5,0.1)
interleavedRamp([supplyDAC,supplyDAC,supplyDAC],[14,15,16],[0,0,0],5,0.1)

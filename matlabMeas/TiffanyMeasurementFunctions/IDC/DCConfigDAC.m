function [ ] = DCConfigDAC( DAC, Command, numSteps )
%   ramps all the device ports to a voltage given a command

turnOnHelium = 0;
TopVoltage   = -0.5;
DCMap;

if strcmp(Command,'Emitting')

    %% Emitter    
    TopE       = TopVoltage;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = -1;
    DoorEOpen  = -1;
    %% Collector    
    STOBiasC   = -4;
    STIBiasC   = STOBiasC;
    TopC       = STOBiasC;
    StmC       = STOBiasC;
    DoorCClose = STOBiasC;
    DoorCOpen  = STOBiasC;
    %% Thin Film
    TfC        = -3;
    TfE        = -3;
    %% IDC
    IdcNF      = -3;
    IdcPF      = -3;

elseif strcmp(Command,'Transferring1')
    %% Emitter    
    TopE       = TopVoltage;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = -1;
    DoorEOpen  = 0.1;
    %% Collector   
    STOBiasC   = -4;
    STIBiasC   = STOBiasC;
    TopC       = STOBiasC;
    StmC       = STOBiasC;
    DoorCClose = STOBiasC;
    DoorCOpen  = STOBiasC;
    %% Thin Film
    TfC        = -4;
    TfE        = -4;
    %% IDC
    IdcNF      = -4;
    IdcPF      = -4;

elseif strcmp(Command,'Transferring2')
    %% Emitter    
    TopE       = TopVoltage;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = -1;
    DoorEOpen  = 0.1;
    %% Collector   
    STOBiasC   = 1.1;
    STIBiasC   = STOBiasC;
    TopC       = STOBiasC-0.7;
    StmC       = STOBiasC;
    DoorCClose = -0.05;
    DoorCOpen  = 0.7;
    %% Thin Film
    TfC        = -4;
    TfE        = -4;
    %% IDC
    IdcNF      = -4;
    IdcPF      = -4;

elseif strcmp(Command,'Transfer')
    %% Emitter    
    TopE       = TopVoltage;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = -1;
    DoorEOpen  = 0.2;
    %% Collector
    STMC = 1.1;
    STOBiasC   = STMC-0.017;
    STIBiasC   = STMC-0.025;
    TopC       = STOBiasC-0.5-0.02;
    StmC       = STMC;
    DoorCClose = 0.7-0.025;
    DoorCOpen  = 0.7; %TopC-0.2;
    %% Thin Film
    TfC        = 0.6;
    TfE        = 0.3;
    %% IDC
    IdcNF      = -0.1;
    IdcPF      = -0.1;

elseif strcmp(Command,'TransferringBack')
    %% Emitter    
    TopE       = TopVoltage;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = -3;
    DoorEOpen  = -0.1;
    %% Collector    
    STOBiasC   = 1.1;
    STIBiasC   = STOBiasC;
    TopC       = STOBiasC-0.5;
    StmC       = STOBiasC;
    DoorCClose = -3;
    DoorCOpen  = 0.7;
    %% Thin Film
    TfC        = -2;
    TfE        = -2;
    %% IDC
    IdcNF      = -2;
    IdcPF      = -2;

elseif strcmp(Command,'TransferBack1')
    %% Emitter    
    TopE       = TopVoltage;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = -1;
    DoorEOpen  = -0.1;
    %% Collector    
    STOBiasC   = -1.4;
    STIBiasC   = STOBiasC;
    TopC       = -1.9;
    StmC       = STOBiasC;
    DoorCClose = -4;
    DoorCOpen  = -0.7;
    %% Thin Film
    TfC        = -3;
    TfE        = -3;
    %% IDC
    IdcNF      = -3;
    IdcPF      = -3;

elseif strcmp(Command,'TransferBack2')
    %% Emitter    
    TopE       = -0.6;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = -0.3;
    DoorEOpen  = -0.3;
    %% Collector    
    STOBiasC   = -1.4;
    STIBiasC   = STOBiasC;
    TopC       = -1.9;
    StmC       = STOBiasC;
    DoorCClose = -2.5;
    DoorCOpen  = -0.7;
    %% Thin Film
    TfC        = -0.6;
    TfE        = -0.4;
    %% IDC
    IdcNF      = -1;
    IdcPF      = -1;

elseif strcmp(Command,'Transferv2')
    %% Emitter    
    TopE       = -1.9;
    StmE       = -1.4;
    STOBiasE   = -1.4;
    STIBiasE   = -1.4;
    DoorEClose = -2.5;
    DoorEOpen  = -1.1;
    %% Collector    
    STOBiasC   = 0;
    STIBiasC   = STOBiasC;
    TopC       = -0.15;
    StmC       = STOBiasC;
    DoorCClose = 0;
    DoorCOpen  = 0;
    %% Thin Film
    TfC        = -0.1;
    TfE        = -1;
    %% IDC
    IdcNF      = -1.5;
    IdcPF      = -1.5;

 elseif strcmp(Command,'Zero')
    %% Emitter    
    TopE       = 0;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = 0;
    DoorEOpen  = 0;
    %% Collector    
    STOBiasC   = 0;
    STIBiasC   = 0;
    TopC       = 0;
    StmC       = 0;
    DoorCClose = 0;
    DoorCOpen  = 0;
    %% Thin Film
    TfC        = 0;
    TfE        = 0;
    %% IDC
    IdcNF      = 0;
    IdcPF      = 0;
 
 elseif strcmp(Command,'Negative')
    %% Emitter    
    TopE       = -5;
    StmE       = -5;
    STOBiasE   = -5;
    STIBiasE   = -5;
    DoorEClose = -5;
    DoorEOpen  = -5;
    %% Collector    
    STOBiasC   = -5;
    STIBiasC   = -5;
    TopC       = -5;
    StmC       = -5;
    DoorCClose = -5;
    DoorCOpen  = -5;
    %% Thin Film
    TfC        = -5;
    TfE        = -5;
    %% IDC
    IdcNF      = -5;
    IdcPF      = -5;

 elseif strcmp(Command,'Clean')
    %% Emitter    
    TopE       = 2;
    StmE       = -5;
    STOBiasE   = -5;
    STIBiasE   = -5;
    DoorEClose = -5;
    DoorEOpen  = -5;
    %% Collector    
    STOBiasC   = -5;
    STIBiasC   = -5;
    TopC       =  2;
    StmC       = -5;
    DoorCClose = -5;
    DoorCOpen  = -5;
    %% Thin Film
    TfC        = -5;
    TfE        = -5;
    %% IDC
    IdcNF      = -5;
    IdcPF      = -5;
elseif strcmp(Command,'FlipEmit')
    %% Emitter    
    TopE       = -4;
    StmE       = -4;
    STOBiasE   = -4;
    STIBiasE   = -4;
    DoorEClose = -4;
    DoorEOpen  = -4;
    %% Collector
    STOBiasC   = 0;
    STIBiasC   = 0;
    TopC       = -0.7;
    StmC       = 0;
    DoorCClose = -1;
    DoorCOpen  = -1; %TopC-0.2;
    %% Thin Film
    TfC        = -3;
    TfE        = -3;
    %% IDC
    IdcNF      = -3;
    IdcPF      = -3;

elseif strcmp(Command,'FlipTransfer')
    %% Emitter    
    TopE       = 0.7;
    StmE       = 1.6;
    STOBiasE   = 1.6;
    STIBiasE   = 1.6;
    DoorEClose = 1.5;
    DoorEOpen  = 0.6;
    %% Collector
    STOBiasC   = 0;
    STIBiasC   = 0;
    TopC       = -0.5;
    StmC       = 0;
    DoorCClose = 0.8;
    DoorCOpen  = 0.8; %TopC-0.2;
    %% Thin Film
    TfC        = 1;
    TfE        = 1.5;
    %% IDC
    IdcNF      = -0.1;
    IdcPF      = -0.1;

elseif strcmp(Command,'FlipTransfer2')
    %% Emitter    
    TopE       = -0.7;
    StmE       = 0;
    STOBiasE   = 0;
    STIBiasE   = 0;
    DoorEClose = 0.3;
    DoorEOpen  = 0.3;
    %% Collector
    STOBiasC   = -1.1;
    STIBiasC   = 0;
    TopC       = -0.5;
    StmC       = 0;
    DoorCClose = 0.8;
    DoorCOpen  = 0.8; %TopC-0.2;
    %% Thin Film
    TfC        = 1;
    TfE        = 1.5;
    %% IDC
    IdcNF      = -0.1;
    IdcPF      = -0.1;
    
end

% RAMP
chanList = [TopEPort StmEPort STOBiasEPort STIBiasEPort DoorEClosePort DoorEOpenPort STOBiasCPort STIBiasCPort TopCPort StmCPort... 
    DoorCClosePort DoorCOpenPort TfCPort TfEPort IdcNFPort IdcPFPort];
voltList = [TopE StmE STOBiasE STIBiasE DoorEClose DoorEOpen STOBiasC STIBiasC TopC StmC DoorCClose DoorCOpen TfC TfE... 
    IdcNF IdcPF]; 

sigDACRampVoltage(DAC,chanList,voltList,numSteps);

if turnOnHelium
   negIDC = 20;
   posIDC = -20;
   devices = {SIM900,SIM900};
   ports = {IdcNFPort,IdcPFPort};
   stop = [negIDC,posIDC];
   numSteps = 100;
   waitTime = 5;

   interleavedRamp(devices,ports,stop,numSteps,waitTime)
end

end 
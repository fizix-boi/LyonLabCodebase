classdef SR830 < handle
    %SR830 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        IPAddress
        port         {mustBeNumeric}
        client
        timeConstant {mustBeNumeric}
        sensitivity  {mustBeNumeric}
        freq         {mustBeNumeric}
        amplitude    {mustBeNumeric}
        Aux1         {mustBeNumeric}
        Aux2         {mustBeNumeric}
        Aux3         {mustBeNumeric}
        Aux4         {mustBeNumeric}

    end

    methods
        %% Instrument/class initialization. Make sure your port and IP address are known well!
        function SR830 = SR830(port,IPAddress)
            SR830.IPAddress     = IPAddress;
            SR830.port          = port;
            SR830.client        = TCPIP_Connect(IPAddress,port);
            SR830.timeConstant  = 0;%SR830queryTimeConstant(SR830.client);
            SR830.sensitivity   = 0;%SR830querySensitivity(SR830.client);
            SR830.freq          = 0;%SR830queryFreq(SR830.client);
            SR830.amplitude     = 0;%SR830queryAmplitude(SR830.client);
            SR830.Aux1          = 0;%SR830queryAuxOut(SR830.client,1);
            SR830.Aux2          = 0;%SR830queryAuxOut(SR830.client,2);
            SR830.Aux3          = 0;%SR830queryAuxOut(SR830.client,3);
            SR830.Aux4          = 0;%SR830queryAuxOut(SR830.client,4);
            getSR830State(SR830);
        end
        %% Get the instrument configuration 
        function SR830Config = getSR830State(SR830)
            SR830Config = ['SR830, Amp, Freq, Sens, TC, Aux1, Aux2, Aux3, Aux4',"","","","","","","",""];
            SR830Config(2) = num2str(SR830queryAmplitude(SR830));
            SR830Config(3) = num2str(SR830queryFreq(SR830));
            SR830Config(4) = num2str(SR830querySensitivity(SR830));
            SR830Config(5) = num2str(SR830queryTimeConstant(SR830));
            SR830Config(6) = num2str(SR830queryAuxOut(SR830,1));
            SR830Config(7) = num2str(SR830queryAuxOut(SR830,2));
            SR830Config(8) = num2str(SR830queryAuxOut(SR830,3));
            SR830Config(9) = num2str(SR830queryAuxOut(SR830,4));
        end
        %% Getter functions for the SR830 instrument

        function freq = SR830queryFreq(SR830)
            freq = str2double(query(SR830.client, 'FREQ ?'));
            SR830.freq = freq;
        end
        
        function amp = SR830queryAmplitude(SR830)
            amp = str2double(query(SR830.client,'SLVL ?'));
            SR830.amplitude = amp;
        end

        function auxVoltage = SR830queryAuxOut(SR830,auxOut)
            command = ['AUXV ? ' num2str(auxOut)];
            auxVoltage = str2double(query(SR830.client,command));
            if auxOut == 1
                SR830.Aux1 = auxVoltage;
            elseif auxOut == 2
                SR830.Aux2 = auxVoltage;
            elseif auxOut == 3
                SR830.Aux3 = auxVoltage;
            else
                SR830.Aux4 = auxVoltage;
            end
        end
        
        function xVal = SR830queryX(SR830)
            xVal = str2double(query(SR830.client, 'OUTP ? 1'));
        end
        
        function yVal = SR830queryY(SR830)
            yVal = str2double(query(SR830.client, 'OUTP ? 2'));
        end
        
        function rVal = SR830queryR(SR830)
            rVal = str2double(query(SR830.client, 'OUTP ? 3'));
        end

        function theta = SR830queryTheta(SR830)
            theta = str2double(query(SR830.client, 'OUTP ? 4'));
        end

        function sensitivity = SR830querySensitivity(SR830)

            sensArr = [2e-9, 5e-9, 1e-8, 2e-8, 5e-8, 1e-7, 2e-7,5e-7, 1e-6,2e-6,5e-6,1e-5,2e-5, 5e-5,1e-4,2e-4,5e-4,1e-3,2e-3,5e-3,.01,.02,.05,.1,.2,.5,1];
            sensVal = str2double(query(SR830.client, 'SENS ?'));
            sensitivity = sensArr(sensVal+1);
            SR830.sensitivity = sensitivity;
        end

        function [tc] = SR830queryTimeConstant(SR830)
            tcArr = [1e-5,3e-5,1e-4,3e-4,1e-3,3e-3,1e-2,3e-2,.1,.3,1,3,10,30];
            tc = tcArr(str2double(query(SR830.client, 'OFLT ?'))+1);
            SR830.timeConstant = tc;
        end

        %% Setter functions for the SR830 instrument
        function SR830setFreq(SR830,freq)
            if freq < .001 || freq > 102000
                fprintf(['Desired SR830 frequency ' num2str(freq) ' out of range (.001->102000Hz)\n']);
            else
                command = ['FREQ ' num2str(freq)];
                fprintf(SR830.client,command);
                SR830.freq = freq;
            end
        end
        function SR830setAmplitude(SR830, amplitude)
            % 2 mV precision (rounds to closest 2mV). Range of .004 to 5V

            if amplitude < .004 || amplitude > 5
                fprintf(['Desired SR830 amplitude ' num2str(amplitude) ' out of range (.004V -> 5V)\n'] )
            else
                command = ['SLVL ' num2str(amplitude)];
                fprintf(SR830.client,command);
                SR830.amplitude = amplitude;
            end
        end

        function SR830setAuxOut(SR830,auxOut,voltage)
            if auxOut > 4 || auxOut < 1
                fprintf('auxOut must be between 1-4\n');
            else
                command = ['AUXV ' num2str(auxOut) ', ' num2str(voltage)];
                fprintf(SR830.client,command);
                if auxOut == 1
                    SR830.Aux1 = voltage;
                elseif auxOut == 2
                    SR830.Aux2 = voltage;
                elseif auxOut == 3
                    SR830.Aux3 = voltage;
                else
                    SR830.Aux4 = voltage;
                end
            end
        end
        
        function SR830setSensitivity(SR830,sensitivity)
            % Sensitivity values can be between the values in this array. However SR830 only takes in values between 0 and 26.
            % By choosing a value between 0 and 26, you effectively choose the following sensitivities (in Volts).
            
            sensArr = [2e-9, 5e-9, 1e-8, 2e-8, 5e-8, 1e-7, 2e-7,5e-7, 1e-6,2e-6,5e-6,1e-5,2e-5, 5e-5,1e-4,2e-4,5e-4,1e-3,2e-3,5e-3,.01,.02,.05,.1,.2,.5,1];
            if sensitivity < 0 || sensitivity > 26
                disp('Sensitivity must be between 0 (2nV) and 26 (1V)!\n')
            else
                numSens = sensArr(sensitivity + 1);
                command = ['SENS ' num2str(sensitivity)];
                fprintf(SR830.client,command);
                SR830.sensitivity = numSens;
            end
        end

        function SR830setTimeConstant(SR830,timeConstant)
            tcArr = [1e-5,3e-5,1e-4,3e-4,1e-3,3e-3,1e-2,3e-2,.1,.3,1,3,10,30,100,300,1000,3000,10000,30000];
            if timeConstant < 0 || timeConstant > 19
                disp('Time Constant must be between 0 (10us) and 19 (30000s)\n');
            else
                tc = tcArr(timeConstant+1);
                command = ['OFLT ' num2str(timeConstant)];
                fprintf(SR830.client,command);
                SR830.timeConstant = tc;
            end
        end
    end
end


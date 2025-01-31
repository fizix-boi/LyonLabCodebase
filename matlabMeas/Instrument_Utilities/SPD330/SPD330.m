classdef SPD330

    %Driver for the Siglent SPD330X-E Power Supply, assumed to be run in
    %constant voltage mode.

    properties
        IPAddress
        identifier
        port         {mustBeNumeric}
        client
        CH1Volt
        CH1Curr
        CH2Volt
        CH2Curr
    end

    methods
        function SPD330 = SPD330(IPAddress, port)
            SPD330.IPAddress    = IPAddress;
            SPD330.port         = port;
            SPD330.client       = TCPIP_VISA_Connect(SPD330.IPAddress);
            SPD330.identifier   = query(SPD330.client, '*IDN?');
        end

        %Voltage Setters and Getters
        
        function voltage = queryVolt(SPD330, chan)
            if(chan ~= 1 && chan ~= 2)
                fprintf("The variable 'chan' must be either 1 or 2, to correspond with 1 of the two channels\n");
            else
                voltage = str2double(query(SPD330.client, ['CH', num2str(chan), ':VOLT?']));
            end
        end

%         function voltage = getRealVolt(SPD330, chan)
%             if(chan ~= 1 && chan ~= 2)
%                 fprintf("The variable 'chan' must be either 1 or 2, to correspond with 1 of the two channels\n");
%             else
%                 voltage = str2double(query(SPD330.client, ['MEAS:VOLT? CH', num2str(chan)]));
% 
%                 if chan == 1
%                     SPD330.CH1Volt = voltage;
%                 elseif chan == 2
%                     SPD330.CH2Volt = voltage;
%                 end
%             end
%         end

        function setVolt(SPD330, chan, voltSet)
            if(chan ~= 1 && chan ~= 2)
                fprintf("The variable 'chan' must be either 1 or 2, to correspond with 1 of the two channels\n");
            else
                fprintf(SPD330.client, ['CH', num2str(chan), ':VOLT ', num2str(voltSet)]);

                if chan == 1
                    SPD330.CH1Volt = queryVolt(SPD330, 1);
                elseif chan == 2
                    SPD330.CH2Volt = queryVolt(SPD330, 2);
                end
            end
        end

        % Current Setters and Getters

        function current = getSetCurr(SPD330, chan)
            if(chan ~= 1 && chan ~= 2)
                fprintf("The variable 'chan' must be either 1 or 2, to correspond with 1 of the two channels\n");
            else
                current = str2double(query(SPD330.client, ['CH', num2str(chan), ':CURR?']));
            end
        end

        function current = getRealCurr(SPD330, chan)
            if(chan ~= 1 && chan ~= 2)
                fprintf("The variable 'chan' must be either 1 or 2, to correspond with 1 of the two channels\n");
            else
                current = str2double(query(SPD330.client, ['MEAS:CURR? CH', num2str(chan)]));

                if chan == 1
                    SPD330.CH1Curr = current;
                elseif chan == 2
                    SPD330.CH2Curr = current;
                end
            end
        end

        function setCurr(SPD330, currSet, chan)
            if(chan ~= 1 && chan ~= 2)
                fprintf("The variable 'chan' must be either 1 or 2, to correspond with 1 of the two channels\n");
            else
                fprintf(SPD330.client, ['CH', num2str(chan), ':CURR ', num2str(currSet)]);

                if chan == 1
                    SPD330.CH1Curr = getRealCurr(SPD330, 1);
                elseif chan == 2
                    SPD330.CH2Curr = getRealCurr(SPD330, 2);
                end
            end
        end

        % Misc Functions

        function toggleOutput(SPD330, chan,state)
            if(chan ~= 1 && chan ~= 2)
                fprintf("The variable 'chan' must be either 1 or 2, to correspond with 1 of the two channels\n");
            else
                if(state ~= 1 && state ~= 0)
                    fprintf("The variable 'state' must be either 1 or 0, to correspond with on and off, respectively\n");
                else
                    if state == 1
                        stateStr = 'ON';
                    elseif state == 0
                        stateStr = 'OFF';
                    end
                    fprintf(SPD330.client, ['OUTP CH', num2str(chan), ',', stateStr]);
                end
            end
        end
    end
end
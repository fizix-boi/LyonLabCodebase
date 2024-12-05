classdef ATS9416
    % ATS9416 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        boardId
        systemId
        boardHandle
        samplesPerSec
    end
    
    methods(Static)

        function ATS9416 = ATS9416Initialize
            % Add path to AlazarTech mfiles
            addpath('C:\AlazarTech\ATS-SDK\7.2.2\Samples_MATLAB\Include')
            
            % Call mfile with library definitions
            AlazarDefs
            
            % Load driver library
            if ~alazarLoadLibrary()
              fprintf('Error: ATSApi library not loaded\n');
              return
            end
            
            % TODO: Select a board
            ATS9416.systemId = int32(1);
            ATS9416.boardId = int32(1);
            
            % Get a handle to the board
            ATS9416.boardHandle = AlazarGetBoardBySystemID(ATS9416.systemId, ATS9416.boardId);
            setdatatype(ATS9416.boardHandle, 'voidPtr', 1, 1);
            if ATS9416.boardHandle.Value == 0
              fprintf('Error: Unable to open board system ID %u board ID %u\n', ATS9416.systemId, ATS9416.boardId);
              return
            end
            
            % Configure the board's sample rate, input, and trigger settings
            if ~ATS9416ConfigureBoard(ATS9416.boardHandle,10e6)
              fprintf('Error: Board configuration failed\n');
              return
            end
        end
    end

    methods

        function [result] = ATS9416ConfigureBoard(ATS9416, samplesPerSec)
            % Configure sample rate, input, and trigger settings
            allowedSampleRates = [100e6,50e6,20e6,10e6,5e6,2e6,1e6,500e3,200e3,100e3];

            if ismember(samplesPerSec,allowedSampleRates) == 0
                fprintf('Sample rate %i is not allowed!\n', samplesPerSec)
                return
            end

            ATS9416.samplesPerSec = samplesPerSec;
            clockDecimation = 100e6/samplesPerSec;
            
            % Call mfile with library definitions
            AlazarDefs
            
            % set default return code to indicate failure
            result = false;
            
            % TODO: Select clock parameters as required to generate this sample rate.
            %
            % For example: if samplesPerSec is 100.e6 (100 MS/s), then:
            % - select clock source INTERNAL_CLOCK and sample rate SAMPLE_RATE_100MSPS
            % - select clock source FAST_EXTERNAL_CLOCK, sample rate SAMPLE_RATE_USER_DEF,
            %   and connect a 100 MHz signal to the EXT CLK BNC connector.            
            retCode = ...
                AlazarSetCaptureClock(  ...
                    ATS9416.boardHandle,        ... % HANDLE -- board handle
                    EXTERNAL_CLOCK_10MHz_REF,     ... % U32 -- clock source id
                    SAMPLE_RATE_100MSPS, ... % U32 -- sample rate id
                    CLOCK_EDGE_RISING,  ... % U32 -- clock edge id
                    clockDecimation                   ... % U32 -- clock decimation
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarSetCaptureClock failed -- %s\n', errorToText(retCode));
                return
            end
            
            %% Input control
            % TODO: Select channel A input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_A,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel B input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_B,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel C input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_C,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel D input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_D,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel E input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_E,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel F input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_F,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel G input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_G,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel H input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_H,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel I input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_I,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel J input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_J,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel K input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_K,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel L input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_L,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel M input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_M,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel N input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_N,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel O input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_O,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            % TODO: Select channel P input parameters as required.
            retCode = ...
                AlazarInputControlEx(             ...
                    ATS9416.boardHandle,                  ... % HANDLE -- board handle
                    CHANNEL_P,     ... % U32 -- input channel
                    DC_COUPLING,    ... % U32 -- input coupling id
                    INPUT_RANGE_PM_1_V, ... % U32 -- input range id
                    IMPEDANCE_50_OHM    ... % U32 -- input impedance id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarInputControlEx failed -- %s\n', errorToText(retCode));
                return
            end
            
            %% Trigger - Agilent 336220A TTL 3.3-3.5V
            inputRange_volts = 3.5; % +- range
            triggerLevelJ_volts = inputRange_volts*0.25; % trigger level
            triggerLevelJ = (128 + 128 * triggerLevelJ_volts / inputRange_volts);
            
            % TODO: Select trigger inputs and levels as required
            retCode = ...
                AlazarSetTriggerOperation( ...
                    ATS9416.boardHandle,        ... % HANDLE -- board handle
                    TRIG_ENGINE_OP_J,   ... % U32 -- trigger operation
                    TRIG_ENGINE_J,      ... % U32 -- trigger engine id
                    TRIG_EXTERNAL,        ... % U32 -- trigger source id
                    TRIGGER_SLOPE_POSITIVE, ... % U32 -- trigger slope id
                    triggerLevelJ,                ... % U32 -- trigger level from 0 (-range) to 255 (+range)
                    TRIG_ENGINE_K,      ... % U32 -- trigger engine id
                    TRIG_DISABLE,       ... % U32 -- trigger source id for engine K
                    TRIGGER_SLOPE_POSITIVE, ... % U32 -- trigger slope id
                    128                 ... % U32 -- trigger level from 0 (-range) to 255 (+range)
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarSetTriggerOperation failed -- %s\n', errorToText(retCode));
                return
            end
            
            % TODO: Select external trigger parameters as required
            retCode = ...
                AlazarSetExternalTrigger( ...
                    ATS9416.boardHandle,        ... % HANDLE -- board handle
                    DC_COUPLING,        ... % U32 -- external trigger coupling id
                    ETR_TTL              ... % U32 -- external trigger range id
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarSetExternalTrigger failed -- %s\n', errorToText(retCode));
                return
            end
            
            % TODO: Set trigger delay as required.
            triggerDelay_sec = 0;
            triggerDelay_samples = uint32(floor(triggerDelay_sec * ATS9416.samplesPerSec + 0.5));
            retCode = AlazarSetTriggerDelay(ATS9416.boardHandle, triggerDelay_samples);
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarSetTriggerDelay failed -- %s\n', errorToText(retCode));
                return;
            end
            
            % TODO: Set trigger timeout as required.
            % NOTE:
            % The board will wait for a for this amount of time for a trigger event.
            % If a trigger event does not arrive, then the board will automatically
            % trigger. Set the trigger timeout value to 0 to force the board to wait
            % forever for a trigger event.
            %
            % IMPORTANT:
            % The trigger timeout value should be set to zero after appropriate
            % trigger parameters have been determined, otherwise the
            % board may trigger if the timeout interval expires before a
            % hardware trigger event arrives.
            triggerTimeout_sec = 5;
            triggerTimeout_clocks = uint32(floor(triggerTimeout_sec / 10.e-6 + 0.5));
            retCode = ...
                AlazarSetTriggerTimeOut(    ...
                    ATS9416.boardHandle,            ... % HANDLE -- board handle
                    triggerTimeout_clocks   ... % U32 -- timeout_sec / 10.e-6 (0 == wait forever)
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarSetTriggerTimeOut failed -- %s\n', errorToText(retCode));
                return
            end
            
            % TODO: Configure AUX I/O connector as required
            retCode = ...
                AlazarConfigureAuxIO(   ...
                    ATS9416.boardHandle,        ... % HANDLE -- board handle
                    AUX_OUT_PACER,    ... % U32 -- mode
                    10                   ... % U32 -- parameter
                    );
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarConfigureAuxIO failed -- %s\n', errorToText(retCode));
                return
            end
            
            % set return code to indicate success
            result = true;
            end

        function [result,buffer,channelCount,bitsPerSample,samplesPerRecord] = ATS9416AcquireData_NPT(ATS9416, postTriggerSamples, records, buffersPerAcquisition, channelMask)
            % Make an AutoDMA acquisition from dual-ported memory.
            % param Alazar object
            % param postTriggerSamples: number of samples to acquire after trigger
            % param records: select no. of records per acquisition
            % return results, bufferOut: returns raw unconverted buffer data
                    
            % set default return code to indicate failure
            result = false;
            
            % call mfile with library definitions
            AlazarDefs
            
            % There are no pre-trigger samples in NPT mode
            preTriggerSamples = 0;
    
            if postTriggerSamples < 256 || mod(postTriggerSamples,128) ~= 0
                fprintf('Set an acceptable number of samples per record\n')
                return
            end
            
            % TODO: Specify the number of records per channel per DMA buffer
            recordsPerBuffer = records;
            
            % TODO: Select if you wish to save the sample data to a binary file
            saveData = false;
            
            % Calculate the number of enabled channels from the channel mask
            channelCount = 0;
            channelsPerBoard = 16;
            for channel = 0:channelsPerBoard - 1
                channelId = 2^channel;
                if bitand(channelId, channelMask)
                    channelCount = channelCount + 1;
                end
            end
            
            if (channelCount < 1) || (channelCount > channelsPerBoard)
                fprintf('Error: Invalid channel mask %08X\n', channelMask);
                return
            end
            
            % Get the sample and memory size
            [retCode, ~, ~, bitsPerSample] = AlazarGetChannelInfo(ATS9416.boardHandle, 0, 0);
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarGetChannelInfo failed -- %s\n', errorToText(retCode));
                return
            end
            
            % Calculate the size of each buffer in bytes
            bytesPerSample = floor((double(bitsPerSample) + 7) / double(8));
            samplesPerRecord = preTriggerSamples + postTriggerSamples;
            samplesPerBuffer = samplesPerRecord * recordsPerBuffer * channelCount;
            bytesPerBuffer = bytesPerSample * samplesPerBuffer;
            
            % TODO: Select the number of DMA buffers to allocate.
            % The number of DMA buffers must be greater than 2 to allow a board to DMA into
            % one buffer while, at the same time, your application processes another buffer.
            bufferCount = uint32(4);
            
            % Create an array of DMA buffers
            buffers = cell(1, bufferCount);
            for j = 1 : bufferCount
                pbuffer = AlazarAllocBuffer(ATS9416.boardHandle, bytesPerBuffer);
                if pbuffer == 0
                    fprintf('Error: AlazarAllocBuffer %u samples failed\n', samplesPerBuffer);
                    return
                end
                buffers(1, j) = { pbuffer };
            end
            
            % Create a data file if required
            fid = -1;
            if saveData
                fid = fopen('data.bin', 'w');
                if fid == -1
                    fprintf('Error: Unable to create data file\n');
                end
            end
            
            % Set the record size
            retCode = AlazarSetRecordSize(ATS9416.boardHandle, preTriggerSamples, postTriggerSamples);
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarSetRecordSize failed -- %s\n', errorToText(retCode));
                return
            end
            
            % TODO: Select AutoDMA flags as required
            admaFlags = ADMA_EXTERNAL_STARTCAPTURE + ADMA_NPT + ADMA_FIFO_ONLY_STREAMING;
            
            % Configure the board to make an AutoDMA acquisition
            recordsPerAcquisition = recordsPerBuffer * buffersPerAcquisition;
            retCode = AlazarBeforeAsyncRead(ATS9416.boardHandle, channelMask, -int32(preTriggerSamples), samplesPerRecord, recordsPerBuffer, recordsPerAcquisition, admaFlags);
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarBeforeAsyncRead failed -- %s\n', errorToText(retCode));
                return
            end
            
            % Post the buffers to the board
            for bufferIndex = 1 : bufferCount
                pbuffer = buffers{1, bufferIndex};
                retCode = AlazarPostAsyncBuffer(ATS9416.boardHandle, pbuffer, bytesPerBuffer);
                if retCode ~= ApiSuccess
                    fprintf('Error: AlazarPostAsyncBuffer failed -- %s\n', errorToText(retCode));
                    return
                end
            end
            
            % Update status
            if buffersPerAcquisition == hex2dec('7FFFFFFF')
                fprintf('Capturing buffers until aborted...\n');
            else
                fprintf('Capturing %u buffers ...\n', buffersPerAcquisition);
            end
            
            % Arm the board system to wait for triggers
            retCode = AlazarStartCapture(ATS9416.boardHandle);
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarStartCapture failed -- %s\n', errorToText(retCode));
                return
            end
            
            % Wait for sufficient data to arrive to fill a buffer, process the buffer,
            % and repeat until the acquisition is complete
            startTickCount = tic;
            updateTickCount = tic;
            updateInterval_sec = 0.1;
            buffersCompleted = 0;
            captureDone = false;
            success = false;
            
            while ~captureDone
            
                bufferIndex = mod(buffersCompleted, bufferCount) + 1;
                pbuffer = buffers{1, bufferIndex};
            
                % Wait for the first available buffer to be filled by the board
                [retCode, ~, bufferOut] = ...
                    AlazarWaitAsyncBufferComplete(ATS9416.boardHandle, pbuffer, 5000);
                if retCode == ApiSuccess
                    % This buffer is full
                    bufferFull = true;
                    captureDone = false;
                elseif retCode == ApiWaitTimeout
                    % The wait timeout expired before this buffer was filled.
                    % The board may not be triggering, or the timeout period may be too short.
                    fprintf('Error: AlazarWaitAsyncBufferComplete timeout -- Verify trigger!\n');
                    bufferFull = false;
                    captureDone = true;
                else
                    % The acquisition failed
                    fprintf('Error: AlazarWaitAsyncBufferComplete failed -- %s\n', errorToText(retCode));
                    bufferFull = false;
                    captureDone = true;
                end
            
                if bufferFull
                    % TODO: Process sample data in this buffer.
                    %
                    % NOTE:
                    % While you are processing this buffer, the board is already
                    % filling the next available buffer(s).
                    %
                    % You MUST finish processing this buffer and post it back to the
                    % board before the board fills all of its available DMA buffers
                    % and on-board memory.
                    %
                    % Samples are arranged in the buffer as follows: S0A, S0B, ..., S1A, S1B, ...
                    % with SXY the sample number X of channel Y.
                    %
                    % A 14-bit sample code is stored in the most significant bits of
                    % in each 16-bit sample value.
                    %
                    % Sample codes are unsigned by default. As a result:
                    % - a sample code of 0x0000 represents a negative full scale input signal.
                    % - a sample code of 0x8000 represents a ~0V signal.
                    % - a sample code of 0xFFFF represents a positive full scale input signal.
            
                    if bytesPerSample == 1
                        setdatatype(bufferOut, 'uint8Ptr', 1, samplesPerBuffer);
                    else
                        setdatatype(bufferOut, 'uint16Ptr', 1, samplesPerBuffer);
                    end
            
                    % Save the buffer to file
                    if fid ~= -1
                        if bytesPerSample == 1
                            samplesWritten = fwrite(fid, bufferOut.Value, 'uint8');
                        else
                            samplesWritten = fwrite(fid, bufferOut.Value, 'uint16');
                        end
                        if samplesWritten ~= samplesPerBuffer
                            fprintf('Error: Write buffer %u failed\n', buffersCompleted);
                        end
                    end
                    
                    buffer = bufferOut.Value;
                    size(buffer)
            
                    % Make the buffer available to be filled again by the board
                    retCode = AlazarPostAsyncBuffer(ATS9416.boardHandle, pbuffer, bytesPerBuffer);
                    if retCode ~= ApiSuccess
                        fprintf('Error: AlazarPostAsyncBuffer failed -- %s\n', errorToText(retCode));
                        captureDone = true;
                    end
            
                    % Update progress
                    buffersCompleted = buffersCompleted + 1;
                    if buffersCompleted >= buffersPerAcquisition
                        captureDone = true;
                        success = true;
                    elseif toc(updateTickCount) > updateInterval_sec
                        updateTickCount = tic;
                    end
            
                end % if bufferFull
            
            end % while ~captureDone
            
            % Save the transfer time
            transferTime_sec = toc(startTickCount);
            
            % Abort the acquisition
            retCode = AlazarAbortAsyncRead(ATS9416.boardHandle);
            if retCode ~= ApiSuccess
                fprintf('Error: AlazarAbortAsyncRead failed -- %s\n', errorToText(retCode));
            end
            
            % Close the data file
            if fid ~= -1
                fclose(fid);
            end
            
            % Release the buffers
            for bufferIndex = 1:bufferCount
                pbuffer = buffers{1, bufferIndex};
                retCode = AlazarFreeBuffer(ATS9416.boardHandle, pbuffer);
                if retCode ~= ApiSuccess
                    fprintf('Error: AlazarFreeBuffer failed -- %s\n', errorToText(retCode));
                end
                clear pbuffer;
            end
            
            % Display results
            if buffersCompleted > 0
                bytesTransferred = double(buffersCompleted) * double(bytesPerBuffer);
                recordsTransferred = recordsPerBuffer * buffersCompleted;
            
                if transferTime_sec > 0
                    buffersPerSec = buffersCompleted / transferTime_sec;
                    bytesPerSec = bytesTransferred / transferTime_sec;
                    recordsPerSec = recordsTransferred / transferTime_sec;
                else
                    buffersPerSec = 0;
                    bytesPerSec = 0;
                    recordsPerSec = 0.;
                end
            
                fprintf('Captured %u buffers in %g sec (%g buffers per sec)\n', buffersCompleted, transferTime_sec, buffersPerSec);
                fprintf('Captured %u records (%.4g records per sec)\n', recordsTransferred, recordsPerSec);
                fprintf('Transferred %u bytes (%.4g bytes per sec)\n', bytesTransferred, bytesPerSec);
            end
            
            % set return code to indicate success
            result = success;
        end

        function [xaxis,bufferVolts] = bufferToVolts(buffer, channelCount, bitsPerSample, samplesPerRecord, records)
            % Right shift 16-bit to get 14-bit
            bufferShift = buffer / 2^(16-double(bitsPerSample));
            
            % TODO: Convert bytes into voltage
            inputRangeInVolts = inputRangeIdToVolts(INPUT_RANGE_PM_1_V);
            
            % This 14-bit sample code represents a 0V input
            codeZero = 2^(double(bitsPerSample) - 1) - 0.5;
            
            % This is the range of 14-bit sample codes with respect to 0V level
            codeRange = 2^(double(bitsPerSample) - 1) - 0.5;
            
            % Create an array to store sample data
            bufferVolts = zeros(channelCount, samplesPerRecord);
            sine = true;
            
            if records > 1
                for i = 1:records
                    for j = 1:channelCount
                        col = 1; % Set counter
                        for k = j:channelCount:(length(buffer)/records)
                            bufferVolts(j,col) = inputRangeInVolts * (double(bufferShift(k)) - codeZero) / codeRange; % need double or else just have int
                            col = col + 1;
                        end
                        if sine == true
                            midPoint = min(bufferVolts(j,:)) + (max(bufferVolts(j,:)) - min(bufferVolts(j,:))) / 2;
                            bufferVolts(j,:) = bufferVolts(j,:) - midPoint;
                        end
                    end
                end
            
            else % For measurements with 1 record only
                for i = 1:channelCount % Each row contains a separate channel
                    col = 1; % Set counter
                    for j = i:channelCount:length(buffer) % Channel data is interleaved
                        bufferVolts(i,col) = inputRangeInVolts * (double(bufferShift(j)) - codeZero) / codeRange; % Need double or else just have int
                        col = col + 1;
                    end
                    if sine == true
                        midPoint = min(bufferVolts(i,:)) + (max(bufferVolts(i,:)) - min(bufferVolts(i,:))) / 2;
                        bufferVolts(i,:) = bufferVolts(i,:) - midPoint;
                    end
                end
            end
            
            xaxis = linspace(0, samplesPerRecord/ATS9416.samplesPerSec, length(bufferVolts(1,:)));
        end
        
        function [X,Y] = ATS9416GetXY(ATS9416, bufferVolts, filter_fc, filter_n)
            Fs = ATS9416.samplesPerSec; % Sampling frequency (Hz)
            T = samplesPerRecord/Fs; % Duration of the signal (seconds)
            t = 0:1/Fs:T-1/Fs; % Time vector
            length(t)
            f_reference = 1e6; % Frequency of the reference signal (Hz)
            sqr_wave = false;
            
            signal = sqrt(2)*bufferVolts(1,:); % Multiply by sqrt(2) to convert from Vrms to Vpeak
            
            % Generate the reference signal (known frequency)
            if sqr_wave == true
                reference_signal = sqrt(2)*square(2*pi*f_reference*t)-1i*sqrt(2)*square(2*pi*f_reference*t+pi/2);
            else
                reference_signal = sqrt(2)*sin(2*pi*f_reference*t)-1i*sqrt(2)*cos(2*pi*f_reference*t);
            end
            
            % Perform FFT on the signal and reference signal
            N = length(t);
            f = (-N/2:N/2-1)*(Fs/N);  % Frequency vector
            signal_fft = fftshift(fft(signal));  % FFT of the signal
            reference_X_fft = fftshift(fft(real(reference_signal)));  % FFT of the real reference signal
            reference_Y_fft = fftshift(fft(imag(reference_signal)));  % FFT of the imag. reference signal
            
            % Multiply signal spectrum by the reference spectrum (for X and Y)
            mixed_signal_X_fft = signal_fft .* reference_X_fft; % X component (in-phase) % conj()
            mixed_signal_Y_fft = signal_fft .* reference_Y_fft; % Y component (pi/2 out-of-phase) % conj()
            
            % RC Low-pass filter in frequency domain
            tau = 1/(2*pi*filter_fc);  % Time constant
            H_rc = (1 ./ (1 + 1i * (f/Fs) * tau)).^filter_n;  % Frequency response of the RC filter
            
            % Apply the RC filter to the X and Y components in the frequency domain
            filtered_signal_X_fft = mixed_signal_X_fft .* H_rc;
            filtered_signal_Y_fft = mixed_signal_Y_fft .* H_rc;
            
            % Perform inverse FFT to return to the time domain
            filtered_signal_X = real(ifft(ifftshift(filtered_signal_X_fft)));  % X component
            filtered_signal_Y = real(ifft(ifftshift(filtered_signal_Y_fft)));  % Y component
            
            % Normalise the filtered signal to account for the scaling from FFT/IFFT
            filtered_signal_X = filtered_signal_X / N;  % Normalize X
            filtered_signal_Y = filtered_signal_Y / N;  % Normalize Y
            
            % X and Y
            X = sqrt(mean(filtered_signal_X.^2));
            Y = sqrt(mean(filtered_signal_Y.^2));
            
            % R and phi in time-domain
            R = sqrt(filtered_signal_X.^2 + filtered_signal_Y.^2);
            phi = rad2deg(atan2(filtered_signal_Y, filtered_signal_X));
            
            % Amplitude and phase extraction from X and Y
            amplitude = sqrt(mean(filtered_signal_X.^2 + filtered_signal_Y.^2)); % Mean amplitude
            phase = atan2(mean(filtered_signal_Y), mean(filtered_signal_X)); % Phase (radians)
        end

        function [f,P1] = ATS9416GetFFT(ATS9416,bufferVolts)
            Fs = ATS9416.samplesPerSec; % Sampling frequency
            NSD = false; % Noise Spectral Density
            
            yDat = bufferVolts(1,:); % Data
            L = length(yDat); % Data length
            
            y = fft(yDat);
            f = (0:(L/2)) * Fs/L; % FFT frequency
            
            figure
            if NSD == true
                P2 = abs(y)*1/(sqrt(Fs)*L);
                P1 = P2(1:L/2+1);
                P1(2:end-1) = 2*P1(2:end-1); % (1) and (end) correspond to zero and Nyquist frequencies
                plot(f,P1)
                xlabel('Frequency (Hz)')
                ylabel('NSD (V/\surd{Hz})')
            else
                P2 = abs(y)*1/L;
                P1 = P2(1:L/2+1);
                P1(2:end-1) = 2*P1(2:end-1); % (1) and (end) correspond to zero and Nyquist frequencies
                plot(f,P1)
                xlabel('Frequency (Hz)')
                ylabel('V')
            end
        end
    end
end


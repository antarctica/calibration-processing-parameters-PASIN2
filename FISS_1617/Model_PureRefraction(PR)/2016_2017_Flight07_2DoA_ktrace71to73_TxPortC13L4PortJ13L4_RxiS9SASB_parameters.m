%-------------------------------------------------------------------
% Parameters for Direction of Arrival (DoA) estimations from SAR images
%
%   '...'
%-------------------------------------------------------------------
seasonFlight = '1617';
% output directory of Direction of Arrival (DoA) images
out_dir = '...'; 
% output file format
netCDF_flag = 1; % 0- Matlab files ('.mat'); 1- netCDF file ('.nc')
% label for the short name of the output processed SAR image
out_label = '1617F07';
% extension for the short name of the output processed SAR image
out_extension = 'nc';
% sufix for the short name of the output processed SAR image
out_fileSufix = '';
%-------------------------------------------------------------
% environment parameters
%-------------------------------------------------------------
% speed of light
c0 = 299707760; % [m/s]
%-------------------------------------------------------------
% diffraction regions (incidence perpendicular to surface, followed by diffraction below surface)
%-------------------------------------------------------------
% time interval of 'bot_file'
tracesPRI = 0.2; % [s]
%-------------------------------------------------------------
% radar parameters
%-------------------------------------------------------------
% carrier frequency
f0 = 150e6; % [Hz]
% pulse repetition frequency before range stacking
prf_before_rstacking = 15625; % [Hz]
% range stacking factor
rstacking = 25; % [pulses]
% number of transmitted sequences
nseqs = 5;
% sampling frequency (real)
Sfreal = 120e6; % [Hz]
%-------------------------------------------------------------
% azimuth processing parameters
%-------------------------------------------------------------
% lenght (power of 2) of azimuth processing block
proc_block_size = 8*1024; % [samples]
% azimuth presumming factor
az_pres = 2;
% center of angular aperture in doppler processing (from target point of view, i.e. positive when radar looks backwards)
center_angle = 0; % [deg]
%-------------------------------------------------------------
% Parameter file for SAR image processing, for obtaining the attitude data
%   (needed if the input files are not netCDF ('.nc'), because the attitude
%   data is obtained from the files containing the SAR images)
%-------------------------------------------------------------
parSARimage_file = '...';
%-------------------------------------------------------------
% Raw data files parameters
%-------------------------------------------------------------
dirIn = {'...'}; 
% all receivers
labelReceivers = {'RxP1','RxP2','RxP3','RxP4','RxB5','RxB6','RxB7','RxB8','RxS9','RxSA','RxSB','RxSC'};
% receivers, indexes within 'labelReceivers'
rx = [9 10 11 ]; 
% label for sets: 'TxP1234_C13L4','TxP1234_J13L4','TxS9ABC_C13L4','TxS9ABC_J13L4','TxP1234_C13L1'
labelSets = {'TxP1234_C13L4','TxP1234_J13L4','TxS9ABC_C13L4','TxS9ABC_J13L4','TxP1234_C13L1'}; 
% sets for beamforming, indexes within 'labelSets'
setsBeamf = [1 2 ]; 
% blocks of pulses (block index starts at 0) of raw data
pulsesPerBlock = 2500; % pulses with prf
% blockIni = floor((azGrid(1)-1)/pulsesPerBlock); % (index starts at 0)
% blockEnd = floor((azGrid(end)-1)/pulsesPerBlock); % (index starts at 0)
%-------------------------------------------------------------
% DoA image output grid
%-------------------------------------------------------------
% azimuth grid of original raw data (azGrid=1 corresponds to blockIni=0), without presumming
pulsesToSearch = (710*pulsesPerBlock+1):az_pres*1:(731*pulsesPerBlock); % [samples], (index starts at 1)
% subsampling of 'pulsesToSearch'
azStep = 4;
% length (power of 2, greater than 8) of output block processed azimuths
lengthAzOutBlock = 512;
% radial distance from platform center
radialDepthGridToSearch = -180:6.48/1:3000; % [m]
%---------------------------------------------------
% Antenna parameters
%---------------------------------------------------
% Antenna positions when aircraft is on ground:
% [x; y; z] coordinates relative to [Xcenter, Ycenter, 0] (aircraft on ground)
% 1st coordinate [m]: orhogonal to wing, positive to front (nose) of the aircraft
% 2nd coordinate [m]: along wing, positive to port tip of the aircraft
% 3rd coordinate [m]: height, positive towards sky
portPos = [0.01 -0.01 0.003 0.000;...
           8.37510 6.76510 5.1653 3.5400;...
           2.614 2.548 2.454 2.356].'; % [m], [x; y; z]
starPos = [0.000 -0.005 -0.003 0.005;...
           -3.5100 -5.1295 -6.7403 -8.3695;...
           2.356 2.454 2.548 2.614].'; % [m], [x; y; z]
bellyPos = [-2.915 -2.915 -2.915 -2.915;...
            1.469 0.500 -0.505 -1.469;...
            0.850 0.850 0.850 0.850].'; % [m], [x; y; z]
leverArms = [-2.323 0.012 1.435]; % [m], [x y z]
% number of port receivers in PASIN2
numberOfPortRxs_PASIN2 = size(portPos,1);
% number of belly receivers in PASIN2
numberOfBellyRxs_PASIN2 = size(bellyPos,1);
% number of starboard receivers in PASIN2
numberOfStarboardRxs_PASIN2 = size(starPos,1);
% wing slope in DHC-6, DeHavilland Twin Otter
wingSlope = 3.5; % (deg)
% distance (approx.) of wing elements, normalized to the wavelength
wingRxElementElectricalDistance = 0.8; % (m/m)
% distance (approx.) of belly elements, normalized to the wavelength
BellyRxElementElectricalDistance = 0.5; % (m/m)
%-----------------------------------------------------
% MUSIC processing parameters and flags
%-----------------------------------------------------
% % receivers
% chosenRXCell = {1:2, 2:3, 3:4, 1:4,...
%                 5:6, 6:7, 7:8, 5:8,...
%                 9:10, 10:11, 11:12, 9:12,...
%                 1:12};
% % DoA angles under test (SYMMETRIC!!!)
% testAngleGridStep = 0.2; % (deg)
% testAngleGridCell = {-35:testAngleGridStep:35, -35:testAngleGridStep:35, -35:testAngleGridStep:35, -35:testAngleGridStep:35,...
%                      -50:testAngleGridStep:50, -50:testAngleGridStep:50, -50:testAngleGridStep:50, -50:testAngleGridStep:50,...
%                      -35:testAngleGridStep:35, -35:testAngleGridStep:35, -35:testAngleGridStep:35, -35:testAngleGridStep:35,...
%                      -35:testAngleGridStep:35}; % (deg)
% % signal dimension
% signalDimCell = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}; % 1: do; 0: not to do
% % noise dimension
% noiseDimCell = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}; % 1: do; 0: not to do
% % covariance methode for correlation matrix estimation
% covFlagCell = {false,false,false,true,false,false,false,true,false,false,false,true,true};
% % output file names
% outputNamesCell = {'DoA_F07_ap30_TxPortRxP1P2_710_730_corrHalf10_DoA35_S1N1_calDTxA','DoA_F07_ap30_TxPortRxP2P3_710_730_corrHalf10_DoA35_S1N1_calDTxA','DoA_F07_ap30_TxPortRxP3P4_710_730_corrHalf10_DoA35_S1N1_calDTxA',...
%                    'DoA_F07_ap30_TxPortRxPort_710_730_corrHalf10_DoA35_S1N1_calDTxA',...
%                    'DoA_F07_ap30_TxPortRxB5B6_710_730_corrHalf10_DoA50_S1N1_calDTxA','DoA_F07_ap30_TxPortRxB6B7_710_730_corrHalf10_DoA50_S1N1_calDTxA','DoA_F07_ap30_TxPortRxB7B8_710_730_corrHalf10_DoA50_S1N1_calDTxA',...
%                    'DoA_F07_ap30_TxPortRxBell_710_730_corrHalf10_DoA50_S1N1_calDTxA'...
%                    'DoA_F07_ap30_TxPortRxS9SA_710_730_corrHalf10_DoA35_S1N1_calDTxA','DoA_F07_ap30_TxPortRxSASB_710_730_corrHalf10_DoA35_S1N1_calDTxA','DoA_F07_ap30_TxPortRxSBSC_710_730_corrHalf10_DoA35_S1N1_calDTxA',...
%                    'DoA_F07_ap30_TxPortRxStar_710_730_corrHalf10_DoA35_S1N1_calDTxA',...
%                    'DoA_F07_ap30_TxPortRxAll_710_730_corrHalf10_DoA35_S1N1_calDTxA'};
% % flags for matrix transformations (smoothing)
% smoothFlagCell = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}; % 1: do; 0: not to do
% % flags for matrix transformations (reorienting)
% reorientingFlagCell = {1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1}; % 1: do; 0: not to do
% % flags for matrix transformations (resampling)
% resamplingFlagCell = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}; % 1: do; 0: not to do
% receivers, indexes within 'labelReceivers'
chosenRX = rx;
% DoA angles under test (SYMMETRIC!!!)
testAngleGridStep = 0.2; % (deg)
testAngleGrid = -35:testAngleGridStep:35; % (deg)
% signal dimension
signalDim = 2; % number of expected signals
% noise dimension
noiseDim = 1; % integer number
% half of the number of shots (odd number, 2*azShotsHalfLength + 1) for the correlation matrix
azShotsHalfLength = 10; % pulses
% covariance method for correlation matrix estimation
covFlag = 0; 
% flags for matrix transformations (smoothing)
smoothFlag = 0; % 1: do; 0: not to do
% flags for matrix transformations (reorienting)
reorientingFlag = 1; % 1: do; 0: not to do
% flags for matrix transformations (resampling)
resamplingFlag = 0; % 1: do; 0: not to do
% flags for non applying inversion matrix
noInversionFlag = 0; % 0: do inversion; 1: not to do inversion
%-----------------------------------------------------
% Roll phase calibration (as phase difference from channel to the next)
%-----------------------------------------------------
% Expected to be constant from flight to flight if the antenna configuration does not change
% Adjust phases of the DoA coefficients due to calibration phase errors depending on roll angles:
%   the phases are given as phase differences from a channel to the next
% File for loading 'rollAngleInterp', 'phaseDiffErrorRXRollCalCorrVar','labelDiffReceivers'
varyingAPRollPitchCalibrationFile = '...';
%-----------------------------------------------------
% Pulse Phase correction parameters (flight dependant)
%-----------------------------------------------------
pulsePhaseCalibrationFlag = 1; %  1: do; 0: not to do
% File for the phase correction at each pulse from the direct pulses
pulsePhaseCalibrationFile = '...';
% Variables (rad) in the 'pulsePhaseCalibrationFile' (files for the phase correction at each pulse from the direct pulses)
%   each variable is a matrix of size(numberOfPulses, numberOfReceivers=12)
pulsePhaseCalibrationVarInFile = {'phaseCalibrationF07TxPortL4_RxAll',...
                                  'phaseCalibrationF07TxPortL1_RxAll',...
                                  'phaseCalibrationF07TxStarL4_RxAll'}; % (rad)
% weight of each phase variable in the total phase contribution
weightOfPulsePhaseCalibration = [1 1 1]; % (-)
%-----------------------------------------------------
% Constant Phase correction parameters (flight dependant)
%-----------------------------------------------------
constantPhaseCalibrationFlag = 1; %  1: do; 0: not to do
constantPhaseCalibrationFileFlag = 1; 
% constant phase (rad) correction at each receiver
if constantPhaseCalibrationFileFlag
    constantPhaseCalibrationFile = '...';
    % Variables (rad) in the 'pulsePhaseCalibrationFile' (files for the phase correction at each pulse from the direct pulses)
    %   each variable is a vector of length numberOfReceivers=12
    constantPhaseCalibrationVarInFile = {'offsetToRoundPhaseCalibrationF07TxPortL4_RxAll',...
                                         'offsetToRoundPhaseCalibrationF07TxPortL1_RxAll',...
                                         'offsetToRoundPhaseCalibrationF07TxStarL4_RxAll',...
                                         'offsetToRoundMeanPhaseCalibrationF07_RxAll'}; % (rad)
    % weight of each phase variable in the total phase contribution
    weightOfConstantPhaseCalibration = [0 0 0 1]; % (-)
else
    %constantPhaseCorrection = zeros(1,12); % (rad)
    constantPhaseCorrection = [14.6591    2.2241    0   11.4529   29.6525    5.2261    6.5783   19.4585    3.9290   -0.7604    1.4555    4.8403]*pi/180; % (rad)
end
%---------------------------------------------
% Parameters for netCDF file
%---------------------------------------------
% --- References:
%     netCDF User's Guide (NUG): main information about netCDF
%           https://www.unidata.ucar.edu/software/netcdf/documentation/4.7.4-pre/index.html
%           https://www.unidata.ucar.edu/software/netcdf/documentation/4.7.4-pre/attribute_conventions.html
% --- Data types:
% 'NC_BYTE'     int8
% 'NC_UBYTE'    uint8
% 'NC_CHAR'     char
% 'NC_SHORT'	int16
% 'NC_USHORT'	uint16
% 'NC_INT'      int32
% 'NC_UINT'     uint32
% 'NC_INT64'    int64
% 'NC_UINT64'   uint64
% 'NC_FLOAT'	single
% 'NC_DOUBLE'	double
if netCDF_flag
    % flaf for storing the amplitude of the MUSIC estimation
netCDF_amplitudeDoAFlag = 1; % 1, store; 0, not to store
    % flag for storing the sign of DoA estimations, as a byte joining the signs of 8 numbers
netCDF_signBitFlag = 0; % 1, store sign; 0, not to store sign
    % the flag for storing is useful when representing 'testAngleGrid' with 9 bits (between 257 and 512 values)
    netCDF_signBitFlag = netCDF_signBitFlag && (length(testAngleGrid)>256 || length(testAngleGrid)<=512); % the abs(DoA) will be stored with a unsigned byte
    %---------------------------------------------
    % DIMENSIONS in netCDF File: cell of structs, with:
    %   - 'name' field: indicator for the name of the DIMENSION;
    %   - 'length' field: indicator for the length of the DIMENSION. Interger number or the standard 'NC_UNLIMITED'
    % The unlimited dimension must be the last dimension when defining the variables, because MATLAB
    %   uses FORTRAN-style ordering for netCDF (fastest-varying dimension comes first and the slowest comes last)
    %---------------------------------------------
    indexDimension = 0; % to grow, starting at 1 before the first DIMENSION
    cellDimNetCDF = {};
    % --- 'directionOfArrivalGrid' dimension, limited
    indexDimension = indexDimension + 1;
    cellDimNetCDF{indexDimension}.name = 'directionOfArrivalGrid';
    cellDimNetCDF{indexDimension}.length = length(testAngleGrid);
    indexDirectionOfArrivalGridDimension = indexDimension - 1;
    % --- 'numberOfEstimationsGrid' dimension, limited
    indexDimension = indexDimension + 1;
    cellDimNetCDF{indexDimension}.name = 'numberOfDoAEstimationsGrid';
    cellDimNetCDF{indexDimension}.length = signalDim;
    indexNumberOfDoAEstimationsDimensionGrid = indexDimension - 1;
    % --- 'Depth grid' dimension, limited
    indexDimension = indexDimension + 1;
    cellDimNetCDF{indexDimension}.name = 'radialDepthGrid';
    cellDimNetCDF{indexDimension}.length = length(radialDepthGridToSearch);
    indexRadialDepthGridDimension = indexDimension - 1;
    % --- 'profile' dimension (along-track), unlimited
    indexDimension = indexDimension + 1;
    cellDimNetCDF{indexDimension}.name = 'profile';
    cellDimNetCDF{indexDimension}.length = 'NC_UNLIMITED';
    indexProfileDimension = indexDimension - 1;
    % --- 'signBit' dimension, unlimited
    if netCDF_signBitFlag
        indexDimension = indexDimension + 1;
        cellDimNetCDF{indexDimension}.name = 'signBit';
        cellDimNetCDF{indexDimension}.length = 'NC_UNLIMITED';
        indexSignBitDimension = indexDimension - 1;
    end
    %---------------------------------------------
    % Global ATTRIBUTES in netCDF File: cell of structs, with:
    %   - 'name' field: indicator for the name of the ATTRIBUTE;
    %   - 'value' field: indicator for the ATTRIBUTE value
    %---------------------------------------------
    indexGA = 0; % to grow, starting at 1 before the first Global ATTRIBUTES
    cellGlobalAttNetCDF = {};
    keySep = ', ';
    % --- Title (defined by NUG (NetCDF User's Guide))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'title';
    cellGlobalAttNetCDF{indexGA}.value = ['Ice-sounding depth profiles of Direction of arrival (DoA) from airborne synthetic-aperture-radar (SAR) PASIN2 instrument, ' ...
                                          'over the Recovery Ice Stream (Filchner Ice Shelf System) in the Antarctic summer 2016/2017'];
    % --- Summary (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'summary';
    cellGlobalAttNetCDF{indexGA}.value = [... % summary of PASIN2
              'PASIN2 (Polarimetric Airborne Scientific Instrument, mark 2) is a 150 MHz coherent pulsed radar with the purpose ' ...
              'of deep ice sounding for bedrock, subglacial channels and ice-water interface detection in Antarctica. PASIN2 aims ' ...
              'to map in 3D the bottom of glaciers, either bedrock or basal water. It is designed and operated by the British ' ...
              'Antarctic Survey (BAS). With multiple antennas for transmission and reception, PASIN2 enables polarimetric ' ...
              '3D estimation of the bottom profile with a single pass, reducing the gridding density of the survey paths. ' ...
              'Single 2D SAR images present ambiguities for distinguishing between scatterers from port and starboard directions. ' ...
              'This occurs because the antennas are pointing vertically downwards, to take advantage of the greater radar cross-section ' ...
              'under perpendicular incidence. The solution adopted for PASIN2 was an across-track physical array. After processing several ' ...
              '2D SAR images (range and along-track dimensions) with transmitter-receiver pairs, the directional ambiguities are ' ...
              'resolved, obtaining the across-track Direction of Arrival (DoA, elevation angle) estimation. Finally, from the 3D ' ...
              'geometry of range, along-track and across-track angles, the real depths and across-track distances are estimated, ' ...
              'regarding the case of wrongly assumed vertical DoA of a single SAR image.' newline...
          ... % summary of PASIN2 processing 
              'The data processing is performed off-line, consisting in: 1) channel calibration; '...
              '2) 2D synthetic aperture radar (SAR) imaging, based on pulse-compression for range dimension, and back-projection for along-track dimension; ' ...
              '3) Direction of Arrival estimation (DoA) of the remaining across-track angle, based on the non-linear MUSIC algorithm, ' ...
                  'by using several SAR images from different transmitters or receivers; ' ...
          'and 4) 3D-mapping from the three dimensions range, along-track and across-track angles, by correcting the real depths and ' ...
                  'across-track distances, regarding the case of wrongly-assumed vertical DoA of a single SAR image' ...
              'Calibration flights, during the Antarctic Summer campaigns in 16/17 and 19/20 seasons, assessed and validated the ' ...
              'instrument and processing performances.' newline...
          ... % summary of current netCDF 
              'This netCDF file corresponds to a Direction of Arrival (DoA) image of the data collected during the Antarctic Summer of 2016/17, ' ...
              'above the Filchner Ice Shelf System, in the Recovery Ice Stream, near the grounding line. The DoA image is 2D or 3D, with ' ...
              'vertical ice-sounding profiles along the aircraft trajectory, one profile per along-track location. Each profile ' ...
              'belongs to the netCDF dimension and variable ''profile'', and it contains the vertical grid defined by ' ...
              'the netCDF dimension and variable ''radialDepthGrid'', and 1 or 2 DoA estimations defined by the netCDF dimension ''numberOfDoAEstimations''. ' ...
              'If there there is 1 DoA estimation per ''profile'' and ''radialDepthGrid'', the DoA beamwidth is symmetrical from port to starboard, and the DoA image is 2D;', ...
              'if there there are 2 DoA estimations per ''profile'' and ''radialDepthGrid'', the 1st DoA (<=0) is towards starboard and the 2nd DoA (>0) towards port, and the DoA image is 3D;', ...
              'For each of these profiles, other auxiliary data are included, such as time, pulse number, ' ...
              'positioning (latitude, longitude, height, speed, terrain clearance) and attitude data (roll, pitch, yaw) of the aircraft.'];
    % --- history (defined by NUG (NetCDF User's Guide))
    % Provides an audit trail for modifications to the original data.
    % Well-behaved generic netCDF filters will automatically append their name and the parameters with which they were invoked to the global history attribute of an input netCDF file.
    % We recommend that each line begin with a timestamp indicating the date and time of day that the program was executed.
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'history';
    cellGlobalAttNetCDF{indexGA}.value = 'To be defined!!!';
    % --- conventions (defined by NUG (NetCDF User's Guide))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'conventions';
    cellGlobalAttNetCDF{indexGA}.value = 'CF-1.8 ACDD-1.3 NCEI-2.0';
    % --- institution (defined by CF (Climate and Forecast) Metadata Conventions)
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'institution';
    cellGlobalAttNetCDF{indexGA}.value = 'British Antarctic Survey';
    % --- program (defined by ACDD (Attribute Convention for Dataset Discovery))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'program';
    cellGlobalAttNetCDF{indexGA}.value = 'Scientific Program';
    % --- project (defined by ACDD (Attribute Convention for Dataset Discovery))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'project';
    cellGlobalAttNetCDF{indexGA}.value = 'FISS, Filchner Ice Shelf System';
    % --- source (defined by CF (Climate and Forecast) Metadata Conventions)
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'source';
    cellGlobalAttNetCDF{indexGA}.value = 'Airborne ice-penetrating direction of arrival (DoA) estimation, image by MUSIC'; % for identifying in 3D-mapping
    % --- instrument/sensor (defined by ACDD (Attribute Convention for Dataset Discovery))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'instrument';
    cellGlobalAttNetCDF{indexGA}.value = ['Earth Remote Sensing Instruments' keySep 'Active Remote Sensing' keySep 'Profilers/Sounders' keySep 'Radar Sounders' keySep 'PASIN2' keySep newline ...
                                          'Polarimetric radar Airborne Science Instrument (PASIN2)'];
    % --- platform (defined by ACDD (Attribute Convention for Dataset Discovery))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'platform';
    cellGlobalAttNetCDF{indexGA}.value = 'De Havilland DHC-6 Twin Otter aircraft';
    % --- season
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'season';
    cellGlobalAttNetCDF{indexGA}.value = seasonFlight;
    % --- campaign (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'campaign';
    cellGlobalAttNetCDF{indexGA}.value = seasonFlight;
    % --- flight
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'flight';
    cellGlobalAttNetCDF{indexGA}.value = out_label;
    % --- reference ellipsoid
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'reference_ellipsoid';
    cellGlobalAttNetCDF{indexGA}.value = 'To be defined!!!';
    % --- Radar parameters (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'radar_parameters';
    cellGlobalAttNetCDF{indexGA}.value = ['Bistatic PASIN2 radar system operating with a centre frequency of ' num2str(f0/1e6) ' MHz and using five interleaved pulses: ' ...
                                          'Chirp: 4 microseconds, 13 MHz bandwidth linear chirp, with 0deg and 180deg modulations, from port and starboard arrays; ' ...
                                          'Chirp: 1 microseconds, 13 MHz bandwidth linear chirp, with 0deg modulation, from port array; ' ...
                                          'System Pulse Repetition Frequency: ' num2str(prf_before_rstacking) ' Hz (pulse repetition interval: ' num2str(1e6/prf_before_rstacking) ' microseconds)'];
    % --- Antennas (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'antennas';
    cellGlobalAttNetCDF{indexGA}.value = ['8 folded dipole elements: 4 transmitters/receivers (port side), 4 transmitters/receivers (starboard side); ' ...
                                          '4 printed dipole elements: 4 receivers (belly); ' ...
                                          'Antenna gain: 11 dBi wing arrays, 8 dBi Belly array; Transmit power: 0.5 kW into each 4 antennas; Maximum transmit duty cycle: 10% at full power (4 x 0.5 kW)'...
                                          'Antenna labels, from port tip to starboard tip: P1, P2, P3, P4, B5, B6, B7, B8, S9, SA, SB, SC'];
    % --- Digitiser (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'digitiser';
    cellGlobalAttNetCDF{indexGA}.value = ['Receiver sampling frequency: ' num2str(Sfreal/1e6) ' MHz (resulting in sampling interval of ' num2str(1e9/Sfreal) ' nanoseconds); '...
                                          'Receiver coherent stacking: ' num2str(rstacking) ' pulses; ' ...
                                          'Receiver digital filtering: 13 MHz; Effective PRF per each of the five pulses: ' num2str(prf_before_rstacking/(nseqs*rstacking)) ' Hz (post-hardware stacking); '...
                                          'Sustained data rate per pulse and receiver: 150 MB/km'];
    % --- Processing (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'processing';
    cellGlobalAttNetCDF{indexGA}.value = ['Direction of arrival estimation by MUSIC algorithm, a non-linear hihg-resolution algorithm, using as input ' ...
                                          ' the synthetic aperture radar (SAR) images applied to the scatterer grid locations. The grid is defined for depth and along-track locations. ' ...
                                          'A pre-processing for uniformising and linearising PASIN2 array of antennas is carried out before MUSIC algorithm.'];
    % --- Resolutions (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'resolution';
    cellGlobalAttNetCDF{indexGA}.value = ['vertical sampling: ' num2str(mean(diff(radialDepthGridToSearch))) ' meters; '...
                                          'along-track sampling: ' num2str(mean(diff(pulsesToSearch))*azStep/(prf_before_rstacking/(nseqs*rstacking))*1e3) ' milisseconds'];
    % --- GPS sensor (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'GPS_IMU_LIDAR';
    %cellGlobalAttNetCDF{indexGA}.value = ['Dual-frequency GPS (Leica SR530 and Ashtec Z-12) Absolute GPS positional accuracy: ~0.1 m (relative accuracy is one order of magnitude better). ' ...
    %                                      'Banking angle was limited to 10deg during aircraft turns to avoid phase issues between GPS receiver and transmitter'];
    cellGlobalAttNetCDF{indexGA}.value = ['Global Positioning System (GPS) and Inertial Measurement Unit (IMU) devices are integrated, to obtain geographic ' ...
                                           'coordinates (latitude, longitude and elevation) and rotation angles (roll, pitch and yaw), sampled at ' num2str(10) ' Hz. For ' ...
                                           'terrain clearance (distance from radar to surface) measurement, it is used a lidar (Riegl LMS-Q240i) in near-infrared, ' ...
                                           'with a maximum range of 650 m and 2 mm accuracy'];
    % --- keywords (defined by ACDD (Attribute Convention for Dataset Discovery))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'keywords';
    cellGlobalAttNetCDF{indexGA}.value = ['Earth Science' keySep 'Cryosphere' keySep 'Glaciers/Ice Sheets' keySep 'Glacier Topography/Ice Sheet Topography' keySep newline ... % GCMD location
                                          'Continent' keySep 'Antarctica' keySep 'Filchner Ice Shelf' keySep 'Recovery Ice Stream' keySep newline ... % GCMD science
                                          'Antarctic' keySep 'Aerogeophysics' keySep 'Ice thickness' keySep 'Radar' keySep 'Surface elevation' keySep 'Direction of arrival'];
    % --- Location (-----) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'location';
    cellGlobalAttNetCDF{indexGA}.value = 'Recovery Ice Stream';
    % --- Date of data take start (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'time_coverage_start';
    cellGlobalAttNetCDF{indexGA}.value = 'YYYY/MM/DD';
    % --- Date of data take end (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'time_coverage_end';
    cellGlobalAttNetCDF{indexGA}.value = 'YYYY/MM/DD';
    % --- featureType (defined by CF (Climate and Forecast) Metadata Conventions)
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'featureType';
    cellGlobalAttNetCDF{indexGA}.value = 'profile';
    % --- processing_level (Attribute Convention for Dataset Discovery)
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'processing_level';
    cellGlobalAttNetCDF{indexGA}.value = 'L2';
    % --- keywords (defined by ACDD (Attribute Convention for Dataset Discovery))
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'keywords_vocabulary';
    cellGlobalAttNetCDF{indexGA}.value = 'GCMD Science Keywords Version 9.1.5';
    % --- List of standard names (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'standard_name_vocabulary';
    cellGlobalAttNetCDF{indexGA}.value = 'CF Standard Name Table v77';
    % --- comment (defined by CF (Climate and Forecast) Metadata Conventions)
    indexGA = indexGA + 1;
    commentString = ['Estimated Direction of Arrival (DoA) with the incorrectly vertical-assumed depth profile (nadir direction, range) relative to the air/ice interface, along the aircraft trajectory (Doppler). ' newline ...
                     'The DoA is in free space, not regarding the vertical, but regarding the across-track axis perpendicular to the segment joining the wing tips (i.e., aircraft body-fixed frame); ' ...
                     ' and to be regarding the vertical, the roll angle of the aircraft must be considered. ' newline ...
                     'Supporting data with the positioning and attitude of the platform are also included. ' newline ...
                     'The true depth and across-track location of each bottom scatterer will be obtained from the DoA''s, the roll angle, and the incorrectly vertical-assumed depth profile. ' newline ...
                     'The DoA''s are the result of combined coregistred SAR 2D-images from different transmitters/receivers, for each 2D-image pixel. ' newline ...
                     'The SAR 2D-images (complex domain) have been processed with Backprojection algorithm. ' newline ...
                     'The main processing script is included (full name and content) in the ''GLOBAL'' ATTRIBUTE ''processing_main''. ' newline ...
                     'The parameter files are included (full name and content) in the ''GLOBAL'' ATTRIBUTE ''parameter_file_ii''. ' newline ...
                    ];
    cellGlobalAttNetCDF{indexGA}.name = 'comment';
    cellGlobalAttNetCDF{indexGA}.value = commentString;
    % --- references (defined by CF (Climate and Forecast) Metadata Conventions)
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'references';
    cellGlobalAttNetCDF{indexGA}.value = ['http://cfconventions.org/Data/cf-conventions/cf-conventions-1.8/cf-conventions.html' newline ...         % 'variables', 'attributes', etc.
                                    'http://cfconventions.org/Data/cf-standard-names/73/build/cf-standard-name-table.html' newline ...              % 'standard_name' conventions.
                                    'https://www.unidata.ucar.edu/software/netcdf/documentation/4.7.4-pre/index.html' newline ...                   % main information about netCDF
                                    'https://www.unidata.ucar.edu/software/netcdf/documentation/4.7.4-pre/attribute_conventions.html' newline ... 
                                    'https://wiki.esipfed.org/Category:Attribute_Conventions_Dataset_Discovery' newline ...                         % 'variables', 'attributes', etc.
                                    'https://wiki.esipfed.org/Attribute_Convention_for_Data_Discovery_1-3' newline...
                                    'https://www.nodc.noaa.gov/data/formats/netcdf/v2.0/' newline ...                                               % 'variables', 'attributes', etc.
                                    'https://earthdata.nasa.gov/earth-observation-data/find-data/gcmd/gcmd-keywords' newline ...                    % 'keywords'
                                    'https://gcmd.earthdata.nasa.gov/static/kms/'];
    % --- Acknowledgement (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'acknowledgement';
    cellGlobalAttNetCDF{indexGA}.value = ['This work was funded by the British Antarctic Survey in support of the Natural Environment Research Council (NERC). ' ...
                                          'The campaign was carried out by the British Antarctic Survey'];
    % --- License (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'license';
    cellGlobalAttNetCDF{indexGA}.value = 'http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/';
    % --- Name of publisher (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'publisher_name';
    cellGlobalAttNetCDF{indexGA}.value = 'UK Polar Data Centre';
    % --- Type of publisher (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'publisher_type';
    cellGlobalAttNetCDF{indexGA}.value = 'institution';
    % --- Email of publisher (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'publisher_email';
    cellGlobalAttNetCDF{indexGA}.value = 'polardatacentre@bas.ac.uk';
    % --- Link of publisher (defined by ACDD (Attribute Convention for Dataset Discovery)) ********
    indexGA = indexGA + 1;
    cellGlobalAttNetCDF{indexGA}.name = 'publisher_link';
    cellGlobalAttNetCDF{indexGA}.value = 'https://www.bas.ac.uk/data/uk-pdc/';
    %---------------------------------------------
    % VARIABLES and ATTRIBUTES in netCDF File: cell of structs, with:
    %   - 'name' field: indicator for the name of the VARIABLE;
    %   - 'xtype' field: indicator for the type of the VARIABLE;
    %   - 'dimid' field: indicator for the dimension id of the VARIABLE, according to the index of 'cellDimNetCDF' - 1.
    %       In the standard, 'dimid' is indexed starting with zero (C-based), and here too, but the index of 'cellDimNetCDF' starts with 1 (Matlab-based)
    %       The unlimited dimension must be the last dimension, because MATLAB uses FORTRAN-style
    %           ordering for netCDF (fastest-varying dimension comes first and the slowest comes last)
    %   - 'FillValue' field: indicator for the standard ATTRIBUTE '_FillValue';
    %   - 'DefVarChunking' field: indicator for defining chunking with function 'netcdf.defVarChunking'
    %   - 'DefVarDeflate' field: indicator for defining the compression with function 'netcdf.defVarDeflate'
    %   - other fields: standard ATTRIBUTE names
    %---------------------------------------------
    indexVar = 0; % to grow, starting at 1 before the first VARIABLE
    cellVariableNetCDF = {};
    %---------------------
    % Fixed-size variables (non-record variables)
    %---------------------
    % --- Direction of arrival grid within across-track plane, from the aircraft body-fixed frame axis (tilled according to roll) point of view:
    %          negative from starboard, zero from aircraft body-fixed axis, and positive from port ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'directionOfArrivalGrid';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexDirectionOfArrivalGridDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.long_name = ['Direction of arrival grid, from the aircraft body-fixed frame axis (tilled according to roll) point of view: '...
                                                'negative from starboard, zero from aircraft body-fixed axis, and positive from port'];
    cellVariableNetCDF{indexVar}.units = 'degrees';
    cellVariableNetCDF{indexVar}.positive = 'right';
    % --- Number of DoA estimations grid per sample ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'numberOfDoAEstimationsGrid';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = indexNumberOfDoAEstimationsDimensionGrid; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.long_name = 'Number of DoA estimations grid per sample';
    cellVariableNetCDF{indexVar}.valid_min = 1;
    % --- Depth grid: nadir bottom depth below (positive) and above (negative) surface ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'radialDepthGrid';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexRadialDepthGridDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.long_name = 'Depth grid in SAR image: nadir (vertical) direction below (positive) and above (negative) surface';
    cellVariableNetCDF{indexVar}.units = 'meters';
    cellVariableNetCDF{indexVar}.positive = 'down';
    cellVariableNetCDF{indexVar}.axis = 'Z';
    % --- Centre of angular aperture in Doppler processing (from target point of view, i.e. positive when radar looks backwards)
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'alongTrackCentralAngle';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Centre of angular beamwidth in Doppler processing (from target point of view, i.e. positive when radar looks backwards)';
    cellVariableNetCDF{indexVar}.units = 'degrees';
    cellVariableNetCDF{indexVar}.valid_min = -90;
    % --- Carrier (central) frequency
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'centralFrequency';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Carrier (central) frequency of the system';
    cellVariableNetCDF{indexVar}.units = 'Hz';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    % --- Noise dimension
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'noiseDimension';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Dimension of interference/noise subspace';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    % --- Number of shots along-track for the correlation matrix
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'alongTrackShots';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Number of shots along-track for the correlation matrix';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    % --- Covariance method for correlation matrix estimation
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'covarianceFlag';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Covariance method for correlation matrix estimation';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    % --- Flag for smoothing (matrix transformations) of PASIN2 channels
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'smoothingFlag';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Flag for smoothing (matrix transformations) of PASIN2 channels: 1, do; 0, not to do';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    % --- Flag for reorienting (matrix transformations) of PASIN2 channels
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'reorientingFlag';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Flag for reorienting (matrix transformations) of PASIN2 channels: 1, do; 0, not to do';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    % --- Flag for resampling (matrix transformations) of PASIN2 channels
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'resamplingFlag';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Flag for resampling (matrix transformations) of PASIN2 channels: 1, do; 0, not to do';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    % --- Flag for 'netCDF_signBitFlag'
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'netCDF_signBitFlag';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
    cellVariableNetCDF{indexVar}.dimid = []; % scalar variable
    cellVariableNetCDF{indexVar}.long_name = 'Flag for storing the sign of DoA estimations, as a byte joining the signs of 8 numbers: 1, do; 0, not to do';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    cellVariableNetCDF{indexVar}.FillValue = 0; % '_FillValue' is the standard name
    %---------------------
    % Unlimited-size variables (record variables)
    %---------------------
    % --- Profile --- (start at 0)
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'profile';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UINT';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.cf_role = 'profile_id';
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Transmitted pulse --- (start at 1)
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'pulse';
    cellVariableNetCDF{indexVar}.xtype = 'NC_UINT';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.long_name = 'Transmitted pulse within the effective PRF sequence (for the current waveform, after pulse stacking)';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    cellVariableNetCDF{indexVar}.FillValue = 2^32-1; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Pulse Time ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'pulseTime';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.long_name = 'Time at transmitted pulse within the effective PRF sequence (for the current waveform, after pulse stacking)';
    cellVariableNetCDF{indexVar}.units = 'To be defined!!!';
    cellVariableNetCDF{indexVar}.FillValue = -1; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Latitude ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'latitudeAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.standard_name = 'latitude';
    cellVariableNetCDF{indexVar}.long_name = 'Latitude of aircraft at transmitted pulse';
    cellVariableNetCDF{indexVar}.units = 'degrees_north';
    cellVariableNetCDF{indexVar}.valid_min = -90;
    cellVariableNetCDF{indexVar}.valid_max = +90;
    cellVariableNetCDF{indexVar}.FillValue = -999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Longitude ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'longitudeAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.standard_name = 'longitude';
    cellVariableNetCDF{indexVar}.long_name = 'Longitude of aircraft at transmitted pulse';
    cellVariableNetCDF{indexVar}.units = 'degrees_east';
    cellVariableNetCDF{indexVar}.valid_min = -360;
    cellVariableNetCDF{indexVar}.valid_max = +360;
    cellVariableNetCDF{indexVar}.FillValue = -999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Height of aircraft ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'heightAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.standard_name = 'height_above_mean_sea_level';
    cellVariableNetCDF{indexVar}.long_name = 'Height of aircraft above mean sea level (asl)';
    cellVariableNetCDF{indexVar}.units = 'meters';
    cellVariableNetCDF{indexVar}.positive = 'up';
    cellVariableNetCDF{indexVar}.FillValue = -99999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Terrain clearance of aircraft ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'terrainClearanceAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.long_name = 'Terrain clearance, distance from platform to air interface with ice, sea or ground';
    cellVariableNetCDF{indexVar}.units = 'meters';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    cellVariableNetCDF{indexVar}.FillValue = -999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Aircraft speed ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'speedAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.standard_name = 'platform_speed_wrt_air';
    cellVariableNetCDF{indexVar}.long_name = 'Aircraft speed';
    cellVariableNetCDF{indexVar}.units = 'meters/second';
    cellVariableNetCDF{indexVar}.valid_min = 0;
    cellVariableNetCDF{indexVar}.FillValue = -999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Aircraft roll ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'rollAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.standard_name = 'platform_roll_starboard_down';
    cellVariableNetCDF{indexVar}.long_name = 'Aircraft roll, positive according to right-hand rule pointing towards aircraft direction (along-track)';
    cellVariableNetCDF{indexVar}.units = 'degrees';
    cellVariableNetCDF{indexVar}.valid_min = -360;
    cellVariableNetCDF{indexVar}.valid_max = +360;
    cellVariableNetCDF{indexVar}.FillValue = -999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Aircraft pitch ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'pitchAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.standard_name = 'platform_pitch_fore_up';
    cellVariableNetCDF{indexVar}.long_name = 'Aircraft pitch, positive according to left-hand rule pointing towards port direction';
    cellVariableNetCDF{indexVar}.units = 'degrees';
    cellVariableNetCDF{indexVar}.valid_min = -360;
    cellVariableNetCDF{indexVar}.valid_max = +360;
    cellVariableNetCDF{indexVar}.FillValue = -999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- Aircraft yaw ---
    indexVar = indexVar + 1;
    cellVariableNetCDF{indexVar}.name = 'yawAircraft';
    cellVariableNetCDF{indexVar}.xtype = 'NC_DOUBLE';
    cellVariableNetCDF{indexVar}.dimid = indexProfileDimension; % index of 'cellDimNetCDF' - 1
    cellVariableNetCDF{indexVar}.standard_name = 'platform_yaw_fore_starboard';
    cellVariableNetCDF{indexVar}.long_name = 'Aircraft yaw, positive according to left-hand rule pointing upwards, perpendicular to flat sea level';
    cellVariableNetCDF{indexVar}.units = 'degrees';
    cellVariableNetCDF{indexVar}.valid_min = -360;
    cellVariableNetCDF{indexVar}.valid_max = +360;
    cellVariableNetCDF{indexVar}.FillValue = -999; % '_FillValue' is the standard name
    cellVariableNetCDF{indexVar}.DefVarChunking = lengthAzOutBlock; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
    % --- DoA image ---
    if netCDF_signBitFlag
        indexVar = indexVar + 1;
        cellVariableNetCDF{indexVar}.name = 'directionOfArrival';
        cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
        cellVariableNetCDF{indexVar}.dimid = [indexNumberOfDoAEstimationsDimensionGrid indexRadialDepthGridDimension indexProfileDimension]; % index of 'cellDimNetCDF' - 1
        cellVariableNetCDF{indexVar}.long_name = ['Index of the estimated absolute Direction of Arrival (DoA), from the aircraft body-fixed frame axis (tilled according to roll) point of view: '...
                                                'negative from starboard, zero from aircraft body-fixed axis, and positive from port'];
        cellVariableNetCDF{indexVar}.units = '-';
        cellVariableNetCDF{indexVar}.scale_factor = testAngleGridStep; % degrees
        cellVariableNetCDF{indexVar}.add_offset = 0; % degrees
        cellVariableNetCDF{indexVar}.FillValue = 2^8-1; % '_FillValue' is the standard name
        cellVariableNetCDF{indexVar}.DefVarChunking = [cellDimNetCDF{indexNumberOfDoAEstimationsDimensionGrid+1}.length cellDimNetCDF{indexRadialDepthGridDimension+1}.length lengthAzOutBlock]; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
        cellVariableNetCDF{indexVar}.DefVarDeflate = {true 9}; % compression with {shuffleFlag, deflateLevel(0:noComp -> 9:maxComp)}, with function 'netcdf.defVarDeflate'
    else
        indexVar = indexVar + 1;
        cellVariableNetCDF{indexVar}.name = 'directionOfArrival';
        cellVariableNetCDF{indexVar}.xtype = 'NC_SHORT';
        cellVariableNetCDF{indexVar}.dimid = [indexNumberOfDoAEstimationsDimensionGrid indexRadialDepthGridDimension indexProfileDimension]; % index of 'cellDimNetCDF' - 1
        cellVariableNetCDF{indexVar}.long_name = ['Estimated Direction of Arrival (DoA), from the aircraft body-fixed frame axis (tilled according to roll) point of view: '...
                                                'negative from starboard, zero from aircraft body-fixed axis, and positive from port'];
        cellVariableNetCDF{indexVar}.units = 'degrees';
        cellVariableNetCDF{indexVar}.scale_factor = testAngleGridStep; % degrees
        cellVariableNetCDF{indexVar}.add_offset = 0; % degrees
        cellVariableNetCDF{indexVar}.FillValue = -2^15; % '_FillValue' is the standard name
        cellVariableNetCDF{indexVar}.DefVarChunking = [cellDimNetCDF{indexNumberOfDoAEstimationsDimensionGrid+1}.length cellDimNetCDF{indexRadialDepthGridDimension+1}.length lengthAzOutBlock]; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
        cellVariableNetCDF{indexVar}.DefVarDeflate = {true 9}; % compression with {shuffleFlag, deflateLevel(0:noComp -> 9:maxComp)}, with function 'netcdf.defVarDeflate'
    end
    % --- Sign of DirectionOfArrival ---
    if netCDF_signBitFlag
        indexVar = indexVar + 1;
        cellVariableNetCDF{indexVar}.name = 'signDirectionOfArrival';
        cellVariableNetCDF{indexVar}.xtype = 'NC_UBYTE';
        cellVariableNetCDF{indexVar}.dimid = [indexNumberOfDoAEstimationsDimensionGrid indexRadialDepthGridDimension indexSignBitDimension]; % index of 'cellDimNetCDF' - 1
        cellVariableNetCDF{indexVar}.long_name = 'index of the estimated Direction of Arrival (DoA)';
        cellVariableNetCDF{indexVar}.FillValue = 2^8-1; % '_FillValue' is the standard name
        cellVariableNetCDF{indexVar}.DefVarChunking = [cellDimNetCDF{indexNumberOfDoAEstimationsDimensionGrid+1}.length cellDimNetCDF{indexRadialDepthGridDimension+1}.length lengthAzOutBlock/8]; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
        cellVariableNetCDF{indexVar}.DefVarDeflate = {true 9}; % compression with {shuffleFlag, deflateLevel(0:noComp -> 9:maxComp)}, with function 'netcdf.defVarDeflate'
    end
    % --- Amplitude level of the DoA ---
    if netCDF_amplitudeDoAFlag
        indexVar = indexVar + 1;
        cellVariableNetCDF{indexVar}.name = 'AmplitudeLevelDoA';
        cellVariableNetCDF{indexVar}.xtype = 'NC_FLOAT'; 
        cellVariableNetCDF{indexVar}.dimid = [indexNumberOfDoAEstimationsDimensionGrid indexRadialDepthGridDimension indexProfileDimension]; % index of 'cellDimNetCDF' - 1
        cellVariableNetCDF{indexVar}.long_name = 'Amplitude level of the estimated Direction of Arrival, within the fully estimated DoA beamwidth';
        cellVariableNetCDF{indexVar}.units = 'amplitude';
        cellVariableNetCDF{indexVar}.valid_min = 0;
        cellVariableNetCDF{indexVar}.FillValue = -1; % '_FillValue' is the standard name
        cellVariableNetCDF{indexVar}.DefVarChunking = [cellDimNetCDF{indexNumberOfDoAEstimationsDimensionGrid+1}.length cellDimNetCDF{indexRadialDepthGridDimension+1}.length lengthAzOutBlock]; % chunk size according to '.dimid', with function 'netcdf.defVarChunking'
        cellVariableNetCDF{indexVar}.DefVarDeflate = {true 9}; % compression with {shuffleFlag, deflateLevel(0:noComp -> 9:maxComp)}, with function 'netcdf.defVarDeflate'
    end
end
%--------------------------------------------------------------
% Input files
%--------------------------------------------------------------
input_folder_1617 = ['..' filesep 'FISS_1617' filesep 'SeasonCalibration'];
input_folder_1920 = ['..' filesep 'BEAMISH_1920' filesep 'SeasonCalibration'];
netCDF_1617F31_TxAllRxAll_calVarying = [input_folder_1617 filesep '2016_2017_Flight31_calVaryingRollPitchAP_TxAllRxAll.nc'];
netCDF_1617F30_TxPortRxAll_calVarying = [input_folder_1617 filesep '2016_2017_Flight30_calVaryingRollPitchAP_TxPortRxAll.nc'];
netCDF_1617F30_TxStarRxAll_calVarying = [input_folder_1617 filesep '2016_2017_Flight30_calVaryingRollPitchAP_TxStarRxAll.nc'];
netCDF_1920T18_TxPortRxAll_calVarying = [input_folder_1920 filesep '2019_2020_FlightT18_calVaryingRollPitchAP_TxPortRxAll.nc'];
netCDF_1920T18_TxStarRxAll_calVarying = [input_folder_1920 filesep '2019_2020_FlightT18_calVaryingRollPitchAP_TxStarRxAll.nc'];
%--------------------------------------------------------------
% Read variables
% From 'FISS_1617/SeasonCalibration/2016_2017_Flight31_calVaryingRollPitchAP_TxAllRxAll.nc':
%   Retrieve 'amplitude_1617F31TxP1234', natural units, 150 x 12
%   Retrieve 'roll_amplitude_1617F31TxP1234', degrees, 1 x 150
%   Retrieve 'amplitude_1617F31TxS9ABC', natural units, 150 x 12
%   Retrieve 'roll_amplitude_1617F31TxS9ABC', degrees, 1 x 150
%   Retrieve 'diffPhase_1617F31TxP1234', degrees, 52 x 11
%   Retrieve 'roll_diffPhase_1617F31TxP1234', degrees, 1 x 52
%   Retrieve 'phase_1617F31TxPort_reg_1617F31TxStar', degrees, 512 x 12
%   Retrieve 'roll_phase_1617F31TxPort_reg_1617F31TxStar', degrees, 1 x 512
% From 'FISS_1617/SeasonCalibration/2016_2017_Flight30_calVaryingRollPitchAP_TxPortRxAll.nc':
%   Retrieve 'amplitude_1617F30TxP1234', natural units, 200 x 12
%   Retrieve 'roll_amplitude_1617F30TxP1234', degrees, 1 x 200
%   Retrieve 'diffPhase_1617F30TxP1234', degrees, 53 x 3
%   Retrieve 'roll_diffPhase_1617F30TxP1234', degrees, 1 x 53
% From 'FISS_1617/SeasonCalibration/2016_2017_Flight30_calVaryingRollPitchAP_TxStarRxAll.nc':
%   Retrieve 'amplitude_1617F30TxS9ABC', natural units, 200 x 12
%   Retrieve 'roll_amplitude_1617F30TxS9ABC', degrees, 1 x 200
%   Retrieve 'diffPhase_1617F30TxS9ABC', degrees, 53 x 3
%   Retrieve 'roll_diffPhase_1617F30TxS9ABC', degrees, 1 x 53
%
% From 'BEAMISH_1920/SeasonCalibration/2019_2020_FlightT18_calVaryingRollPitchAP_TxPortRxAll.nc':
%   Retrieve 'diffPhase_1920T18TxP1234', degrees, 22 x 3
%   Retrieve 'roll_diffPhase_1920T18TxP1234', degrees, 1 x 22
% From 'BEAMISH_1920/SeasonCalibration/2019_2020_FlightT18_calVaryingRollPitchAP_TxStarRxAll.nc':
%   Retrieve 'diffPhase_1920T18TxS9ABC', degrees, 22 x 3
%   Retrieve 'roll_diffPhase_1920T18TxS9ABC', degrees, 1 x 22
%
%--------------------------------------------------------------
disp('%----------------------------------')
disp('% Read variables')
disp('%----------------------------------')
% Retrieve 'amplitude_1617F31TxP1234', natural units, 150 x 12
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'amplitude_1617F31TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
amplitude_1617F31TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'amplitude_1617F31TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_amplitude_1617F31TxP1234', degrees, 1 x 150
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_amplitude_1617F31TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_amplitude_1617F31TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_amplitude_1617F31TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'amplitude_1617F31TxS9ABC', natural units, 150 x 12
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'amplitude_1617F31TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
amplitude_1617F31TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'amplitude_1617F31TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_amplitude_1617F31TxS9ABC', degrees, 1 x 150
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_amplitude_1617F31TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_amplitude_1617F31TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_amplitude_1617F31TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'amplitude_1617F30TxP1234', natural units, 200 x 12
ncID = netcdf.open(netCDF_1617F30_TxPortRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'amplitude_1617F30TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
amplitude_1617F30TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'amplitude_1617F30TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_amplitude_1617F30TxP1234', degrees, 1 x 200
ncID = netcdf.open(netCDF_1617F30_TxPortRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_amplitude_1617F30TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_amplitude_1617F30TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_amplitude_1617F30TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'amplitude_1617F30TxS9ABC', natural units, 200 x 12
ncID = netcdf.open(netCDF_1617F30_TxStarRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'amplitude_1617F30TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
amplitude_1617F30TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'amplitude_1617F30TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_amplitude_1617F30TxS9ABC', degrees, 1 x 200
ncID = netcdf.open(netCDF_1617F30_TxStarRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_amplitude_1617F30TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_amplitude_1617F30TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_amplitude_1617F30TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);



% Retrieve 'diffPhase_1617F31TxP1234', degrees, 52 x 11
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'diffPhase_1617F31TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
diffPhase_1617F31TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'diffPhase_1617F31TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_diffPhase_1617F31TxP1234', degrees, 1 x 52
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_diffPhase_1617F31TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_diffPhase_1617F31TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_diffPhase_1617F31TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'phase_1617F31TxPort_reg_1617F31TxStar', degrees, 512 x 12
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'phase_1617F31TxPort_reg_1617F31TxStar'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
phase_1617F31TxPort_reg_1617F31TxStar = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'phase_1617F31TxPort_reg_1617F31TxStar'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_phase_1617F31TxPort_reg_1617F31TxStar', degrees, 1 x 512
ncID = netcdf.open(netCDF_1617F31_TxAllRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_phase_1617F31TxPort_reg_1617F31TxStar'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_phase_1617F31TxPort_reg_1617F31TxStar = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_phase_1617F31TxPort_reg_1617F31TxStar'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);



% Retrieve 'diffPhase_1617F30TxS9ABC', degrees, 53 x 3
ncID = netcdf.open(netCDF_1617F30_TxStarRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'diffPhase_1617F30TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
diffPhase_1617F30TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'diffPhase_1617F30TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_diffPhase_1617F30TxS9ABC', degrees, 1 x 53
ncID = netcdf.open(netCDF_1617F30_TxStarRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_diffPhase_1617F30TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_diffPhase_1617F30TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_diffPhase_1617F30TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'diffPhase_1920T18TxS9ABC', degrees, 22 x 3
ncID = netcdf.open(netCDF_1920T18_TxStarRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'diffPhase_1920T18TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
diffPhase_1920T18TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'diffPhase_1920T18TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_diffPhase_1920T18TxS9ABC', degrees, 1 x 22
ncID = netcdf.open(netCDF_1920T18_TxStarRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_diffPhase_1920T18TxS9ABC'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_diffPhase_1920T18TxS9ABC = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_diffPhase_1920T18TxS9ABC'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'diffPhase_1617F30TxP1234', degrees, 53 x 3
ncID = netcdf.open(netCDF_1617F30_TxPortRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'diffPhase_1617F30TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
diffPhase_1617F30TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'diffPhase_1617F30TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_diffPhase_1617F30TxP1234', degrees, 1 x 53
ncID = netcdf.open(netCDF_1617F30_TxPortRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_diffPhase_1617F30TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_diffPhase_1617F30TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_diffPhase_1617F30TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'diffPhase_1920T18TxP1234', degrees, 22 x 3
ncID = netcdf.open(netCDF_1920T18_TxPortRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'diffPhase_1920T18TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
diffPhase_1920T18TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'diffPhase_1920T18TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);
% Retrieve 'roll_diffPhase_1920T18TxP1234', degrees, 1 x 22
ncID = netcdf.open(netCDF_1920T18_TxPortRxAll_calVarying);
[varname,xtype,dimids,natts] = netcdf.inqVar(ncID,netcdf.inqVarID(ncID,'roll_diffPhase_1920T18TxP1234'));
fullLengths = zeros(1,length(dimids));
for k = 1:length(dimids)
    [dimname, dimLength] = netcdf.inqDim(ncID, dimids(k)); % unlimdimid = dimids(end)
    fullLengths(k) = dimLength;
end
roll_diffPhase_1920T18TxP1234 = netcdf.getVar(ncID, netcdf.inqVarID(ncID,'roll_diffPhase_1920T18TxP1234'), zeros(1,length(dimids)), fullLengths);
netcdf.close(ncID);



%--------------------------------------------------------------
% run scripts
%--------------------------------------------------------------

%--------------------------------------------------------------
% amplitude from surface echo Vs roll (from real data and simulations)
%--------------------------------------------------------------
% figure parameters
ampPatternFigureOriginCm = [18.00    4.00]; % (cm)
ampPatternFigureSizeCm =   [18.60   21.35]; % (cm)
ampPatternAxisOriginCm =   [ 2.00   12.80]; % (cm)
ampPatternAxisSizeCm =     [12.00    7.70]; % (cm) 
usedColors = 0.9*parula(12); % makes darker colours
% legend parameters
RxHHPolCell = {'(H)','(H)','(H)','(H)','(H)','(H)','(H)','(H)','(H)','(H)','(H)','(H)'};
RxVHPolCell = {'(V)','(V)','(V)','(V)','(H)','(H)','(H)','(H)','(H)','(H)','(H)','(H)'};
labelUsedReceiversPattern1617F30TxPS = {'RxP1','RxP2','RxP3','RxP4','RxB5','RxB6','RxB7','RxB8','RxS9','RxSA','RxSB','RxSC'};
labelUsedReceiversPattern1617F31TxPS = {'RxP1','RxP2','RxP3','RxP4','RxB5','RxB6','RxB7','RxB8','RxS9','RxSA','RxSB','RxSC'};
labelDiffReceivers1617F31TxPS = {'RxP2-RxP1','RxP3-RxP2','RxP4-RxP3','RxB5-RxP4','RxB6-RxB5','RxB7-RxB6','RxB8-RxB7','RxS9-RxB8','RxSA-RxS9','RxSB-RxSA','RxSC-RxSB'}.';
labelSetsTXPattern1617F30TxPS = {'TxP1234\_C13L4','TxS9ABC\_C13L4'}.';
labelSetsTXPattern1617F31TxPS = {'TxP1234\_C13L4','TxS9ABC\_C13L4'}.';
stringsOfSetPattern1617F31TxPS = {'TxP1234', 'C13L4'; 'TxS9ABC', 'C13L4'};
stringsOfSetPattern1617F30TxPS = {'TxP1234', 'C13L4'; 'TxS9ABC', 'C13L4'};
labelSetsTX1617F31TxPS = {'TxP1234\_C13L4','TxP1234\_C13L1','TxS9ABC\_C13L4'}.';
labelSetsTX1617F30TxS = {'TxS9ABC\_C13L4'};
labelSetsTX1617F30TxP = {'TxP1234\_C13L4'};
labelFlight1617F31TxPS = 'F31';
seasonFlight1617F31TxPS = '16/17';
seasonFlight1617F30TxPS = '16/17';
numberOfSetsPattern1617F30TxPS = 2;
numberOfReceivers1617F30TxPS = 12;
numberOfSetsPattern1617F31TxPS = 2;
numberOfReceivers1617F31TxPS = 12;
nsw1617F31TxPS = [1;2];
refSetPattern1617F31TxPS = 2;
refSetPattern1617F30TxPS = 2;
refSet1617F31TxPS = 3;
TxPortNonPolLegendCell = strcat({'Tx(H)-'}, labelUsedReceiversPattern1617F31TxPS, RxHHPolCell);
TxPortPolLegendCell = strcat({'Tx(V)-'}, labelUsedReceiversPattern1617F30TxPS, RxVHPolCell);
TxStarNonPolLegendCell = strcat({'Tx(H)-'}, labelUsedReceiversPattern1617F31TxPS, RxHHPolCell);
TxStarPolLegendCell = strcat({'Tx(H)-'}, labelUsedReceiversPattern1617F30TxPS, RxVHPolCell);
TxPortRxDiffNonPolLegendCell = strcat({'Tx(H)-'}, labelDiffReceivers1617F31TxPS.', RxHHPolCell(1:end-1));
TxPortRxDiffPolLegendCell = strcat({'Tx(V)-'}, labelDiffReceivers1617F31TxPS.', RxVHPolCell(1:end-1));
TxStarRxDiffNonPolLegendCell = strcat({'Tx(H)-'}, labelDiffReceivers1617F31TxPS.', RxHHPolCell(1:end-1));
TxStarRxDiffPolLegendCell = strcat({'Tx(H)-'}, labelDiffReceivers1617F31TxPS.', RxVHPolCell(1:end-1));
TxStar1617F30RxDiffNonPolLegendCell = strcat({'16/17-F30, '}, labelDiffReceivers1617F31TxPS.', RxHHPolCell(1:end-1));
TxStar1920T18RxDiffNonPolLegendCell = strcat({'19/20-T18, '}, labelDiffReceivers1617F31TxPS.', RxHHPolCell(1:end-1));
TxPort1617F30RxDiffNonPolLegendCell = strcat({'16/17-F30, '}, labelDiffReceivers1617F31TxPS.', RxVHPolCell(1:end-1));
TxPort1920T18RxDiffNonPolLegendCell = strcat({'19/20-T18, '}, labelDiffReceivers1617F31TxPS.', RxVHPolCell(1:end-1));
%--------------------------------------------------------------
% Displaying parameters
%--------------------------------------------------------------
% results subsampling
subSampAmp = 50;
subSampPhase = 10;
%--------------------------------------------------------------
%
%
% ----------------- AMPLITUDE ANTENNA PATTERNS ----------------
%
%
%--------------------------------------------------------------
ampPatternFig=figure; set(gcf,'Color','w','Units','centimeters','Position',[ampPatternFigureOriginCm ampPatternFigureSizeCm]),
%--------------------------------------------------------------
% 1617F31, TxP(H), TxS(H)
% amplitude from surface echo Vs roll (from real data and simulations)
%--------------------------------------------------------------
% amplitude and phase calibration
% simulated patterns with amplitude from breakthrough pulses and assuming constant phases
lambda = 2; % (m)
d = 0.8*lambda; % (m)
alpha = -40:0.01:40; % (deg)
nn = [0:3]';
sigmaWing = 3.5; % (deg)
weightsUniform = ones(size(nn));
weightsBreakthroughPortHError = weightsUniform.*(10.^([91 97 91 92].'/20)); % [90.9 96.7 90.6 92.3]; [91 97 91 92], different in F30 because now is TxH
weightsBreakthroughStarHError = weightsUniform.*(10.^([82 91 93 91].'/20)); % [82.5 91.2 93.6 91.7]; [82 91 93 91], the same as in F30
switch stringsOfSetPattern1617F31TxPS{nsw1617F31TxPS(refSetPattern1617F31TxPS),1}(3)
    case 'P'
        weightsBreakthroughGlobalNormError = weightsBreakthroughPortHError;
    case 'S'
        weightsBreakthroughGlobalNormError = weightsBreakthroughStarHError;
end
% figure loop
plotLineWidth = 3*ones(numberOfSetsPattern1617F31TxPS,numberOfReceivers1617F31TxPS);
for ns = 1:numberOfSetsPattern1617F31TxPS
    % CST simulations
    TXOfSet = stringsOfSetPattern1617F31TxPS{nsw1617F31TxPS(ns),1};
    switch TXOfSet(3) % TXP, TXS
        case 'P'
            cellOutput = CSTreadAscii('PortPattern.txt', 'units', ']');
            breakthroughPattern31{ns} = abs(sum(repmat(weightsBreakthroughPortHError/sum(weightsBreakthroughPortHError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha - sigmaWing))));
            breakthroughPatternNorm31{ns} = abs(sum(repmat(weightsBreakthroughPortHError/sum(weightsBreakthroughGlobalNormError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha - sigmaWing))));
        case 'S'
            cellOutput = CSTreadAscii('StarboardPattern.txt', 'units', ']');
            breakthroughPattern31{ns} = abs(sum(repmat(weightsBreakthroughStarHError/sum(weightsBreakthroughStarHError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha + sigmaWing))));
            breakthroughPatternNorm31{ns} = abs(sum(repmat(weightsBreakthroughStarHError/sum(weightsBreakthroughGlobalNormError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha + sigmaWing))));
        otherwise
            error('')
    end
    elevation0NadirNegativePort = [cellOutput{1}(1:181,1); 360-cellOutput{1}(182:end,1)] - 180;
    CSTamplitudedB = cellOutput{1}(:,3);
    % real data, amplitude error compensated
    figure(ampPatternFig);
    axAmpPattern(2,ns)=subplot(numberOfSetsPattern1617F31TxPS,1,ns);
    hold on, set(gca, 'Units','centimeters','Position',[ampPatternAxisOriginCm-[0 (ns-1)*11.1] ampPatternAxisSizeCm])
    plot(-elevation0NadirNegativePort, CSTamplitudedB-max(CSTamplitudedB),'-.k','LineWidth',3),grid on
    plot(alpha, 20*log10(breakthroughPatternNorm31{ns}),'--k','LineWidth',2)
    if ns==1, plot(0, -100,'--k','LineWidth',3); end % fake a plot for a proper legend including F30-TxPort
    set(gca, 'ColorOrderIndex', 1, 'LineStyleOrderIndex', 1, 'ColorOrder', usedColors,'LineStyleOrder','-|:','NextPlot', 'replacechildren')
    hold on
    switch TXOfSet(3) % TXP, TXS
        case 'P'
            p = plot(-roll_amplitude_1617F31TxP1234, amplitude_1617F31TxP1234); grid on,
        case 'S'
            p = plot(-roll_amplitude_1617F31TxS9ABC, amplitude_1617F31TxS9ABC); grid on,
    end
    for RX = 1:numberOfReceivers1617F31TxPS
        p(RX).LineWidth = plotLineWidth(ns,RX);
        %p(RX).Marker = plotMarkers{1+mod(RX-1,numberOfReceivers)};
    end
    %plot(-elevation0NadirNegativePort, CSTamplitudedB-max(CSTamplitudedB),'-k','LineWidth',2),grid on
    %plot(alpha, 20*log10(breakthroughPatternNorm),'k:','LineWidth',4)
    xlabel('Elevation (deg) (origin in nadir, positive portwards)'),ylabel('Amplitude (dB)'),
    title([seasonFlight1617F31TxPS '. ' labelSetsTXPattern1617F31TxPS{nsw1617F31TxPS(ns)} ' across-track pattern']),
    xlim([-40 40]), ylim([-33 5]), set(gca,'FontSize',16,'GridAlpha',0.3,'XDir','reverse')
    %if ns==1 legend({'sim.','array factor',labelUsedReceiversPattern1617F31TxPS{:}}); end
end
%--------------------------------------------------------------
% 1617F30, TxP(V), TxS(H)
% amplitude from surface echo Vs roll (from real data and simulations)
%--------------------------------------------------------------
% amplitude and phase calibration
% simulated patterns with amplitude from breakthrough pulses and assuming constant phases
lambda = 2; % (m)
d = 0.8*lambda; % (m)
alpha = -40:0.01:40; % (deg)
nn = [0:3]';
sigmaWing = 3.5; % (deg)
weightsUniform = ones(size(nn));
weightsBreakthroughPortVError = weightsUniform.*(10.^([88 97 86 89].'/20)); % [88.7 97.5 86.3 90.0]; [89 97 86 90], different in F31, because now is TxV
weightsBreakthroughStarHError = weightsUniform.*(10.^([82 91 93 91].'/20)); % [82.5 91.2 93.6 91.7]; [82 91 93 91], the same as in F31
switch stringsOfSetPattern1617F30TxPS{nsw1617F31TxPS(refSetPattern1617F30TxPS),1}(3)
    case 'P'
        weightsBreakthroughGlobalNormError = weightsBreakthroughPortVError;
    case 'S'
        weightsBreakthroughGlobalNormError = weightsBreakthroughStarHError;
end
%ampForGlobalNormalising = max(abs(peakSurfaceCorrAmp(:)));
% % figure loop
% ampPatternFig(1)=figure; set(gcf,'Color','w'),%set(gcf,'Units','centimeters','Position',[ampPatternFigureOriginCm ampPatternFigureSizeCm]),
% ampPatternFig(2)=figure; set(gcf,'Color','w'),%set(gcf,'Units','centimeters','Position',[ampPatternFigureOriginCm ampPatternFigureSizeCm]),
plotLineWidth = [2*ones(1,4) 3*ones(1,8); 3*ones(1,4) 2*ones(1,8)];
for ns = 1:numberOfSetsPattern1617F30TxPS
    % CST simulations
    TXOfSet = stringsOfSetPattern1617F30TxPS{nsw1617F31TxPS(ns),1};
    switch TXOfSet(3) % TXP, TXS
        case 'P'
            cellOutput = CSTreadAscii('PortPattern.txt', 'units', ']');
            breakthroughPattern30{ns} = abs(sum(repmat(weightsBreakthroughPortVError/sum(weightsBreakthroughPortVError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha - sigmaWing))));
            breakthroughPatternNorm30{ns} = abs(sum(repmat(weightsBreakthroughPortVError/sum(weightsBreakthroughGlobalNormError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha - sigmaWing))));
        case 'S'
            cellOutput = CSTreadAscii('StarboardPattern.txt', 'units', ']');
            breakthroughPattern30{ns} = abs(sum(repmat(weightsBreakthroughStarHError/sum(weightsBreakthroughStarHError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha + sigmaWing))));
            breakthroughPatternNorm30{ns} = abs(sum(repmat(weightsBreakthroughStarHError/sum(weightsBreakthroughGlobalNormError),[1 length(alpha)]).*exp(-1j*2*pi*d/lambda*nn*sind(alpha + sigmaWing))));
        otherwise
            error('')
    end
    elevation0NadirNegativePort = [cellOutput{1}(1:181,1); 360-cellOutput{1}(182:end,1)] - 180;
    CSTamplitudedB = cellOutput{1}(:,3);
    % real data, amplitude error compensated
    figure(ampPatternFig);
    axes(axAmpPattern(2,ns)); hold on,
    %subplot(numberOfSetsPattern1617F30TxPS,1,ns), %set(gca, 'Units','centimeters','Position',[ampPatternAxisOriginCm-[0 (ns-1)*8.3546] ampPatternAxisSizeCm])
    %plot(-elevation0NadirNegativePort, CSTamplitudedB-max(CSTamplitudedB),'-k','LineWidth',2),grid on
    set(gca, 'ColorOrderIndex', 1, 'LineStyleOrderIndex', 1, 'ColorOrder', usedColors,'LineStyleOrder',':','NextPlot', 'replacechildren')
    hold on,
    switch TXOfSet(3) % TXP, TXS
        case 'P'
            p = plot(-roll_amplitude_1617F30TxP1234, amplitude_1617F30TxP1234); grid on,
        case 'S'
            p = plot(-roll_amplitude_1617F30TxS9ABC, amplitude_1617F30TxS9ABC); grid on,
    end
    for RX = 1:numberOfReceivers1617F30TxPS
        p(RX).LineWidth = plotLineWidth(ns,RX);
        %p(RX).Marker = plotMarkers{1+mod(RX-1,numberOfReceivers)};
    end
    plot(-elevation0NadirNegativePort, CSTamplitudedB-max(CSTamplitudedB),'-.k','LineWidth',3),grid on
    plot(alpha, 20*log10(breakthroughPatternNorm31{ns}),'--k','LineWidth',2)
    if ns==1, plot(alpha, 20*log10(breakthroughPatternNorm30{ns}),'--k','LineWidth',3); end % the same style as in the fake plot fo F31
    xlabel('Elevation (\circ) (origin in nadir, positive portwards)'),ylabel('Amplitude (dB)'),
    title([seasonFlight1617F30TxPS '. ' labelSetsTXPattern1617F30TxPS{nsw1617F31TxPS(ns)} ' across-track pattern']),
    xlim([-40 40]), ylim([-33 5]), set(gca,'FontSize',16,'GridAlpha',0.3,'XDir','reverse')
    if ns==1 amp2TxPortLegend = legend({'sim. Tx(H)','coupled Tx(H)','coupled Tx(V)',TxPortNonPolLegendCell{:},TxPortPolLegendCell{:}},'Fontsize',8,'Units','centimeters','Position',[14.56 11.85 3.41 9.38]); end
    if ns==2 amp2TxStarLegend = legend({'sim. Tx(H)','coupled Tx(H)',                TxStarNonPolLegendCell{:},TxStarPolLegendCell{:}},'Fontsize',8,'Units','centimeters','Position',[14.56  0.75 3.41 9.38]); end
end
%--------------------------------------------------------------
%
%
% ------------------- PHASE ANTENNA PATTERNS ------------------
%
%
%--------------------------------------------------------------
%--------------------------------------------------------------
% 1617F31, TxP(H), TxS(H)
% Adjust phases of coeffsDOA due to calibration phase errors depending on roll angles
%--------------------------------------------------------------
ns = 1;
plotLineWidth = [2 2 2 5 2 3 2 5 2 2 2];
plotLineStyle = {'-','-','-','-','-','-','-',':','--','--','--',};
plotLineMarker = {'none','o','+','none','>','none','s','none','+','o','none'};
plotLineColor = {[0 0 1], [0 0 1], [0 0 1], [0 0 0], [1 0 1], [0.3 0.9 0.6], [1 0 1], [0 0 0], [1 0 0], [1 0 0], [1 0 0]};
phasePatternFig(1)=figure; set(gcf,'Color','w','Units','centimeters','Position',[ampPatternFigureOriginCm ampPatternFigureSizeCm]),
% Phase for receivers
% polynomial interpolation of 'phaseErrorRXRolVarAux'
usedColorsDiff = 0.9*jet(size(diffPhase_1617F31TxP1234,2)); % makes darker colours
figure(phasePatternFig(1));
axPhasePattern(1,1)=subplot(2,1,1);
set(gca, 'Units','centimeters','Position',[ampPatternAxisOriginCm ampPatternAxisSizeCm-[0 0.7]])
set(gca, 'ColorOrder', usedColorsDiff,'LineStyleOrder','-','NextPlot', 'replacechildren')
hold on,
p = plot(-roll_diffPhase_1617F31TxP1234, diffPhase_1617F31TxP1234); grid on,
for diffRX = 1:size(diffPhase_1617F31TxP1234,2)
    p(diffRX).LineWidth = plotLineWidth(diffRX);
    p(diffRX).LineStyle = plotLineStyle{diffRX};
    p(diffRX).Marker = plotLineMarker{diffRX};
    p(diffRX).Color = plotLineColor{diffRX};
end
grid on,xlabel('Elevation (\circ) (origin in nadir, positive portwards)'),set(gca,'FontSize',16,'GridAlpha',0.3,'XDir','reverse')
ylabel('Error(\circ)'),xlim(max(abs(roll_diffPhase_1617F31TxP1234))*[-1 1]),ylim([-22 22]),
title([seasonFlight1617F31TxPS '-' labelFlight1617F31TxPS ', ' labelSetsTX1617F31TxPS{ns} '. Residual phase error' newline 'between consecutive receivers'])
phaseTxStarLegend = legend({TxPortRxDiffNonPolLegendCell{:}},'Fontsize',8,'Units','centimeters','Position',[14.15 15.43 4.23 5.10]);
% Phase for transmitter
figure(phasePatternFig(1));
axPhasePattern(1,2)=subplot(2,1,2);
plotLineWidth = 3*[1 1 1 1];
numberOfWidth = length(plotLineWidth);
hold on, set(gca, 'Units','centimeters','Position',[ampPatternAxisOriginCm-[0 11.1] ampPatternAxisSizeCm-[0 0.7]])
set(gca, 'ColorOrder', usedColors,'LineStyleOrder','-','NextPlot', 'replacechildren')
hold on,
p = plot(-roll_phase_1617F31TxPort_reg_1617F31TxStar, phase_1617F31TxPort_reg_1617F31TxStar); grid on, % (deg)
for RX = 1:numberOfReceivers1617F31TxPS
    p(RX).LineWidth = plotLineWidth(1+mod(RX-1,numberOfWidth));
end
xlabel('Elevation (\circ) (origin in nadir, positive portwards)'),ylabel('Error(\circ)'), set(gca,'FontSize',16,'GridAlpha',0.3,'XDir','reverse'),ylim([-180.01 180.01]),yticks(-180:90:180)
xlim(max(abs(roll_phase_1617F31TxPort_reg_1617F31TxStar))*[-1 1]),
title([seasonFlight1617F31TxPS '-' labelFlight1617F31TxPS ', ' labelSetsTX1617F31TxPS{ns} '. Residual phase error' newline 'relative to ' labelSetsTX1617F31TxPS{refSet1617F31TxPS}])
phaseTxPortLegend = legend(TxPortNonPolLegendCell{:},'Fontsize',8,'Units','centimeters','Position',[14.15 5.05 3.41 4.38]);
%--------------------------------------------------------------
%
%
% ------------------- PHASE ANTENNA PATTERNS ------------------
%
%
%--------------------------------------------------------------
%--------------------------------------------------------------
% 1617F30, TxP(V), TxS(H)
% 1920T18, TxP(V), TxS(H)
% Adjust phases of coeffsDOA due to calibration phase errors depending on roll angles
%--------------------------------------------------------------
plotLineWidthStar = [2 2 2 2 2 2];
plotLineStyleStar = {'-.','-.','-.','-','-','-'};
plotLineMarkerStar = {'+','o','none','+','o','none'};
plotLineColorStar = {[1 0 0], [1 0 0], [1 0 0], [0.5 0.5 0.5], [0.5 0.5 0.5], [0.5 0.5 0.5]};
plotLineWidthPort = [2 2 2 2 2 2];
plotLineStylePort = {'-.','-.','-.','-','-','-'};
plotLineMarkerPort = {'none','o','+','none','o','+'};
plotLineColorPort = {[0 0 1], [0 0 1], [0 0 1], [0.47 0.67 0.19], [0.47 0.67 0.19], [0.47 0.67 0.19]};
phasePatternFig(2)=figure; set(gcf,'Color','w','Units','centimeters','Position',[ampPatternFigureOriginCm ampPatternFigureSizeCm]),
figure(phasePatternFig(2));
axPhasePattern(2,1)=subplot(2,1,1);
set(gca, 'Units','centimeters','Position',[ampPatternAxisOriginCm ampPatternAxisSizeCm-[0 0.7]])
% set(gca, 'ColorOrder', usedColorsDiff,'LineStyleOrder','-','NextPlot', 'replacechildren')
hold on,
p1617F30TxS = plot(-roll_diffPhase_1617F30TxS9ABC, diffPhase_1617F30TxS9ABC); grid on,
for diffRX = 1:length(p1617F30TxS)
    p1617F30TxS(diffRX).LineWidth = plotLineWidthStar(diffRX);
    p1617F30TxS(diffRX).LineStyle = plotLineStyleStar{diffRX};
    p1617F30TxS(diffRX).Marker =    plotLineMarkerStar{diffRX};
    p1617F30TxS(diffRX).Color =     plotLineColorStar{diffRX};
end
p1920T18TxS = plot(-roll_diffPhase_1920T18TxS9ABC, diffPhase_1920T18TxS9ABC); grid on,
for diffRX = 1:length(p1920T18TxS)
    p1920T18TxS(diffRX).LineWidth = plotLineWidthStar(length(p1617F30TxS) + diffRX);
    p1920T18TxS(diffRX).LineStyle = plotLineStyleStar{length(p1617F30TxS) + diffRX};
    p1920T18TxS(diffRX).Marker =    plotLineMarkerStar{length(p1617F30TxS)+ diffRX};
    p1920T18TxS(diffRX).Color =     plotLineColorStar{length(p1617F30TxS) + diffRX};
end
ns = 1;
grid on,xlabel('Elevation (\circ) (origin in nadir, positive portwards)'),set(gca,'FontSize',16,'GridAlpha',0.3,'XDir','reverse')
ylabel('Error(\circ)'),xlim(max(abs(roll_diffPhase_1617F30TxS9ABC))*[-1 1]),ylim([-22 22]),yticks(-20:10:20)
title([labelSetsTX1617F30TxS{ns} '(H). Residual phase error' newline 'between consecutive receivers'])
phaseTxStarRxStarLegend = legend({TxStar1617F30RxDiffNonPolLegendCell{9:11}, TxStar1920T18RxDiffNonPolLegendCell{9:11}},'Fontsize',8,'Units','centimeters','Position',[10.92 17.72 4.90 2.24]);
figure(phasePatternFig(2));
axPhasePattern(2,2)=subplot(2,1,2);
set(gca, 'Units','centimeters','Position',[ampPatternAxisOriginCm-[0 11.1] ampPatternAxisSizeCm-[0 0.7]])
% set(gca, 'ColorOrder', usedColorsDiff,'LineStyleOrder','-','NextPlot', 'replacechildren')
hold on,
p1617F30TxP = plot(-roll_diffPhase_1617F30TxP1234, diffPhase_1617F30TxP1234); grid on,
for diffRX = 1:length(p1617F30TxP)
    p1617F30TxP(diffRX).LineWidth = plotLineWidthPort(diffRX);
    p1617F30TxP(diffRX).LineStyle = plotLineStylePort{diffRX};
    p1617F30TxP(diffRX).Marker =    plotLineMarkerPort{diffRX};
    p1617F30TxP(diffRX).Color =     plotLineColorPort{diffRX};
end
p1920T18TxP = plot(-roll_diffPhase_1920T18TxP1234, diffPhase_1920T18TxP1234); grid on,
for diffRX = 1:length(p1920T18TxP)
    p1920T18TxP(diffRX).LineWidth = plotLineWidthPort(length(p1617F30TxP) + diffRX);
    p1920T18TxP(diffRX).LineStyle = plotLineStylePort{length(p1617F30TxP) + diffRX};
    p1920T18TxP(diffRX).Marker =    plotLineMarkerPort{length(p1617F30TxP)+ diffRX};
    p1920T18TxP(diffRX).Color =     plotLineColorPort{length(p1617F30TxP) + diffRX};
end
ns = 1;
grid on,xlabel('Elevation (\circ) (origin in nadir, positive portwards)'),set(gca,'FontSize',16,'GridAlpha',0.3,'XDir','reverse')
ylabel('Error(\circ)'),xlim(max(abs(roll_diffPhase_1617F30TxP1234))*[-1 1]),ylim([-35 35]),yticks(-30:10:30)
title([labelSetsTX1617F30TxP{ns} '(V). Residual phase error' newline 'between consecutive receivers'])
phaseTxPortRxPortLegend = legend({TxPort1617F30RxDiffNonPolLegendCell{1:3}, TxPort1920T18RxDiffNonPolLegendCell{1:3}},'Fontsize',8,'Units','centimeters','Position',[10.92 6.62 4.90 2.24]);
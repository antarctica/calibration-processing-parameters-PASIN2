Matlab script "scriptAllResults_from_netCDF.m" to generate plots with the antenna patterns (amplitude and phase) for calibrating the British Antarctic Survey (BAS)
airborne radar PASIN2 (Polarimetric Airborne Scientific INstrument, mark 2). PASIN2 is designed for deep ice-sounding. It is a 150MHz pulsed airborne SAR
(Synthetic Aperture Radar), with 12 antennas: 4 below port wing, 4 below the fuselage (belly), and 4 below starboard wing. Wing antennas can transmit and receive,
and belly antennas are receiver-only. The antenna patterns were measured in calibration flights above the sea surface near the British facility Rothera Research
Station, in Adelaide Island, Antarctic Peninsula.

The data read by the script are within netCDF ('.nc') and text ('.txt') files archived and managed by the UK Polar Data Centre (UK PDC):

The script runs the function "CSTreadAscii.m", for reading the simulated antenna patterns from files "Antenna_patterns\PortPattern.txt" and "Antenna_patterns\StarboardPattern.txt".

The plots generated correspond to the figures in an article (yet to be submitted):
Arenas-Pingarron, A., Corr, H., Robinson, C., Jordan, T., Brennan, P.V.: ‘PASIN2, an Ice-Sounding Airborne Synthetic Aperture Radar for Subglacial 3D Imagery’, IET Radar, Sonar & Navigation.

The plots generated are in the images ('.tif') archived by the UK Polar Data Centre (UK PDC)
-------------- Data DOI to be added --------------
and are described as:
- Antenna_patterns\AcrossTrackAmpPatterns_v1.tif: (image) with the amplitude antenna-patterns, for HH, VV, HV and VH from the calibration flights F31 and F30 of season 2016/2017.
	(top) Port transmitter, with HH (flight F31), VV and VH (flight F30), and simululated patterns.
	(bottom) Starboard transmitter, with HH (flight F31), HV and HH (flight F30), and simululated patterns.
	Image generated from calibration data in the netCDF '.nc' files:
		'FISS_1617\SeasonCalibration\2016_2017_Flight30_calVaryingRollPitchAP_TxPortRxAll.nc',
		'FISS_1617\SeasonCalibration\2016_2017_Flight30_calVaryingRollPitchAP_TxStarRxAll.nc',
		'FISS_1617\SeasonCalibration\2016_2017_Flight31_calVaryingRollPitchAP_TxAllRxAll.nc',
	and simulated patterns from 'PortPattern.txt' and 'StarboardPattern.txt'
- Antenna_patterns\AcrossTrackPhasePatterns_1_v1.tif: (image) with the phase antenna-patterns for HH from the calibration flight F31 of season 2016/2017.
	(top) the differential phase from each receiver (H) regarding the previous (e.g. P2-P1, P3-P2, ..., SC-SB), transmitting from port (H).
	(bottom) the differential phase when transmitting from port (H) regarding transmitting from starboard (H), for each of the receivers (H).
	Image generated from calibration data in the netCDF '.nc' file:
		'FISS_1617\SeasonCalibration\2016_2017_Flight31_calVaryingRollPitchAP_TxAllRxAll.nc'.
- Antenna_patterns\AcrossTrackPhasePatterns_2_v1.tif: (image) with the phase antenna-patterns for HH and VV to compare results of seasons 2016/2017 and 2019/2020.
	(top) the differential phase from each starboard receiver (H) regarding the previous (SA-S9, SB-SA, SC-SB), transmitting from starboard (H), for 2016/2017 (fligth F30) and 2019/2020 (T18).
	(bottom) the differential phase from each port receiver (V) regarding the previous (P2-P1, P3-P2, P4-P3), transmitting from port (V), for 2016/2017 (fligth F30) and 2019/2020 (T18).
	Image generated from calibration data in the netCDF '.nc' files:
		'FISS_1617\SeasonCalibration\2016_2017_Flight30_calVaryingRollPitchAP_TxPortRxAll.nc',
		'FISS_1617\SeasonCalibration\2016_2017_Flight30_calVaryingRollPitchAP_TxStarRxAll.nc',
		'BEAMISH_1920\SeasonCalibration\2019_2020_FlightT18_calVaryingRollPitchAP_TxPortRxAll.nc',
		'BEAMISH_1920\SeasonCalibration\2019_2020_FlightT18_calVaryingRollPitchAP_TxStarRxAll.nc'.
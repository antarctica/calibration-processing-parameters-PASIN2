calibration-processing-parameters-PASIN2

SCOPE
The repository contains Matlab scripts for generating calibration plots, and processing parameters for the British
Antarctic Survey (BAS) ice-sounding airborne Synthetic Aperture Radar (SAR) PASIN2 (Polarimetric Airborne Scientific
INstrument, mark 2). PASIN2 is an active 150MHz pulsed airborne SAR (Synthetic Aperture Radar) for shallow ice and
deep subglacial 3D-imagery, by a non-uniform antenna array of 12 dipoles switching between transmisssion and reception.
The calibration plots and the SAR and derived products, correspond to the article (yet to be submitted):
Arenas-Pingarron, A., Corr, H., Robinson, C., Jordan, T., Brennan, P.V.: ‘PASIN2, an Ice-Sounding Airborne Synthetic Aperture Radar for Subglacial 3D Imagery’, IET Radar, Sonar & Navigation.

The calibration data and the SAR and derived products generated from these parameter files ('.m') are, respectively,
in images ('.tif') and netCDF files ('.nc') archived by the UK Polar Data Centre (UK PDC)
-------------- Data DOI to be added --------------


OBJECTIVES
The users can:	
1.	Generate plots with the antenna patterns (amplitude and phase) for calibrating PASIN2. The antenna patterns
	(archived by the UK PDC) were measured in calibration flights above the sea surface near the British facility
	Rothera Research Station, in Adelaide Island, Antarctic Peninsula.
2.	Read the processing parameter files related to each data product (archived by the UK PDC).


OUTCOMES
The users will:
1.	Recognise how the SAR images and other derived products were processed from the parameter files.
2.	Identify the data referenced in the article (yet to be submitted), by relating the data archived by the UK PDC
	to the processing parameter files, and by generating the calibration plots.


CONTENT:
- Antenna_patterns: Matlab script and function ('.m') to generate plots with the antenna patterns (amplitude and phase)
	for calibrating PASIN2.
- FISS_1617: Parameter files in Matlab language ('.m') to process SAR images and derived products.
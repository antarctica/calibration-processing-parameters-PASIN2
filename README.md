# calibration-processing-parameters-PASIN2
Matlab scripts for generating calibration plots, and processing parameters for the British Antarctic Survey (BAS) ice-sounding airborne Synthetic Aperture Radar (SAR) PASIN2 (Polarimetric Airborne Scientific INstrument, mark 2).

## Scope
The repository contains Matlab scripts for generating calibration plots, and processing parameters for the [British Antarctic Survey](https://www.bas.ac.uk) (BAS) ice-sounding airborne Synthetic Aperture Radar (SAR) PASIN2 (Polarimetric Airborne Scientific INstrument, mark 2). PASIN2 is an active 150MHz pulsed airborne SAR (Synthetic Aperture Radar) for shallow ice and deep subglacial 3D-imagery, by a non-uniform antenna array of 12 dipoles switching between transmisssion and reception. The calibration plots and the SAR and derived products, correspond to the article:

Arenas-Pingarrón, Á., Corr, H., Robinson, C., Jordan, T., Brennan, P.V.: Polarimetric airborne scientific instrument, mark 2, an ice-sounding airborne synthetic aperture radar for subglacial 3D imagery. IET Radar Sonar Navig. 1– 14 (2023). https://doi.org/10.1049/rsn2.12428

The calibration data and the SAR and derived products generated from these parameter files ('.m') are, respectively, in images ('.tif') and [netCDF](https://www.unidata.ucar.edu/software/netcdf/) files ('.nc') archived by the [UK Polar Data Centre](https://www.bas.ac.uk/data/uk-pdc/) (UK PDC):

Arenas Pingarron, A., Corr, H., Jordan, T., Robinson, C., Nicholls, K., & Smith, A. (2023). Airborne synthetic aperture radar ice-sounding depth profiles from Recovery Ice Stream 2016/17, and calibration data from Rothera 2016/17 and 2019/20 (Version 1.0) [Data set]. NERC EDS UK Polar Data Centre. https://doi.org/10.5285/faac4156-047d-47ba-9e31-1a4f766bfdf8


## Objectives
The users can:	
1.	Generate plots with the antenna patterns (amplitude and phase) for calibrating PASIN2. The antenna patterns (archived by the UK PDC) were measured in calibration flights above the sea surface near the British facility Rothera Research Station, in Adelaide Island, Antarctic Peninsula.
2.	Read the processing parameter files related to each data product (archived by the UK PDC).


## Outcomes
The users will:
1.	Recognise how the SAR images and other derived products were processed from the parameter files.
2.	Identify the data referenced in the article (yet to be submitted), by relating the data archived by the UK PDC to the processing parameter files, and by generating the calibration plots.


## Content:
- Antenna_patterns: Matlab script and function ('.m') to generate plots with the antenna patterns (amplitude and phase) for calibrating PASIN2.
- FISS_1617: Parameter files in Matlab language ('.m') to process SAR images and derived products.


## LICENSE

MIT license (https://github.com/antarctica/calibration-processing-parameters-PASIN2/blob/main/LICENSE)

Parameter files in Matlab language files ('.m') to process radar images and derived products from the British
Antarctic Survey (BAS) airborne radar PASIN2 (Polarimetric Airborne Scientific INstrument, mark 2). PASIN2 is 
a 150MHz pulsed airborne SAR (Synthetic Aperture Radar), with 12 antennas: 4 below port wing, 4 below the
fuselage (belly), and 4 below starboard wing. Wing antennas can transmit and receive, and belly antennas
are receiver-only. In transmission, the 4 antennas below each wing are driven simultaneously, effectively
acting as an array, and hence two array transmitters are considering: one from port, other from starboard.
A SAR image from any combination of transmitter/receivers will inform about the depth profile along the
trajectory of the aircraft, from the shallow and deep internal layers to the glaciar bottom, either
bedrock (ice sheets and ice streams) or ice/water interface (ice shelves). However, the depth profile
can be incorrectly interpreted, as the antenna radiation pattern is wide in the across-track plane
(perpendicular to the aircraft trajectory), and thus the echoes from the englacial or bottom reflections
might imping not only from the vertical direction of arrival (DoA), but from a wide DoA interval. To 
properly determine the depth of the scatterers or bottom, an array of antennas in reception must be used,
which will estimate the across-track DoA. After the DoA, and with the range and along-track dimensions, a
3D space is fully determined, and hence the 3D mapping is possible.

The SAR and DoA products, each matched with a processing-parameter file ('.m'), correspond to the article (yet to be submitted):
Arenas-Pingarron, A., Corr, H., Robinson, C., Jordan, T., Brennan, P.V.: ‘PASIN2, an Ice-Sounding Airborne Synthetic Aperture Radar for Subglacial 3D Imagery’, IET Radar, Sonar & Navigation.

The SAR and DoA products generated from these parameter files are in netCDF files ('.nc') archived by the UK Polar Data Centre (UK PDC)
-------------- Data DOI to be added --------------
and are described as:


This processing is performed in 3 steps, being the inputs the outputs of the preceeding step:
	1) - SAR processing, from the radar raw data;
	        \___|___/_________________
					  \
				          _\/
	2) - DoA estimation, from several SAR images;
	        \___|___/_____________
				      \
				      _\/
	3) - 3D-mapping, from several DoA estimations.

SAR processing and DoA estimations need of antenna calibration, in amplitude, phase and delay. This is
to correct deviations due to the electronics, multipath reflections on aircraft hull and receiver drifts.
The calibration requires dedicated calibration flights.

The data here included belong the FISS (Filchner Ice Shelf System) project, in 2016/17 season.

The summary below aims to explain the organisation of the PASIN2 products, with comments on the meaning
and scope of each product, but without detailing the processing procedures.

Polarimetric products are not covered here, but they are based on the SAR images.

Each SAR and DoA product is matched with a file with the processing parameters written in Matlab language ('.m').


****************************************
** Organisation of FISS_1617 products **
****************************************
PASIN2 surveys are organised by flights. In season 16/17 there were 31 flights, labelled from F01 to F31. 
F01 to F29 were imaging flights, and F30 and F31 calibration flights. The calibration flights were
above the sea surface and while rolling the aircraft (rotation around the along-track axis).

FISS_1617 directory contains the folders:
	- "FlightCalibration", with the calibration data specific for Flight 07;
	- "Model_DiffractionRefraction(DR)", with the processed products (SAR and DoA) based on the microwave propagation by diffraction and refraction;
	- "Model_PureRefraction(PR)", with the processed products (SAR and DoA) based on the microwave propagation by refraction;
	- "SeasonCalibration", with the calibration data common to all the flights of the season.

FISS_1617 
|   
+---FlightCalibration
|      2016_2017_Flight07_calibration_PulsePhase.nc
|   
+---Model_DiffractionRefraction(DR)
|	2016_2017_Flight07_SAR_ktrace73to76_TxStarC13L4StarJ13L4_RxSC_BackProjection.nc
|	2016_2017_Flight07_SAR_ktrace73to76_TxStarC13L4StarJ13L4_RxSC_BackProjection_diary.txt
|	...
|	2016_2017_Flight07_1DoA_ktrace73to76_TxStarC13L4StarJ13L4_RxiStar.nc
|	2016_2017_Flight07_1DoA_ktrace73to76_TxStarC13L4StarJ13L4_RxiStar_diary.txt
|	...
|   
+---Model_PureRefraction(PR)
|	2016_2017_Flight07_SAR_ktrace71to73_TxPortC13L4PortJ13L4_RxSC_BackProjection.nc
|	...
|	2016_2017_Flight07_1DoA_ktrace71to73_TxPortC13L4PortJ13L4_RxiAll.nc
|	...
|	2016_2017_Flight07_2DoA_ktrace71to73_TxPortC13L4PortJ13L4_RxiAll.nc
|	...
| 
\---SeasonCalibration
	2016_2017_Flight30_calConstantAPD_TxPortRxAll.nc
	2016_2017_Flight30_calConstantAPD_TxStarRxAll.nc
	2016_2017_Flight30_calVaryingRollPitchAP_TxPortRxAll.nc
	2016_2017_Flight30_calVaryingRollPitchAP_TxStarRxAll.nc
	2016_2017_Flight31_calConstantAPD_TxAllRxAll.nc
	2016_2017_Flight31_calVaryingRollPitchAP_TxAllRxAll.nc

********************************
** "SeasonCalibration" folder **
********************************
This folder contains the calibration data for the season, provided the electronics and the antenna locations
do not change throughout the season, for a given antenna configuration (like polarimetric).
There are two kind of calibrations:
	- "2016_2017_Flight30_calConstantAPD_TxPortRxAll.nc", with the averaged amplitude, delay and 
		phase (APD) for any transmitter and receiver, independent of the direction of arrival (DoA).
	- "2016_2017_Flight30_calVaryingRollPitchAP_TxPortRxAll.nc", with the the phase for any
		transmitter and receiver, depending on the direction of arrival (DoA).

********************************
** "FlightCalibration" folder **
********************************
A specific calibration is needed, because the receivers suffered from a drift of delay and advance of 1 sample, 
ocurring at different times for each receiver. This 1-sample drift means a phase error of 90deg, hence needing
to calibrate each receiver independently. This drift is also different for each flight.
	- "2016_2017_Flight07_calibration_PulsePhase.nc", phase variation during Flight 07, for each receiver.

**************************************************
** "Model_DiffractionRefraction(DR)" folder 	** 
** "Model_PureRefraction(PR)" folder 		** 
**************************************************
These folders contain the SAR and DoA processing products, with two different models of wave propagation through
the air and ice, from radar to scatterers. There are 2 models:
1) based on pure refraction goberned by the Snell's law (PR), and
2) based on diffraction followed by refraction (DR).
Using the right model will result in a better focussing. Eventually, ice-stream margins, and occasionally ice-stream
centers are better processed with DR. As the right model is not known a priori, it is recommended to process each
image with PR, and if a region is not properly focussed, test with DR. A whole flight will have regions
better with PR and other regions better with DR, and hence ideally the processing folder would be (PR+DR). The
distinction between the folders is only to allow the options with unique propagation model, to better compare.

The DoA (Direction of Arrival) products can contain one or two estimated directions of arrival.

Each product (SAR and DoA) is paired with the diary file ('.txt') trimmed to the content of interest, and a
parameter file ('.m', in Matlab language) with the processing parameters. The '.m' file is accessed from GitHub by
following the external link
----------------- GITHUB LINK TO BE ADDED -----------------

The file names contain two numbers related to the first and last trace of the along-track locations. A trace is
the time interval for measuring the along-track time during the flight. In season 16/17, a trace was 200 milisecons;
and in 19/20, 400 miliseconds. The numbers in the file names are kilotraces (ktrace, a thousand of traces), that
is 200 seconds in 16/17, and 400 seconds in 19/20. These numbers are not the same as the block number in the raw
data: each raw data block, as stored, is 20 seconds of flight, thus 100 traces (0.1 kilotraces) in 16/17; and
50 traces (0.05 kilotraces) in 19/20. The raw data blocks start by zero, and in 16/17 and 19/20 each block contains
2500 pulses. For example, if the product file name includes "ktrace71_73", the first kilotrace is 71, which corresponds
to 71000 traces; in 16/17 this is the first pulse of raw data block 710, being the pulse 2500*710+1 within the whole
flight sequence. Similarly, the last kilotrace is 73 (73000 traces), until the last pulse of raw data block 730,
which is the pulse 2500*(730+1). Then, for "ktraceA_B":
 - in 16/17: from first pulse of raw data block 10*A to last pulse of raw data block 10*B
 - in 19/20: from first pulse of raw data block 20*A to last pulse of raw data block 20*B

The SAR images are in netCDF files, with extension ‘.nc’, and keyword ‘SAR’ in the file name. The complex-domain SAR
image is stored with its real and imaginary parts, respectively in the two-dimensional (joint depth and along-track)
variables “SARimageReal” and “SARimageImag”. The depth is in the variable "radialDepthGrid", and the along-track index
in the variable "profile".

Examples of the content related to SAR products:
	- "2016_2017_Flight07_SAR_ktrace73to76_TxStarC13L4StarJ13L4_RxSC_BackProjection.nc", with the processed SAR image
		of Flight 07, from kilotrace 73 to 76, transmitting from starboard side the pulses C13L4 and J13L4, receiving
		from starboard side in antenna SC, processing by back-projection method.
	- "2016_2017_Flight07_SAR_ktrace73to76_TxStarC13L4StarJ13L4_RxSC_BackProjection_diary.txt", text file with the
		trimmed record-event information generated during the processing.
	- "2016_2017_Flight11_SAR_ktrace03to04_TxStarC13L4StarJ13L4_RxP1P2P3P4_BackProjection.nc", with the processed SAR image
		of Flight 11, from kilotrace 3 to 4, transmitting from starboard side the pulses C13L4 and J13L4, receiving
		from all the antennas of port side (P1, P2, P3 and P4), processing by back-projection method.

For the DoA estimations, the results include "n" impinging DoAs per product. With "N" channels of pairs transmitters/receivers,
a maximum of "N-1" impinging DoA can be estimated. PASIN2 has 12 independent receivers, meaning 12 channels when using a single
transmitter, and then a maximum of 11 impinging DoA. However, this limit is never reached. In practice, 1, 2 or even 3 impinging
DoA can be measured with 12 channels. As the DoA results are estimations, instead of using just an array of antennas for the
estimation, several estimations are made from several arrays lengths and combinations of pairs transmitters/receivers. From
these several estimations, ensemble DoA averages and standard deviations can be obtained, allowing to use a standard deviation
threshold to validate or discard results for the later 3D-mapping products. Arrays with 2, 3, 4, 8 or 12 elements are suggested,
provided that if "n" impinging DoA are wanted, arrays of at least "n+1" must be used. For these ensemble estimations, values of
"n" can be 1 or 2. For n=1, the DoA is either from port (DoA>0), or starboard (DoA<0), or vertical (DoA=0). For n=2, one DoA is
always from port, and other always from starboard, so without the possibility of the two from the same hemisphere. This is a
condition established in the DoA processing. The decission of which case to choose (n=1 or n=2), is not clear, needing supervision
or even the 3D-mapping products. For the worst case, both cases (n=1 and n=2) are processed, with folders:
	- "..._1DoA_...", n=1;
	- "..._2DoA_...", n=2.

The DoA images are in netCDF files, with extension ‘.nc’, and keyword ‘DoA’ in the file name. The DoA image is represented by
the 3-dimensional variable “directionOfArrival”, being the third dimension the number of estimated directions (n=1 or n=2) at each
of the two-dimensional space of the joint depth and along-track variables. The depth is in the variable "radialDepthGrid", and
the along-track index in the variable "profile".

Examples of the content related to DoA (Direction of Arrival) products:
	- "2016_2017_Flight07_1DoA_ktrace71to73_TxPortC13L4PortJ13L4_RxiAll.nc", with the processed DoA image with n=1 direction,
		of Flight 07, from kilotrace 71 to 73, transmitting from port side the pulses C13L4 and J13L4, receiving
		from all the twelve antennas, each treated as a single channel, then using twelve SAR images.
	- "2016_2017_Flight07_2DoA_ktrace71to73_TxPortC13L4PortJ13L4_RxiPort.nc", with the processed DoA image with n=2 directions,
		of Flight 07, from kilotrace 71 to 73, transmitting from port side the pulses C13L4 and J13L4, receiving
		from all the 4 port antennas, each treated as a single channel, then using 4 SAR images.
	- "2016_2017_Flight07_2DoA_ktrace71to73_TxPortC13L4PortJ13L4_RxiS9SASB.nc", with the processed DoA image with n=2 directions,
		of Flight 07, from kilotrace 71 to 73, transmitting from port side the pulses C13L4 and J13L4, receiving
		from 3 starboard antennas (S9, SA and SB), each treated as a single channel, then using 3 SAR images.
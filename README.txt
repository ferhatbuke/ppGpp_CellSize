Folders; Each folder has a ReadMe file with more details.
Data: Contains the raw data output from the Schnitzcells analysis
Excel Based: Contains data with excel outputs and analysis.
ModelOutput: Contains the outputs of the models and their reduced versions.
Models: Contains the models code as they were run for each experiment.
SiftedData: Contains sifted data used for plotting. Details explained in the analysis file of each experiment

Figures: Explanation of how each figure can be recreated using the shared code and data.
***(see below for explanation for each function requiring this step)

1B -> Raw data and analysis details in the file: "Excel Based\2020-10-05 ppGpp Measurements.xlsx"

1D,E,F, 3E, S1C, S1F, S1G, S2B -> FB_boxPlotDataParser
	***
	Run the function on the command line as: 
	>>'FB_boxPlotDataParser(FitData)'

1C -> This is a single lineage plotted using the Daughter and Parent identifier for a random 
	schnitz in the .mat files ("Data" folder). Each schnitz has a Parent found by:
	->>parentNumber=schnitzcells(schnitzNumber).P
	using this a random cell's parental lineage legnth history was plotted.

2A, 2B -> FB_LBvsMuandTcyc
	***
	-Run the function on the command line as: 
	>>'FB_LbvsMuandTcyc(FitData)'

2C, 3D, 3G, 3H -> FB_schnitzPlotter_R2ng.m
	-Run the function directly (Run within editor)

2D -> FB_compareArrestvsSlowdownv2
	***
	-Run the function directly (Run within editor)

2E -> FB_stabilizationTimerV3
	***
	-Run the function on the command line as:  
	>>'FB_stabilizationTimerV3(FitData)'

2F, 3I -> FB_schnitzPlotter_M100uM.m
	-Run the function directly (Run within editor)

3A, 3B, 3C, S3A -> FB_modelsvsExperiments.m
	***
	-Run the function on the command line as:
	>>FB_modelsvsExperiments.m(FitData)

3F -> FB_divFrequencySpikeStatsModels
	-Run the function directly (Run within editor)

S1A -> Raw data and analysis details in the excel file: "Excel Based\NCMOptimumData.xlsx"

S1B -> FB_ppGpp0Optimum
	-Run the function directly (Run within editor) 

S1D, S1E -> Raw data and analysis details in the file: "Excel Based\InductionTest.xlsx"

S1H -> Raw data and analysis details in the file: "Excel Based\MeshCRichMinData.xlsx"

S2A -> FB_schnitzPlotter_ppGpp0.m
	-Run the function directly (Run within editor)

S2C -> FB_normalWidthComp(FitData)
	***
	-Run the function on the command line as:
	>>FB_normalWidthComp(FitData)

S3C -> Raw data and analysis details in the excel file: "2021-06-16 Ferhat RNA Mesh1 Induction.xlsx"

	
***
Import the main data file and run the function:
(SiftedData->2021-07-10 FitData.xlsx).
-Use 'drag and drop' to read the file and then select the entire spreadsheet area (CTRL+A). 
This creates "FitData" which is used for some functions. 
#This Script is only for subcortical ROIs. Will not work for Cortical - that requires surface mapping (which isn't the best option).
#Last edited by Moosa Ahmed 10/30/2017

##Path to the same templates on your cluster or similar for your cohort. 
template=/group_shares/PSYCH/code/external/pipelines/HCP_MSM_prerelease/global/templates/91282_Greyordinates/91282_Greyordinates.dscalar.nii
vol_lab_template=/group_shares/PSYCH/code/external/pipelines/HCP_MSM_prerelease/global/templates/91282_Greyordinates/Atlas_ROIs.2.nii.gz

##Path to most updated wb_command on your cluster

path_wb_c=/remote_home/perronea/Projects/workbench/bin_linux64/wb_command

##Define

# Path to your output folder
out_folder=/group_shares/HORAK_LAB/ROIs/volume_to_label/TEST
ROI_name=FOX_ROI_combined

##This is your subcortical ROI nifti. Path to your Nifti here. Cannot be a cifti.
vol1=/group_shares/HORAK_LAB/ROIs/volume_to_label/Fox_ROI/Fox_ROI.nii.gz

#Create LUT file for each ROI

## LUTs layout needs to be:
###ROIname (this has to be a name that workbench expects: )
###1 255 0 0 255
#### ROIname (this has to be a volume name that workbench expects: CEREBELLUM, ACCUMBENS_LEFT, ACCUMBENS_RIGHT etc.)
#### Nothing else other than the above two (###) lines for each ROI (you can have as many as you want) first number denotes ROIs intensity number in nifti, then R G B numbers, last number should always be 255 - it denotes the darkness you want your ROI color to be. Check files below for reference.

lut_file=/group_shares/HORAK_LAB/ROIs/volume_to_label/Fox_ROI/LUT_combined.txt

#lut_file=/group_shares/HORAK_LAB/ROIs/volume_to_label/ROI1_LUT.txt
## this is a generic LUT file for a singular ROI, you need to NAME it and if you want more ROIs you must edit the LUT.

#This Script is only for subcortical ROIs. Will not work for Cortical - that requires surface mapping (which isn't the best option).
#Written by Moosa Ahmed 4/17/2017

##Leave as is
template=/group_shares/PSYCH/code/external/pipelines/HCP_MSM_prerelease/global/templates/91282_Greyordinates/91282_Greyordinates.dscalar.nii
vol_lab_template=/group_shares/PSYCH/code/external/pipelines/HCP_MSM_prerelease/global/templates/91282_Greyordinates/Atlas_ROIs.2.nii.gz

##Define
folder_name=PPN+STN
ROI_name=STN_L_thr_3
vol1=/group_shares/HORAK_LAB/ROIs/volume_to_label/PPN+STN/STN_L_thr_3.nii.gz
#vol1=/group_shares/HORAK_LAB/ROIs/AnatomyToolbox/ROIs/ROI_Cerebellum_Nfast_L_MNI.nii
#vol1=/group_shares/HORAK_LAB/Analyses/ROI/Lt_PPN.nii.gz
#vol1=/group_shares/HORAK_LAB/ROIs/STN_from_nitrc/Final_BSAF_2017_ATAG_prop_masks/MNI05/STN_L_prob_mni_non_linear_elderly.nii.gz
#vol1=/group_shares/HORAK_LAB/ROIs/volume_to_label/STN/STN_L_bin.nii.gz

##Naming outputs
#mkdir /group_shares/HORAK_LAB/ROIs/volume_to_label/${folder_name}/
output_label=/group_shares/HORAK_LAB/ROIs/volume_to_label/${folder_name}/${ROI_name}.dlabel.nii

out_vol=/group_shares/HORAK_LAB/ROIs/volume_to_label/${folder_name}/${ROI_name}.2.nii.gz
labeled_vol=/group_shares/HORAK_LAB/ROIs/volume_to_label/${folder_name}/${ROI_name}.labeled.2.nii

#Create LUT file for each ROI

## LUTs layout needs to be:
###ROIname (this has to be a name that workbench expects: )
###1 255 0 0 255
#### ROIname (this has to be a volume name that workbench expects: CEREBELLUM, ACCUMBENS_LEFT, ACCUMBENS_RIGHT etc.)
#### Nothing else other than the above two (###) lines for each ROI (you can have as many as you want) first number denotes ROIs intensity number in nifti, then R G B numbers, last number should always be 255 - it denotes the darkness you want your ROI color to be. Check files below for reference.

lut_file=/group_shares/HORAK_LAB/ROIs/volume_to_label/PPN+STN/new.PPN+STN_LUT.txt

#lut_file=/group_shares/HORAK_LAB/ROIs/volume_to_label/ROI1_LUT.txt
## this is a generic LUT file for a singular ROI, you need to NAME it and if you want more ROIs you must edit the LUT.

#flirt -dof 6 -interp nearestneighbour -in $vol1 -ref $vol_lab_template -out $out_vol
##To make the file 2mm iso and as localised to the input volume
#fslmaths $vol1 -subsamp2 -uthr 1 -thr 0.75 -bin $out_vol

##This one works for PPN and STN but not for FastN.
flirt -interp nearestneighbour -in $vol1 -ref $vol_lab_template -init /group_shares/PSYCH/code/release/pipelines/nipype/utilities/FSL_identity_transformation_matrix.mat -applyxfm -out $out_vol

/remote_home/perronea/Projects/workbench/bin_linux64/wb_command -volume-label-import $out_vol $lut_file $labeled_vol
/remote_home/perronea/Projects/workbench/bin_linux64/wb_command -cifti-create-dense-from-template ${template} ${output_label} -volume-all ${labeled_vol}



## To do
# 1. figure out FastN

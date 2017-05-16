#! /bin/bash

label_in=/group_shares/HORAK_LAB/ROIs/volume_to_label/SMA+STN+PPN/HCP.trimmed.dlabel.nii

# Predifine names
left=left.label.gii
right=right.label.gii

# Make the conversion
wb_command -cifti-separate $label_in COLUMN -label CORTEX_LEFT $left -label CORTEX_RIGHT $right

## Transform giftis into ciftis

# Predifine names
#left_label=left.dlabel.nii
#right_label=right.dlabel.nii

# Make the conversion
#wb_command -cifti-create-label ${left_label} -left-label ${left}
#wb_command -cifti-create-label ${right_label} -right-label ${right}

## Combine LEFT, RIGHT and SUBCORTICAL

# Location of the subcortical parcellation
#subc=/group_shares/PSYCH/ROI_sets/Surface_schemes/Human/subcortical/fsLR/subcortical.subcortical.32k_fs_LR.dlabel.nii
subcifti=/group_shares/HORAK_LAB/ROIs/volume_to_label/PPN+STN/label.allcombined.dlabel.nii
subc=/group_shares/HORAK_LAB/ROIs/volume_to_label/PPN+STN/label.allcombined.labeled.2.nii

label_combined=SMA+STN+PPN.dlabel.nii
#template2=/group_shares/FAIR_LAB/scratch/Oscar/Jeya/aparc_subcortical.dlabel.nii

# One of these 3 to be selected, right now -cifti-create-label works, others dont just yet.
wb_command -cifti-create-label ${label_combined} -left-label ${left} -right-label ${right} -volume ${subc} ${subc}

/remote_home/perronea/Projects/workbench/bin_linux64/wb_command -cifti-create-dense-from-template ${template} ALL_WHITE.dlabel.nii -label CORTEX_LEFT $left -label CORTEX_RIGHT $right -volume ALL_WHITE_MATTER ${subc}

/remote_home/ahmemo/Projects/workbench/bin_rh_linux64/wb_command -cifti-create-dense-from-template ${template} TEST.dlabel.nii -cifti ${subcifti} -label CORTEX_LEFT $left -label CORTEX_RIGHT $right

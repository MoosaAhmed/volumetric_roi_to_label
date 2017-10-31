#! /bin/bash

#This Script is only for subcortical ROIs. Will not work for Cortical - that requires surface mapping (which isn't the best option).
#Written by Moosa Ahmed 4/17/2017
#Last Edited 10/30/2017
. ${1}

if [ $# -ne 1 ]; then
	echo -e "\nUsage:	`basename $0` <run_file>\n"
	echo -e "	Example: `basename $0` run_1.sh\n"
	echo -e "	...Outputs dlabel file made from your subcortical ROI \n"
	exit 1
fi

##Naming outputs
mkdir ${out_folder}
output_label=${out_folder}/${ROI_name}.dlabel.nii

out_vol=${out_folder}/${ROI_name}.2.nii.gz
labeled_vol=${out_folder}/${ROI_name}.labeled.2.nii

#GO!

echo 1 0 0 0 >> ${out_folder}/identity.mat
echo 0 1 0 0 >> ${out_folder}/identity.mat
echo 0 0 1 0 >> ${out_folder}/identity.mat
echo 0 0 0 1 >> ${out_folder}/identity.mat

flirt -interp nearestneighbour -in $vol1 -ref $vol_lab_template -init ${out_folder}/identity.mat -applyxfm -out $out_vol

${path_wb_c} -volume-label-import $out_vol $lut_file $labeled_vol
${path_wb_c} -cifti-create-dense-from-template ${template} ${output_label} -volume-all ${labeled_vol}

rm -f ${out_folder}/identity.mat

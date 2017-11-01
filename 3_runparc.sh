#! /bin/bash

# Written By Moosa Ahmed 5/15/2017
# Lat Edited 10/31/2017

# This takes a dtseries and dlabel file and creates ptseries and timecourses for them.
# This does it for both regular and subcortical parcelations for each dlabel.

## This script does not create symbolic links and does not add these to subjects spec files. for that look into spec_link.sh and Consult Moosa or Oscar.

## Requirements:
#1 Make Task specific run_3.sh

. ${1}

if [ $# -ne 1 ]; then
	echo -e "\nUsage:	`basename $0` <run_file>\n"
	echo -e "	Example: `basename $0` run_3.sh\n"
	echo -e "	...Outputs ptseries and timecourses in the correct HCP folders. These outputs are made using your dlabel and subjects dtseries file\n"
	exit 1
fi

while read SubjectList;do
	cd $SubjectList
	Subject=${PWD##*/}
	echo $Subject

	## This is Step 2. Defining Parcels.
	## Define your Parcellations Here (seprated by spaces)
	for parcel in ${parcel_name};do 

		## This is Step 3. Defining Dtseries Name.
		## Define your dtseries name here. It constitutes the string after "SubjectID_" and before ".dtseries.nii. for e.g for
		## vc35429_total_FNL_preproc.dtseries.nii: total_FNL_preproc is your dtseries_name.(you can define multiple dtseries (seperated by spaces).
		for dtseries_name in ${all_dtseries};do
	
		## Use below for only one dtseries if you dont have more than 1. Comment out above.
		#dtseries_name=total

			f_orig=${SubjectList}/MNINonLinear/Results/${Subject}_${dtseries_name}.dtseries.nii
			echo $f_orig

			## Defining inputs and outputs
			Cort_label=${path_to_label_files}/${parcel}.dlabel.nii
			Cort_out=${SubjectList}/MNINonLinear/Results/${Subject}_${dtseries_name}_${parcel}.ptseries.nii
			Cort_out_trans=${SubjectList}/MNINonLinear/Results/${Subject}_${dtseries_name}_${parcel}_transposed.ptseries.nii
			#echo ${Cort_label}  ${Cort_out} ${Cort_out_trans}

			## Parcellating
			wb_command -cifti-parcellate ${f_orig} ${Cort_label} COLUMN ${Cort_out}
			
			## Transforming cifti and converting to csv and removing transformed ptseries. 
			## Transforming is required so Timecourses can be used by Gui_environments and conforms with FNL_PREPROC 
			wb_command -cifti-transpose ${Cort_out} ${Cort_out_trans}			
			Cort_csv_out=${SubjectList}/analyses_v2/timecourses/${parcel}.csv
			wb_command -cifti-convert -to-text $Cort_out_trans $Cort_csv_out -col-delim ,
			rm -f ${Cort_out_trans}
		done
	done
## This is Step 1. Path to your SubjectList.txt here
done <${path_subjlist}

#! /bin/bash

# Written By Moosa Ahmed 5/15/2017

# This takes a dtseries and dlabel file and creates ptseries and timecourses for them.
# This does it for both regular and subcortical parcelations for each dlabel.

## This script does not create symbolic links and does not add these to subjects spec files. for that look into /mnt/max/shared/projects/WASHU_DATA_NARDOS/Moosa_Val/old/runaparc.sh and Consult Moosa or Oscar.

## Requirements:

#1 Make StudyFolder.txt for all your subjects till the folder right above your 'MNINonlinear' folder and path it on the last line here.
#2 Define your Parcellation
#3 Define your dtsreies_name

## Below is an example of what is to be in your StudyFolder.txt
#/mnt/max/shared/projects/WASHU_DATA_NARDOS/rushmore_HCP20161027/Subjects/vc35429

while read StudyFolder;do
	cd $StudyFolder
	Subject=${PWD##*/}
	echo $Subject

	## This is Step 2. Defining Parcels.
	## Define your Parcellations Here (seprated by spaces)
	for parcel in Gordon HCP;do 

		## ! CHANGE THIS ON DIFFERENT CLUSTERS
		## ! if using another cluster point to the location of your dlabel files here:
		path_to_label_files=/mnt/max/shared/ROI_sets/Surface_schemes/Human/${parcel}/fsLR

		## This is Step 3. Defining Dtseries Name.
		## Define your dtseries name here. It constitutes the string after "SubjectID_" and before ".dtseries.nii. for e.g for
		## vc35429_total_FNL_preproc.dtseries.nii: total_FNL_preproc is your dtseries_name.(you can define multiple dtseries (seperated by spaces).
		for dtseries_name in total total_FNL_preproc;do
	
		## Use below for only one dtseries if you dont have more than 1. Comment out above.
		#dtseries_name=total

			f_orig=${StudyFolder}/MNINonLinear/Results/${Subject}_${dtseries_name}.dtseries.nii
			#echo $f_orig

############################################################################################################################################################
## CORTICAL
			## Defining inputs and outputs
			Cort_label=${path_to_label_files}/${parcel}.32k_fs_LR.dlabel.nii
			Cort_out=${StudyFolder}/MNINonLinear/Results/${Subject}_${dtseries_name}_${parcel}.ptseries.nii
			Cort_out_trans=${StudyFolder}/MNINonLinear/Results/${Subject}_${dtseries_name}_${parcel}_transposed.ptseries.nii
			#echo ${Cort_label}  ${Cort_out} ${Cort_out_trans}

			## Parcellating
			wb_command -cifti-parcellate ${f_orig} ${Cort_label} COLUMN ${Cort_out}
			
			## Transforming cifti and converting to csv and removing transformed ptseries. 
			## Transforming is required so Timecourses can be used by Gui_environments and conforms with FNL_PREPROC 
			wb_command -cifti-transpose ${Cort_out} ${Cort_out_trans}			
			Cort_csv_out=${StudyFolder}/analyses_v2/timecourses/${parcel}.csv
			wb_command -cifti-convert -to-text $Cort_out_trans $Cort_csv_out -col-delim ,
			rm -f ${Cort_out_trans}

#############################################################################################################################################################
## SUBCORTICAL
			## Defining inputs and outputs
			SubCort_label=${path_to_label_files}/${parcel}.subcortical.32k_fs_LR.dlabel.nii
			SubCort_out=${StudyFolder}/MNINonLinear/Results/${Subject}_${dtseries_name}_${parcel}_subcortical.ptseries.nii
			SubCort_out_trans=${StudyFolder}/MNINonLinear/Results/${Subject}_${dtseries_name}_${parcel}_subcortical_transposed.ptseries.nii
			#echo ${SubCort_label}  ${SubCort_out}

			## Parcellating
			wb_command -cifti-parcellate ${f_orig} ${SubCort_label} COLUMN ${SubCort_out}

			## Transforming cifti and converting to csv and removing transformed ptseries. 
			## Transforming is required so Timecourses can be used by Gui_environments and conforms with FNL_PREPROC
			wb_command -cifti-transpose ${SubCort_out} ${SubCort_out_trans}
			SubCort_csv_out=${StudyFolder}/analyses_v2/timecourses/${parcel}_subcortical.csv
			wb_command -cifti-convert -to-text $SubCort_out_trans $SubCort_csv_out -col-delim ,
			rm -f ${SubCort_out_trans}## Defining inputs and outputs
		done
	done
## This is Step 1. Path to your Studyfolder.txt here
done </mnt/max/shared/projects/WASHU_DATA_NARDOS/rushmore_HCP20161027/StudyFolder.txt

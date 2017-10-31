#! /bin/bash

# Written By Moosa Ahmed 5/15/2017
# Last Edited 10/31/2017

# This takes a dtseries and dlabel file and creates ptseries and timecourses for them.

## This script does not create symbolic links and does not add these to subjects spec files. for that look into spec_link.sh and Consult Moosa or Oscar.

## Requirements:

#1 Make SubjectList.txt for all your subjects till the folder right above your 'MNINonlinear' folder and path it on the last line here. [Has to be called SubjectList.txt]
#2 Define your Parcellation
#3 Define your dtsreies_name

## Below is an example of what is to be in your SubjectList.txt
#/mnt/max/shared/projects/WASHU_DATA_NARDOS/rushmore_HCP20161027/Subjects/vc35429


## Path to SubjectList.txt [Has to be called SubjectList.txt]
## e.g: /mnt/max/shared/projects/WASHU_DATA_NARDOS/rushmore_HCP20161027/SubjectList.txt [Has to be called SubjectList.txt]
path_subjlist=~/SubjectList.txt

## This is Step 2. Defining Parcels.
## Define your Parcellations Here (seprated by spaces if more than 1 [they must be in the same folder]). Everything before '.dlabel.nii' 
parcel_name='Gordon.32k_fs_LR' 

## ! CHANGE THIS ON DIFFERENT CLUSTERS
## ! if using another cluster point to the location of your dlabel files here:
path_to_label_files=/mnt/max/shared/ROI_sets/Surface_schemes/Human/Gordon/fsLR

## This is Step 3. Defining Dtseries Name.
## Define your dtseries name here. It constitutes the string after "SubjectID_" and before ".dtseries.nii. for e.g for
## vc35429_total_FNL_preproc.dtseries.nii: total_FNL_preproc is your dtseries_name.(you can define multiple dtseries (seperated by spaces).
all_dtseries='total total_FNL_preproc'

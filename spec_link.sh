#! /bin/bash

f_orig=${all_cifti} #CIFTI at grayordinale resolution
specs_file=${StudyFolder}/MNINonLinear/fsaverage_LR32k/${Subject}.32k_fs_LR.wb.spec
wb_command -add-to-spec-file ${specs_file} INVALID ${f_orig} # add dense time courses to specs file
ln -s ${f_orig} ${ciftis_folder}
ln -s ${specs_file} ${ciftis_folder} # Sym link specs file
#ln -s ${StudyFolder}/MNINonLinear/fsaverage_LR32k/${Subject}.32k_fs_LR.wb.spec ${ciftis_folder} # Sym link specs file
for parcel in `ls ${path_to_label_files}` ; do
   echo ${parcel}
   echo Surface + Subcortical
   f_label=`ls ${path_to_label_files}/${parcel}/fsLR/${parcel}.subcortical.32k_fs_LR.dlabel.nii`
   f_out="${StudyFolder}/MNINonLinear/Results/${Subject}_FNL_preproc_${parcel}_subcortical.ptseries.nii"
   #echo ${f_label}  ${f_out}
   wb_command -cifti-parcellate ${f_orig} ${f_label} COLUMN ${f_out}
   wb_command -add-to-spec-file ${specs_file} INVALID ${f_out}
   ln -s ${f_out} ${ciftis_folder}
   echo Just subcortical
   f_label=`ls ${path_to_label_files}/${parcel}/fsLR/${parcel}.32k_fs_LR.dlabel.nii`
   f_out="${StudyFolder}/MNINonLinear/Results/${Subject}_FNL_preproc_${parcel}.ptseries.nii"
   #echo ${f_label}  ${f_out}
   wb_command -cifti-parcellate ${f_orig} ${f_label} COLUMN ${f_out}
   wb_command -add-to-spec-file ${specs_file} INVALID ${f_out}
   ln -s ${f_out} ${ciftis_folder}
done


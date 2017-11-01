# volumetric_roi_to_label

Three step code to convert a subcortical volume nifti to a dlabel, combine with cortical ROIs and then parcellate your subjects using your new dlabel file.

- run_1.sh is the wrapper for 1_New_volume_to_label.sh.

- 1_New_volume_to_label.sh takes a subcortical volume ROI and outputs dlabel

  - run_1.sh needs to be edited for task specifications and then use the scripts like so: ./1_New_volume_to_label run_1.sh

- 2_combine.sh combines subcortical volume dlabels with cortical surface dlabels

  - 2_combine.sh has not been generalised as of yet. if required please add an issue.

- run_3.sh is the wrapper for 3_runparc.sh.

- 3_runparc.sh outputs ptseries and timecpurses in the correct HCP folders. These outputs are made using a dlabel and a subjects dtseries file.

  - run_3.sh needs to be edited for task specifications and then use the scripts like so: ./3_runparc run_3.sh

*There are more embedded documentations in the bash scripts*

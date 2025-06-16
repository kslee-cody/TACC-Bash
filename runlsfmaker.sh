#!/bin/bash
cd $SCRATCH/data/binary/
module purge
module load tacc-apptainer
apptainer exec ~/ubuntu-22.04.sif ~/bin/getdata.sh 

scancel $SLURM_JOBID

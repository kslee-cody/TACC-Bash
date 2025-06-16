#!/bin/bash
cd $SCRATCH/data/SU-810um_simulation/
module purge
module load tacc-apptainer
apptainer exec ~/ubuntu-22.04.sif ~/bin/getdataTest.sh 

scancel $SLURM_JOBID

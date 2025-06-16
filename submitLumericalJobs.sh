#!/bin/bash
cd $SCRATCH/data/fspPre/
pwd
set -e

# script to submit jobs as finished
# launch script from login node
# Currently max 3 solve licenses can be used
# Need to create .lsf script to automate export of data

### Notes ### 
# Needs to be started from the data folder where it has two subdirectories, raw and processed.
# Will Create Log files in the log directory
# Only one option is included where the -n specifies number jobs to submit

### updated so it moves files to #SCRATCH

# Cancels if error occurs  

### Log File Creation ###
# create Log file
LOGFILE="../$(date +"%Y%m%d%H%M_slurmJobSubmission").log"
touch $LOGFILE

# Set Variables
N=4 # number of simultaneous slurm jobs to be created
DIRNAME="subdir"
# Process Options
# Changes the number of simultaneous slurm jobs to be created
while getopts ":n:" OPTION; do
	case $OPTION in
		n) # change number of slurm job submissions
			N=$OPTARG
			echo "number of simultaneous slurm jobs: $OPTARG"
			;;
		\?) #Invalid Option
			echo "ERROR: Invalid Option"
			exit;;
	esac
done
### Get File Names ###
FILES=./*.fsp # get all .fsp files

### make subdirectories ### 
for (( i=1; i<=$N; i++ ));
do
	echo "$making directory $DIRNAME$i" >> $LOGFILE
	mkdir -p "./$DIRNAME$i" # makes sub directories for slurm script to run
done

### equally distribute files in directory to subdirectories ###
n=1 #initialize i
for EACHFILE in $FILES
do
	echo "moving $EACHFILE to ./$DIRNAME$i/" >> $LOGFILE
	mv "$EACHFILE" "$DIRNAME$n"
	if [[ "$n" = "$N" ]]; then
		n=1
	else
		n=$((1+$n))
	fi
done

# check folders add to logfile
echo "$(date +"%F %T"): tree of data folder - " >> $LOGFILE
echo "$(tree ..)" >> $LOGFILE

# submit slurm scripts
for (( s=1; s<=$N; s++ ))
do 
	sbatch -D ./$DIRNAME$s sbatchScriptTest.sh
	echo "$(date +"%F %T"): submitted sbatch -D ./$DIRNAME$s/ bashscript" >> $LOGFILE
	echo "script submitted"
	sleep 1
done

# show files before completion
echo "tree of current folder" >> $LOGFILE
tree >> $LOGFILE



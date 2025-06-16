#!/bin/bash
#SBATCH -J lumericalJobTest	# job name
#SBATCH -e lumericaljob.%j.err	# error file name 
#SBATCH -o lumericaljob.%j.out	# output file name 
#SBATCH -p small		# request small partition
#SBATCH -N 1                    # request 1 node
#SBATCH -n 32                    # request 32 cores 
#SBATCH -t 12:00:00             # designate max run time 
#SBATCH -A DDM23004             # charge job to myproject  
#SBATCH --mail-type=all		# sends mail start and end of job
#SBATCH --mail-user=cody_lee@utexas.edu 

### Set up variables ###
# LOG File #
LOGFILE="../$(date +"%Y%m%d%H%M%S")_subprocess.log"
touch $LOGFILE
echo "$(date +"%F %T"): starting" >> $LOGFILE

# get file names
FILES=./*.fsp # need to change to .fsp before deployment
echo "Files to be processed" >> $LOGFILE
echo $FILES >> $LOGFILE

PROCESSEDDIR="../../fspPos" # processed directory folder 
mkdir $PROCESSEDDIR #create processed directory folder
echo "$(date +"%F %T"): creating folder $PROCESSEDDIR/" >> $LOGFILE


# Run
for EACHFILE in $FILES 
do
	
	echo "$(date +"%F %T"): Starting file $EACHFILE" >> $LOGFILE
	ibrun /home1/apps/ANSYS/2021R2/lumerical/v212/bin/fdtd-engine-impi-lcl $EACHFILE 
	echo "$(date +"%F %T"): Finished $EACHFILE" >> $LOGFILE
	mv $EACHFILE "$PROCESSEDDIR"
	echo "$(date +"%F %T"): moved $EACHFILE to $PROCESSEDDIR" >> $LOGFILE
done 
echo "$(date +"%F %T"): Process Complete" >> $LOGFILE

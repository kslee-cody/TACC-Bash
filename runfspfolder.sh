#!/bin/bash
### Set up variables ###
# LOG File #
LOGFILE="../$(date +"%Y%m%d%H%M%S")_subprocess.log"
touch $LOGFILE
echo "$(date +"%F %T"): starting" >> $LOGFILE

# get file names
FILES=./*.fsp # need to change to .fsp before deployment
echo "Files to be processed" >> $LOGFILE
echo $FILES >> $LOGFILE

PROCESSEDDIR="../fspPos" # processed directory folder 
mkdir $PROCESSEDDIR #create processed directory folder
echo "$(date +"%F %T"): creating folder $PROCESSEDDIR/" >> $LOGFILE


# Run
for EACHFILE in $FILES 
do
	
	echo "$(date +"%F %T"): Starting file $EACHFILE" >> $LOGFILE
	mpirun -n 32 \
		/home1/apps/ANSYS/2021R2/lumerical/v212/bin/fdtd-engine-impi-lcl\
		 -t 1 $EACHFILE 
	echo "$(date +"%F %T"): Finished $EACHFILE" >> $LOGFILE
	mv $EACHFILE "$PROCESSEDDIR"
	echo "$(date +"%F %T"): moved $EACHFILE to $PROCESSEDDIR" >> $LOGFILE
done 
echo "$(date +"%F %T"): Process Complete" >> $LOGFILE

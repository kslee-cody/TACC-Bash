#!/bin/bash
# splits the directory into multiple subdirectories
N=1
DIRNAME="subdir"
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
FILES=./*.fsp 
for (( i=1; i<=$N; i++ ));
do
        mkdir -p "./$DIRNAME$i" # makes sub directories for slurm script to run
done

n=1 #initialize i
for EACHFILE in $FILES
do
        mv "$EACHFILE" "$DIRNAME$n"
        if [[ "$n" = "$N" ]]; then
                n=1
        else
                n=$((1+$n))
        fi
done


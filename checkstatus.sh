#!/bin/bash
cd $SCRATCH/data
echo 'Number of finished simulations' 
ls -l fspPos | egrep '.fsp' | wc 
echo 'Number of prepared simulations' 
tree fspPre | egrep '.fsp' | wc  
echo 'Number of .mat files'
ls -l scatmat | egrep '.mat' | wc 
echo 'Remaining number of .txt' files
tree binary | egrep '.txt' | wc
echo 'Moving fsp files from subdirs'
mv fspPre/subdir1/*.fsp fspPre/
mv fspPre/subdir2/*.fsp fspPre/
mv fspPre/subdir3/*.fsp fspPre/
mv fspPre/subdir4/*.fsp fspPre/
echo 'moving logfiles to ../logfiles'
mv fspPre/subdir1/*.log ./logfiles
mv fspPre/subdir2/*.log ./logfiles
mv fspPre/subdir3/*.log ./logfiles
mv fspPre/subdir4/*.log ./logfiles

mv fspPre/subdir1/*.out ./logfiles
mv fspPre/subdir2/*.out ./logfiles
mv fspPre/subdir3/*.out ./logfiles
mv fspPre/subdir4/*.out ./logfiles


mv fspPre/subdir1/*.err ./logfiles
mv fspPre/subdir2/*.err ./logfiles
mv fspPre/subdir3/*.err ./logfiles
mv fspPre/subdir4/*.err ./logfiles


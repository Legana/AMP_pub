#!/bin/bash
#PBS -j oe
#PBS -N tune_ampir
#PBS -l walltime=23:00:00
#PBS -l select=1:ncpus=24:mem=60gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load R/3.6.1
Rscript tune_model.R outfile=../cache/tuned_1.rds train=../cache/featuresTrain_1.rds test=../cache/featuresTest_1.rds ncores=24

#!/bin/bash
#PBS -j oe
#PBS -N tune_ampir
#PBS -l walltime=23:00:00
#PBS -l select=1:ncpus=40:mem=120gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load R/3.6.1
Rscript tune_model.R outfile=../cache/tuned_mature.rds train=../cache/featuresTrain_mature.rds ncores=76
Rscript tune_model.R outfile=../cache/tuned_mature_final.rds train=../cache/features_mature.rds ncores=76
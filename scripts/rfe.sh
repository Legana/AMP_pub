#!/bin/bash
#PBS -j oe
#PBS -N rfe
#PBS -l walltime=5:00:00
#PBS -l select=1:ncpus=24:mem=50gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load R/3.6.1
Rscript rfe.R input=../cache/features_1.rds outfile=../cache/rfe_1.rds ncores=24

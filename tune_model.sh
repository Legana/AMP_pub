#!/bin/bash
#PBS -j oe
#PBS -N tune_ampir
#PBS -l walltime=160:00:00
#PBS -l select=1:ncpus=24:mem=160gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load R/3.6.1
Rscript tune_model.R outfile=tuned.rds target=cache/positive032020_98.fasta background=cache/negative032020.fasta

#!/bin/bash
#PBS -j oe
#PBS -N bench_ampir
#PBS -l walltime=23:00:00
#PBS -l select=1:ncpus=40:mem=120gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load R/3.6.1
Rscript speed_bench.R infile=../raw_data/benchmarking/datasets/human/uniprot-proteome_UP000005640_valid.fasta



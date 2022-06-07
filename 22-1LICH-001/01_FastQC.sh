#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=fastqc
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux


module load fastqc
DATA=/datastore/NGSF001/projects/22-1LICH-001/fastq
OUTDIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/22-1LICH-001/fastqc

mkdir -p ${OUTDIR}

FASTQ_FILE=$1

#for FASTQ_FILE in ${DATA}/*.fastq.gz
#do
  #fastqc
#  fastqc -o ${OUTDIR} --extract ${FASTQ_FILE}
#done
fastqc -o ${OUTDIR} --extract ${FASTQ_FILE}

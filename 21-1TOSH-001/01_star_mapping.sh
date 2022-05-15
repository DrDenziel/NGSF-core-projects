#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=star_mapping
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required modules
module load star/2.7.9a 


DATA=/data/labs/bioinformatics_lab/raw_data/RNAseq/mazloum_nayef/UHRF1_knockout
GENOME=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/21-1TOSH-001/indices
GFF=/datastore/NGSF001/analysis/references/bison/jhered/esab003/bison.liftoff.chromosomes.gff
OUTDATA=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/21-1TOSH-001/STAR_alignment

for i in $DATA/*R1_001.fastq.gz
do
        R1="${i%_R1*}";
        R2=${R1##*/};
        fq1=${R1}_R1_001.fastq.gz
	fq2=${R1}_R2_001.fastq.gz
	mkdir -p $OUTDATA/${R2}_star
        mkdir -p $OUTDATA/${R2}_star/tmp 

	$STAR --genomeDir $GENOME --readFilesCommand zcat --readFilesIn $fq1 $fq2 --sjdbGTFfile $GFF --sjdbGTFtagExonParentTranscript Parent --outSAMstrandField intronMotif --outFileNamePrefix $OUTDATA/${R2}_star/star_ --outSAMtype BAM SortedByCoordinate --outFilterIntronMotifs RemoveNoncanonical --runThreadN 2 && samtools index $OUTDATA/${R2}_star/star_Aligned.sortedByCoord.out.bam 
done

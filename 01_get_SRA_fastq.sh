#!/bin/bash 
#SBATCH --job-name=isg5311_data_download
#SBATCH --mail-user=vzu25002@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=general

hostname
date
CHANGE="change made for isg5312"
newbranchCHANGE1="I am a resolved conflict"
newbranchCHANGE2="The merge can now be completed"

# Add comment - Jennifer S. was here on 27Jan2026 for Exercise ISG5312-EX2A. Hi Matt Z.!

module load sratoolkit/3.0.5

OUTDIR=/scratch/mzingarella/isg5311_final_project/data/fastq/
mkdir -p $OUTDIR
ACCLIST=../../metadata/accessionlist.txt
TMP=/scratch/mzingarella/tmp
mkdir -p $TMP

cat $ACCLIST | while read ACC; do
    echo "Downloading $ACC"
    fasterq-dump $ACC -O $OUTDIR --split-files
done

#################################
# Gunzip compression of all fastq files in OUTDIR
#################################
cd $OUTDIR
for file in *.fastq; do
    echo "Compressing $file"
    gzip $file
done

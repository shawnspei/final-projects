#! /usr/bin/env bash

# change default bash paramers
# -e exit if anything fails
# -u exit if any variables are undefined
# -o exit if anything fails in a pipe
# -x print commands as they are executed

set -u -x -e -o pipefail

# define variables
dir="$HOME/Documents/MOLB7621/final_project"
fasta="$dir/ensemble_hg38/Homo_sapiens.GRCh38.cdna.all.fa.gz"
fastqs="$dir/raw_data/"

# first build the index for kallisto (takes a few minutes)

# kallisto index -i $dir"/ensemble_hg38/hg38.cdna.kallisto.idx" $fasta

########################################
# psuedoalign and count reads overlapping transcripts
# make directory for output (-p will not throw an error if directory
# already exists

for fastq in "$fastqs"*.fastq
do 
    echo "psuedoaligning "$fastq "with kallisto"
    
    # strip directory information from $fastq variable
    outname=$(basename $fastq)
    # strip .fastq from $outname variable
    outname=${outname/.fastq/}

    kallisto quant --single \
        -l 100 \
        -s 20 \
        -i $dir"/ensemble_hg38/hg38.cdna.kallisto.idx" \
        -o "kallisto/"$outname \
        -b 5 \
        $fastq
done


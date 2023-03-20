#!/bin/bash
#SBATCH --job-name=gatk_variantcalling
#SBATCH --partition=standard
#SBATCH -c 1
#SBATCH --mem=16g
#SBATCH -t 5:00:00
#SBATCH -o gatk_pon.out
#SBTACH -e gatk_pon.err


module load java
module load nixpkgs/16.09
module load gatk/4.1.2.0

pon=af-only-gnomad.raw.sites.vcf
ref=ref_files/hg19.fa

cd /global/scratch/hpcXXXX/analysis/DNA_Seq/

java -Xmx2g -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar Mutect2 \
   -R $ref \
   -I bam_files/00_Tcell.bam \
   -O Tcell_PoN.vcf.gz

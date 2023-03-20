#!/bin/bash
#SBATCH --job-name=gatk_AML
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aa133@queensu.ca
#SBATCH -c 1
#SBATCH --mem=256g
#SBATCH -t 5:00:00
#SBATCH -o gatk_aml.out
#SBTACH -e gatk_aml.err


module load java
module load nixpkgs/16.09
module load gatk/4.1.2.0

germline=/global/scratch/hpcxxxx/analysis/DNA_Seq/ref_vcf/af-only-gnomad.raw.sites.grch37.vcf.gz
ref=/global/scratch/hpcxxxx/analysis/DNA_Seq/ref_files/hg19.fa
cd /global/scratch/hpc4094/analysis/DNA_Seq/

java -Xmx2g -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar Mutect2 -R $ref \
 -I rawdata_AML/AML_S00.sorted.rmdup.bam \
 -O rawdata_AML/AML.tumormode.vcf.gz




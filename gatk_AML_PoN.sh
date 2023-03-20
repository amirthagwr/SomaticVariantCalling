#!/bin/bash
#SBATCH --job-name=gatk_AML_PON
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aa133@queensu.ca
#SBATCH -c 1
#SBATCH --mem=256g
#SBATCH -t 5:00:00
#SBATCH -o gatk_amlpon.out
#SBTACH -e gatk_amlpon.err


module load java
module load nixpkgs/16.09
module load gatk/4.1.2.0

germline=/global/scratch/hpcxxxx/analysis/DNA_Seq/ref_vcf/af-only-gnomad.raw.sites.grch37.vcf.gz
ref=/global/scratch/hpcxxxx/analysis/DNA_Seq/ref_files/hg19.fa
cd /global/scratch/hpcxxxx/analysis/DK_cancer/DNA_Seq/

java -Xmx2g -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar Mutect2 -R $ref \
 -I rawdata_AML/AML_S00.sorted.rmdup.bam \
 --panel-of-normals  Tcell_PoN.vcf.gz\
 --germline-resource $germline \
 --disable-read-filter MateOnSameContigOrNoMappedMateReadFilter \
 -O rawdata_AML/AML.tumormode_PON.vcf.gz

#-normal sample_name

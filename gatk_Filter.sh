#!/bin/bash
#SBATCH --job-name=gatk_variantcalling
#SBATCH -c 1
#SBATCH --mem=128g
#SBATCH -t 5:00:00
#SBATCH -o gatk_1.out
#SBTACH -e gatk_1.err


module load java
module load nixpkgs/16.09
module load gatk/4.1.2.0

germline=/global/scratch/hpcxxxx/analysis/DNA_Seq/af-only-gnomad.raw.sites.vcf
ref=/global/scratch/hpcxxxx/analysis/DNA_Seq/ref_files/hg19.fa
output_vcf=/global/scratch/hpcxxxx/analysis/DNA_Seq/vcf_output/Final_matched/all_diagnosis.somatic
cd /global/scratch/hpcxxxx/analysis/DNA_Seq/



java -Xmx2g -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar VariantFiltration \
 	-R ${ref} \
	-V /global/scratch/hpc4094/analysis/DK_cancer/DNA_Seq/vcf_output/Final_matched/all_diagnosis.somatic.filtered_pass.vcf \
	-O ${output_vcf}.myfilter2.vcf \
	--filter-expression  "DP < 1000" --filter-name  "DPFilter" --filter-expression "AF < 0.10" --filter-name "LowAF"

 #--panel-of-normals  Tcell_PoN.vcf.gz\
 #--disable-read-filter MateOnSameContigOrNoMappedMateReadFilter \
 #-O vcf_output/01_Diagnosis.vcf.gz



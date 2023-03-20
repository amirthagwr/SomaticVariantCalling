#!/bin/bash
#SBATCH --job-name=snpeff
#SBATCH -c 1
#SBATCH --mem=128g
#SBATCH -t 5:00:00
#SBATCH -o snpeff.out
#SBTACH -e snpeff.err


module load java


dbsnp=/global/scratch/hpcxxxx/analysis/DNA_Seq/ref_vcf/af-only-gnomad.raw.sites.grch37.vcf.gz
germline=/global/scratch/hpcxxxx/analysis/DNA_Seq/af-only-gnomad.raw.sites.vcf
ref=/global/scratch/hpcxxxx/analysis/DNA_Seq/ref_files/hg19.fa
output_vcf=/global/scratch/hpc4094/analysis/DNA_Seq/vcf_output/Final_matched/all_diagnosis.somatic
cd /global/scratch/hpcxxxx/analysis/DNA_Seq/

snpeff=/global/project/hpcgxxxxx/snpEff

java -Xmx2g -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar VariantAnnotator \
     -R ${ref} \
    --dbsnp $dbsnp \
     -V ${output_vcf}.myfilter2PASS.dnsnp.vcf \
     -O ${output_vcf}.dnsnp.vcf 
     --contamination-table ${output_vcf}.contamination.table 

java -jar ${snpeff}/snpEff.jar ann -c $snpeff/snpEff.config -v  -i vcf -o vcf hg19 all_diagnosis.somatic.myfilter2PASS.dnsnp.vcf >all_diagnosis.snpeff.vcf


 #--panel-of-normals  Tcell_PoN.vcf.gz\
 #--disable-read-filter MateOnSameContigOrNoMappedMateReadFilter \
 #-O vcf_output/01_Diagnosis.vcf.gz



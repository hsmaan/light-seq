#!/bin/bash


DATA=["BAM files variable"]
REF=["Ref genome variable"]
OUT=variantcalling
CPU=["Cores variable"]

mkdir vcresults
cd vcresults

exec &> samt_var.log



echo "What arguments would you like to use for samtools mpileup? Seperate your arguments with a space (e.g. -a -b -c)"

read samargs


samtools mpileup -g -f $samargs $REF -b $DATA > variants.bcf

	if [ $? -ne 0 ]
                        then
                                printf "There is a problem at the samtools_mpileup step"
                                exit 1
                fi


echo "What arguments would you like to use for bcftools call? Seperate your arguments with a space (e.g. -a -b -c)"

read bcfargs

bcftools call -mv $bcfargs variants.bcf > variants.vcf

	if [ $? -ne 0 ]
                        then
                                printf "There is a problem at the bcftools variant calling step"
                                exit 1
                fi

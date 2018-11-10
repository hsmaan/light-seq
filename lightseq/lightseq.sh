#!/bin/bash

echo -e '\n\033[1mLight-Seq High-Throughput Sequencing Analysis Pipeline- Version 0.1\033[0m'


printf "\nWelcome to the light-seq DNA sequence analysis pipeline. This pipeline takes sequence data and performs analysis to create a variant calling file.\n\n"



printf "To get started, make sure you have the dependancies installed and ready. Also ensure all your files, except for the reference genome, are in one directory.\n\n"


printf "Please enter your working directory containing all your FASTA and/or downstream files\n"
read DATA

printf "\nPlease enter the full path to your reference genome\n"
read REF 

BWA=$(which bwa)
if [ -z '$BWA' ]; then
	echo "Please enter the path to bwa"
	read BWA
fi 

printf "\nHow many cores would you like to use?\n"
read CPU

printf "\nHow many threads would you like to use?\n"
read THR



printf "\nGreat, we have the path to your files and reference genome.\n\n"

printf "Is your reference genome indexed? (y or n)\n" 

read REFIND



if [ "$REFIND" == "n" ]; then

	source ./bin/bwa_index.sh

fi

printf "\nThere are a variety of steps this pipeline can begin from. Please choose one of the following:\n\n 1. I have multiplexed untrimmed FASTA files. \n 2. I have demultiplexed untrimmed FASTA files. \n 3. I have multiplexed trimmed FASTA files. \n 4. I have demultiplexed and trimmed FASTA files.\n 5. I have already done alignment and have SAM files.\n 6. I have done mapping and indexing, and have BAM files. \n\nPlease enter a number. \n"


read STEP1


case $STEP1 in 

	"1") 
	##DEMULTIPLEXING AND TRIMMING##
	source ./bin/bwa_align.sh
	source ./bin/sam_to_bam.sh
	source ./bin/platypus_vc.sh
	;;	

	"2")
	##TRIMMING##
	source ./bin/bwa_align.sh
	source ./bin/sam_to_bam.sh
	source ./bin/platypus_vc.sh
	;;

	"3")
	##DEMULTIPLEXING##
	source ./bin/bwa_align.sh
	source ./bin/sam_to_bam.sh
	source ./bin/platypus_vc.sh
	;;

	"4")
	source ./bin/bwa_align.sh
	source ./bin/sam_to_bam.sh
	source ./bin/platypus_vc.sh
	;;

	"5")
	source ./bin/sam_to_bam.sh
	source ./bin/platypus_vc.sh
	;;
	
	"6")
	source ./bin/platypus_vc.sh
	;;
	
	*)
	printf "Please enter a number between 1-6."
	;;


esac

printf "\nLight-seq has completed variant calling. Please find the VCF file in your original directory.\n"



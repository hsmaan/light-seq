#!/bin/bash

wd=$(pwd)
echo -e '\n\033[1mLight-Seq High-Throughput Sequencing Analysis Pipeline- Version 0.1\033[0m'


printf "\nWelcome to the light-seq DNA sequence analysis pipeline. This pipeline takes sequence data and performs analysis to create a variant calling file.\n\n"



printf "To get started, make sure you have the dependancies installed and ready. Ensure all your FASTA, FASTAQ, or downstream files are in one directory (this will be mthe main working directory). If you are demultiplexing, ensure your barcode FASTA is in a seperate folder. Also ensure your reference genome is in a completely seperate folder. The pipeline will create files in the main working directory, but may also create subdirectories if using AfterQC for trimming.\n\n"


printf "Please enter your working directory containing all your FASTQ and/or downstream files\n"
read DATA

printf "\nAre you working with single-end or paired-end reads? (Enter as 'single' or 'paired') If you have SAM or BAM files, just hit enter.\n"
read sq_type

printf "\nPlease enter the full path to your reference genome\n"
read REF 
 
printf "\nHow many cores would you like to use?\n"
read CPU

printf "\nHow many threads would you like to use?\n"
read THR

printf "\nPlease ensure you have the correct filetypes for each step.\n Demultiplexing: *.fq\n Trimming: *.fq or *.fastq\n BWA Fasta Indexing: *.fastq\n SAM to BAM Conversion: *.sam\n Variant Calling: *.bam\n\n Press enter to continue.\n"
read placeholder 

printf "Is your reference genome indexed? (y or n)\n" 

read REFIND


if [ "$REFIND" == "n" ]; then

	source ./bin/bwa_index.sh

fi

printf "\nThere are a variety of steps this pipeline can begin from. Please choose one of the following:\n\n 1. I have multiplexed untrimmed FASTQ files. \n 2. I have demultiplexed untrimmed FASTQ files. \n 3. I have multiplexed trimmed FASTQ files. \n 4. I have demultiplexed and trimmed FASTQ files.\n 5. I have already done alignment and have SAM files.\n 6. I have done mapping and indexing, and have BAM files (located in a file named 'bamlist'). \n\nPlease enter a number. \n"


read STEP1


case $STEP1 in 

	"1") 
	source ./bin/demultiplex.sh
	cd $wd
	##source ./bin/afterqc.sh
	source ./bin/cutad_parallel.sh
	cd $wd
	source ./bin/bwa_align.sh
	cd $wd
	source ./bin/sam_to_bam.sh
	cd $wd
	source ./bin/platypus_vc.sh
	;;	

	"2")
	##source ./bin/afterqc.sh
	source ./bin/cutad_parallel.sh
	cd $wd
	source ./bin/bwa_align.sh
	cd $wd
	source ./bin/sam_to_bam.sh
	cd $wd
	source ./bin/platypus_vc.sh
	;;

	"3")
	source ./bin/demultiplex.sh
	cd $wd
	source ./bin/bwa_align.sh
	cd $wd
	source ./bin/sam_to_bam.sh
	cd $wd
	source ./bin/platypus_vc.sh
	;;

	"4")
	source ./bin/bwa_align.sh
	cd $wd
	source ./bin/sam_to_bam.sh
	cd $wd
	source ./bin/platypus_vc.sh
	;;

	"5")
	source ./bin/sam_to_bam.sh
	cd $wd
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



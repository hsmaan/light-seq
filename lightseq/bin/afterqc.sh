#!/bin/bash



#AfterQC is being used for automatic adaptor cutting, trimming and report generation. The folder created named good has the reads that passed. You can replace pypy with python to get it to run on your pc if you do not have pypy installed, but pypy is much faster.



#This function will rename any .fq files in the user directory to .fastq for simplicity. Then it will run AfterQC to cut adaptors and trim reads using AfterQC's automation algorithims, the parameters used specify this. Reads with that pass are placed in the good folder. Quality reports are generated in the QC folder, please review these.



function afterqc {


    cd $DATA
	local fqfiles=`ls $DATA *.fq | wc -l`
	if [ "$fqfiles" != 0 ];then
		rename.ul .fq .fastq *.fq
		#for file in *.fq; do mv "$file" "${file%.fq}.fastq"; done  #for mac users. 
	fi
	#Obtain path of after.py from user
	echo "Please enter the complete path to after.py for the program AfterQC"
	local afqcl
	read afqcl

	#AfterQC requires files to have R1 in the name even if they are single
	if [ "$sq_type" == "single" ];then
	cd $DATA
	rename.ul .fastq _R1.fastq *.fastq
	#for i in *.fastq; do name="${i%.*}"; mv "$i" "${name}R1${i#$name}"; done #if you're using mac this should help
	pypy "$afqcl" -f -1 -t -1
	if [ $? -ne 0 ]; then
		printf "There is a problem in the afterqc trimming step"
		exit 1
	fi
	cd good
	rename.ul .fq .fastq *.fq
	#for file in *.fq; do mv "$file" "${file%.fq}.fastq"; done
	fi

	#For paired reads 
	if [ "$sq_type" == "paired" ];then
		cd $DATA
		echo "Please ensure the paired sequences have R1 and R2 in the names respectively"
		pypy "$afqcl" -f -1 -t -1
		if [ $? -ne 0 ]; then
			printf "There is a problem in the afterqc trimming step"
			exit 1
		fi
		cd good
		rename.ul .fq .fastq *.fq
		#for i in *.fastq; do name="${i%.*}"; mv "$i" "${name}R1${i#$name}"; done
	fi
	
	if [ $? -eq 0 ]; then
		printf "The trimming step using AfterQC completed successfully.\n" >> $wd/main.log
	fi


}



afterqc
DATA=$(pwd)

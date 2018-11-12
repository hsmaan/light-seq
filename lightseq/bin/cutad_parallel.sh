#!/bin/bash

cd $DATA
ADAP=AGATCGGAA

# echo "enter your adaptor sequence to be cut"
# read ADAP

UNTRIMMED_FILES=$( ls $DATA/*.fq )
##echo $UNTRIMMED_FILES

parallel -j $CPU cutadapt -a $ADAP -o {}.trimmed.fastq {}.fq ::: $(ls -1 *.fq | sed 's/.fq//')
	if [ $? -ne 0 ]
		then
			printf There is error in the cutadapt
			exit 1
	fi

## remove untrimmed files so theyre not included in downstream analysis
rm $UNTRIMMED_FILES

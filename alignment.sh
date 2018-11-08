#!/bin/bash

#could potentially modify the options of bwa, such as matching score, mismatch penalty, gap open penalty etc.
#could let user choose the algorithm type MEM or aln
DATA=/home/rhuang06/Documents/Bioinfor_programming/Assigment2/NGS
REF=/home/rhuang06/Documents/Bioinfor_programming/Assigment2/refgenome/Gmax_275_v2.0.fa
BWA=/usr/bin/bwa
CPU=3
THR=2


echo "select alignment algorithm"
echo "MEM or aln ?"
read al_selection

echo "single end or paired end"
read sq_type

if [ "$al_selection" == "MEM" ];then
echo "you choose bwa mem"
if [ "$sq_type" == "single" ];then
cd $DATA
parallel -j $CPU $BWA mem -t $THR $REF {}.fastq ">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
if [ $? -ne 0 ]
			then
				printf There is a problem in the alignment step
				exit 1
		fi
elif [ "$sq_type" == "pair" ];then
parallel -j $CPU $BWA mem -t $THR $REF {}_1.fastq {}_2.fastq">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
if [ $? -ne 0 ]
			then
				printf There is a problem in the alignment step
				exit 1
		fi
else
echo "please select single or pair"
exit 1
fi


elif [ "$al_selection" == "aln" ];then
echo "you choose bwa aln"
if [ "$sq_type" == "single" ];then
cd $DATA
parallel -j $CPU $BWA aln -t $THR $REF {}.fastq ">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
if [ $? -ne 0 ]
			then
				printf There is a problem in the alignment step
				exit 1
		fi
elif [ "$sq_type" == "pair" ];then
parallel -j $CPU $BWA aln -t $THR $REF {}_1.fastq {}_2.fastq">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
if [ $? -ne 0 ]
			then
				printf There is a problem in the alignment step
				exit 1
		fi
else
echo "please select single or pair"
exit 1
fi
else 
echo "please select MEM or aln"
fi 






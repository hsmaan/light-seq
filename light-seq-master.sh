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



#Convinient if user has the Platypus.py accessible through PATH
PLATPATH=$(which Platypus.py)

#Checking to see if the variable PLATPATH is empty
if [ -z "$PLATPATH" ]; then 
echo 'Please input the path directory of Platypus.py (e.g /usr/local/..)'
read PLATPATH
fi 

#python $PLATPATH callVariants --help 
echo 'Would you like to add addition options for Platypus? (y/n)'
while :
do
	read PLATOPT
	case $PLATOPT in
		y)
			echo 'Please input the additional options and mind the spacing (e.g --genIndels=TRUE assembleAll=1)'
			read PLATCON
			break
			;;
		n)
			break
			;;
		*)
			echo 'Please choose y for yes or n for no'
			;;
	esac
done 


#python $PLATPATH callVariants --bamFiles=$BAMFILES --refFile=$GENOME --output=$VCFNAME.vcf --nCPU=$CPU $PLATCON


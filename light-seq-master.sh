#!/bin/bash

#could potentially modify the options of bwa, such as matching score, mismatch penalty, gap open penalty etc.
#could let user choose the algorithm type MEM or aln
echo "Please enter your working directory containing your fasta files"
read $DATA

echo "Please indicate the full path to your reference genome"
read $REF

echo "Please the path to your bwa file"
read $BWA

echo "How many cores would you like to use?"
read $CPU

echo "How many threads would you like to use?"
read $THR


echo "select alignment algorithm"
echo "MEM or aln ?"
read al_selection

echo "single end or paired end"
read sq_type

echo "any arguments to add? please leave space between each arugments"
read arg

if [ "$al_selection" == "MEM" ];then
echo "you choose bwa mem"
if [ "$sq_type" == "single" ];then
cd $DATA
parallel -j $CPU $BWA mem -t $THR $arg $REF {}.fastq ">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
if [ $? -ne 0 ]
			then
				printf There is a problem in the alignment step
				exit 1
		fi
elif [ "$sq_type" == "pair" ];then
parallel -j $CPU $BWA mem -t $THR $arg $REF {}_1.fastq {}_2.fastq">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
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
parallel -j $CPU $BWA aln -t $THR $arg $REF {}.fastq ">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
if [ $? -ne 0 ]
			then
				printf There is a problem in the alignment step
				exit 1
		fi
elif [ "$sq_type" == "pair" ];then
parallel -j $CPU $BWA aln -t $THR $arg $REF {}_1.fastq {}_2.fastq">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
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





#!/bin/bash

#############################################################################
#	       samtools	          samtools               samtools
# samfile --view--> bamfile --sort--> bamfile.sort --index--> bamfile.sort.idx
#
#############################################################################

#1. create a log file and echo processes
exec &> convert.log
echo "processing .sam files using samtools...output will be one temporary bamfile, one indexed bamfile, and one sorted indexed bamfile"

#2. convert SAM to BAM format with "samtools view"
parallel samtools view -b -S {}.sam ">" {}.temp.bam ::: $(ls -1 *.sam | sed 's/.sam//')
                if [ $? -ne 0 ]
                then 
                        printf "There is a problem in the samtools-view step"
                        exit 1
                fi


#3. sort BAM files with "samtools sort"
parallel samtools sort {}.temp.bam -o {}.sort.bam ::: $(ls -1 *.temp.bam | sed 's/.temp.bam//')
                if [ $? -ne 0 ]
                then 
                        printf "There is a problem in the samtools-sort step"
                        exit 1
                fi


#4. indexing BAM files with "samtools index"
parallel samtools index {} ::: $(ls -1 *.sort.bam)
                if [ $? -ne 0 ]
                then 
                        printf "There is a problem in the samtools-index step"
                        exit 1
                fi


#5. create a list of BAM files

for i in $(ls -1 *.sort.bam)
   do
      printf "$PWD/${i}\n" >> "bamlist"
           if [ $? -ne 0 ]
           then 
                  printf "There is a problem in bam file list"
                  exit 1
            fi
   done

#!/bin/bash 

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


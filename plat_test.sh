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


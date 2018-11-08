#!/bin/bash

REF=/Users/jacobblamer/My_Data/practice_file/assign_1/light-seq-master/GCF_00005845.2.fna

## BWA Index
## Output: 5 index files (.fa.amb; .fa.ann; .fa.bwt; .fa.pac; .fa.sa)

echo "Is your reference larger than 2GB? (y/n/na...if unknown, choose na)"
read REF_SIZE

if [ $REF == y ] 
then
	echo "Indexing with 'is'"
	bwa index -a is $REF

else
	echo "Indexing with 'bwtsw'"
	bwa index -a bwtsw $REF

fi


## SAMTOOLS Index
## Output: 1 index file (.fai)

samtools faidx $REF

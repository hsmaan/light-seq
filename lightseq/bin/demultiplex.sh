#!\bin\bash

#user input for file, tool and barcode

echo "Where is your fastq file?"

read FASTQ
DATA=$FASTQ
echo
echo "What is your sabre path?"

read SABRE
TOOL=$SABRE

echo
echo "What is your barcode path?"

read BAR
BARCODE=$BAR

echo
echo "New directory called 'NGS' created for your demultiplexed data"

mkdir NGS

cd NGS

#logging
#exec &> sabre.log

#command to run demultiplex using sabre
#$TOOL se -f $DATA -b $BARCODE -u *.fastq

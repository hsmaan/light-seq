#!/bin/bash



function demultiplex {
 	cd $DATA

 	local SABRE=$(which sabre)
	
	if [ -z '$SABRE' ]; then
 	#user input for tool and barcode
 		echo -e "What is your sabre path?\n"
 		read SABRE
	fi
	
	echo -e "\nWhat is the path to your barcode sequence?\n"
	local BAR
	read BAR
	BARCODE=$BAR
	
	MULTIPLXD_FILE=$( ls $DATA/*.fq )
	##echo $MULTIPLXD_FILE
  
  	if [ "$sq_type" == "single" ]; then
  		$SABRE se -f $DATA/*.fq -b $BARCODE -u unk.fq ;
    		if [ $? -ne 0 ]; then
			printf "There is a problem in the sabre demultiplexing step"
			exit 1
  		fi
		
	#this code should run under the assumption that the files are name _1 and _2 respectively, not R1 and R2. 
  	elif ["$sq_type" = "paired"] ; then 
  		$SABRE pe -f $DATA/*_1.fq -r $DATA/*_2.fq -b $BARCODE -u unk1.fq -w unk2.fq 
  	fi
	
	## remove multiplexed file so it's not processed downstream
	mkdir oldfasta
 	mv $MULTIPLXD_FILE oldfasta
	if [ $? -eq 0 ]; then
		printf "The demultiplexing step using sabre completed successfully.\n" >> $wd/main.log
	fi
}

demultiplex

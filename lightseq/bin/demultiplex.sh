#!/bin/bash



function demultiplex {
 
  #user input for tool and barcode
  echo -e "What is your sabre path?\n"
  local SABRE
  read SABRE
  TOOL=$SABRE

  echo -e "\nWhat is the path to your barcode sequence?\n"
  local BAR
  read BAR
  BARCODE=$BAR  
  
  if [ "$seq_type" == "single" ];then
  cd $DATA
  ##Help user to local the file by simply enter the file name
  echo -e "\nHere is the list of files in your chosen directory\n"
  command ls $DATA
  echo -e "\nPlease enter Name of your file for demultiplexing\n"
  local NAME
  read NAME
  local FILE=`find $DATA -name $NAME`
  $TOOL se -f $FILE -b $BARCODE -u *.fastq
  if [ $? -ne 0 ]; then
		printf "There is a problem in the sabre demultiplexing step"
		exit 1
  	fi
  
  ####PLACEHOLDER FOR PAIRED END####
  else
  :
  fi
}

demultiplex

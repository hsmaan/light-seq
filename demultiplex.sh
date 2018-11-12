#!/bin/bash



function demultiplex {

  cd $DATA
 
  #user input for tool and barcode
  echo -e "What is your sabre path?\n"
  local SABRE
  read SABRE

  echo -e "\nWhat is the path to your barcode sequence?\n"
  local BAR
  read BAR
  BARCODE=$BAR
  
  echo e "\nDo you have single end or paired-end reads?\n?"
  local seq_type
  read seq_type
  echo seq_type
 
  MULTIPLXD_FILE=$( ls $DATA/*.fq )
  ##echo $MULTIPLXD_FILE	

  if [ $seq_type  == "single" ] ; 
  then
	 $SABRE se -f $DATA/*.fq -b $BARCODE -u unk.fq ;
  fi

  ## remove multiplexed file so it's not processed downstream
  rm $MULTIPLXD_FILE

  
}

demultiplex

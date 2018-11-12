#!\bin\bash



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
  
  echo -e "\nDo you have single end or paired-end reads?\n?"
  local seq_type
  read seq_type
  
  if [ "$seq_type" == "single" ];then
  cd $DATA
  echo -e "\nPlease enter the path of your fastq file\n"
  local FILE
  read FILE 
  $TOOL se -f $FILE -b $BARCODE -u *.fastq
  
  ####PLACEHOLDER FOR PAIRED END####
  
  else
  :
  fi
}

demultiplex

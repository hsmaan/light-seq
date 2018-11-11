function platypus_vc {
	echo '#### Now running Platypus.py for variant calling ####'
	cd $DATA

	#Convinient if user has the Platypus.py accessible through PATH
	local PLATPATH=$(which Platypus.py)

	#Checking to see if the variable PLATPATH is empty
	if [ -z "$PLATPATH" ]; then 
	echo 'Please input the path directory of Platypus.py (e.g /usr/local/..)'
	read PLATPATH
	fi 
	 
	echo 'Would you like to add addition options for Platypus? (y/n)'
	while :
	do
		local PLATOPT
		read PLATOPT
		case $PLATOPT in
			y)
				echo 'Please input the additional options and mind the spacing (e.g --genIndels=TRUE assembleAll=1)'
				local PLATCON
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

	#exec &> platypus.log

	python $PLATPATH callVariants --bamFiles=bamlist --refFile=$REF --output=output.vcf --nCPU=$CPU $PLATCON

}

platypus_vc


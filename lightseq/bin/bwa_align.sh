function bwa_align {
	#If the user already has the bwa in their PATH, it will not ask them to input said path
	local BWA=$(which bwa)
	if [ -z '$BWA' ]; then
		echo "Please enter the path to bwa"
		read BWA
	fi 


	echo "Would you like to use the MEM or aln alignment algorithm (Answer as "MEM" or "aln")?"
	local al_selection
	read al_selection

	echo "Do you have any arguments to add to the BWA algorithm? (format these as -a -b -c.. etc)"
	local arg
	read arg

	cd $DATA

	if [ "$al_selection" == "MEM" ]; then
		echo "You chose the BWA MEM alignment algorithm"
		if [ "$sq_type" == "single" ];then
			parallel -j $CPU $BWA mem -t $THR $arg $REF {}.fastq ">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
			if [ $? -ne 0 ]; then
				printf There is a problem in the alignment step
				exit 1
			fi
		elif [ "$sq_type" == "pair" ];then
			parallel -j $CPU $BWA mem -t $THR $arg $REF {}_1.fastq {}_2.fastq ">" {}.sam ::: $(ls -1 *_1.fastq | sed 's/_1.fastq//')
			if [ $? -ne 0 ]; then
				printf There is a problem in the alignment step
				exit 1
			fi
		else
			exit 1
		fi


	elif [ "$al_selection" == "aln" ];then
		echo "You chose the BWA aln alignment algorithm"
		if [ "$sq_type" == "single" ];then
			parallel -j $CPU $BWA aln -t $THR $arg $REF {}.fastq ">" {}.sai ::: $(ls -1 *.fastq | sed 's/.fastq//')
			parallel -j $CPU $BWA samse $REF {}.sai {}.fastq ">" {}.sam ::: $(ls -1 *.sai | sed 's/.sai//')
			if [ $? -ne 0 ]; then
				printf There is a problem in the alignment step
				exit 1
			fi
		elif [ "$sq_type" == "pair" ];then
			parallel -j $CPU $BWA aln -t $THR $arg $REF {}.fastq ">" {}.sai ::: $(ls -1 *.fastq | sed 's/.fastq//')
        		parallel -j $CPU $BWA sampe $REF {}_1.sai {}_2.sai {}_1.fastq {}_2.fastq ">" {}.sam ::: $(ls -1 *_1.sai | sed 's/_1.sai//')
			if [ $? -ne 0 ]; then
				printf There is a problem in the alignment step
				exit 1
			fi
		else
			exit 1
		fi
	else 
		echo "Please select correct algorithm or mode"
	fi 

if [ $? -eq 0 ]; then
		printf "The alignment step using bwa_align completed successfully.\n" >> $wd/main.log
	fi

}

bwa_align 

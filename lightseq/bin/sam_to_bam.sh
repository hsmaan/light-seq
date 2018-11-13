function sam_to_bam {
	cd $DATA
	#1. create a log file and echo processes
	#exec &> convert.log
	echo "Processing .sam files using samtools...output will be one temporary bamfile, one indexed bamfile, and one sorted indexed bamfile"

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
	   done
	if [ $? -ne 0 ]
	then 
	 	printf "There is a problem in bam file list"
	 	exit 1
	fi

if [ $? -eq 0]; then
		printf "The sam to bam step using sam_to_bam completed successfully.\n" >> main.log
	fi
}

sam_to_bam

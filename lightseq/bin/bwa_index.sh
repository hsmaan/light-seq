function bwa_index {

	## BWA Index
	## Output: 5 index files (.fa.amb; .fa.ann; .fa.bwt; .fa.pac; .fa.sa)

	## use awk to find size of file
	local SIZE=$( ls -l $REF | awk {'print $5'} )
		echo "reference is $SIZE bytes"

	## use "bwtsw" algorithm if ref size is greater than 2GB
	if [ $SIZE -ge 2000000000 ]
        	then
        		echo "reference is larger than  2GB, using bwtsw to index"
		bwa index -a bwtsw $REF

	## use "is" algorthm if ref size is less than 2GB
	elif [ $SIZE -lt 2000000000 ]
        	then
        		echo "reference is less than 2GB, using 'is' to index"
	        bwa index -a is $REF

	else
        	echo "error in reading file size"
	fi
}

bwa_index 

---Overview

Light-Seq is a sequencing analysis pipeline that takes in reads in the form of FASTA files (or downstream files) and outputs variant-calling files (VCF). The pipeline can take input at various steps and is quite versatile. It can perform demultiplexing, adapter trimming, reference genome indexing, read alignment, read mapping and indexing, and variant calling.
Light-Seq will prompt the user to declare the task using the command-line interface and specify the file-paths necessary. In each case, the resulting output will be a VCF file after variant calling is done.

---Requirements

Light-Seq relies on various tools that are assumed to be installed on the user's machine.

-Sabre for demultiplexing
-AfterQC for trimming and quality control
-BWA for reference and read alignment
-Samtools for SAM to BAM conversion
-Platypus for variant calling
-GNU Parallel for parallel processing
-PyPy for python speed improvement

---Rationale

-Sabre was used for demultiplexing because it effectively demultiplexes fastq files into separate files based on their barcode reads. It works on both single-ended and pair-ended reads, and also takes gzipped file inputs.
-AfterQC was used in the pipeline for adaptor cutting, quality control and trimming. Rich quality reports are genrated in the QC folder and by running with pypy, the tool runs significantly faster and uses less memory than running with python. AfterQC can identify adaptors without the need for the user to input them manually and uses algorithims to determine the appropriate number of bases to trim from the front and tail. The parameters -f -1 -t -1 specify the use of these options.
-BWA was used for reference genome indexing. BWA is a fast and accurate software package for mapping low-divergent sequences to a large reference genome. This pipeline contains two algorithms (BWA-MEM and BWA-backtrack) from BWA package. BWA-MEM (bwa mem) is one of the fastest and most accurate mapping algorithm for sequence from 70bp to 1Mpb, and BWA-backtrack (bwa aln) can have better performance than BWA-MEM for sequence below 70pb. However, BWA-MEM has better performance than BWA-blacktrack for sequence from 70bp to 100pb.
-Samtools was used for conversion of SAM files to BAM files, sorting of BAM files, and indexing of BAM files. Samtools provides these utilities, and various others, in a easy to use suite of programs. Samtools was used in conjuction with GNU Parallel to streamline this step of the pipeline.
-Platypus was used as the variant caller due to its specificity when it comes to options and it is efficient and accurate when dealing with high-throughput sequencing data. The user has to add the options appropriate for their analysis when prompted.

---Installation

-Clone the repository to your machine using the terminal.

	git clone https://github.com/hsmaan/light-seq.git

-Change directories and add permissions to the script files.

	cd light-seq
	chmod +x lightseq.sh

	cd bin
	chmod +x *.sh

---Usage

Change to back to the light-seq main directory. Ensure you have the paths to all the necessary files and tools used in the pipeline.

Execute the light-seq script using:

	./lightseq.sh

The script will have a series of prompts asking for the filepaths, filetypes, and type of analysis the user wants to conduct. In each case, the pipeline should produce a VCF file in the user-specified working directory, except in the case where adapter trimming is performed, then the resulting VCF file will be in the 'good' folder within the user-specified working directory.

---Troubleshooting FAQ

1. I'm unable to run the program using ./lightseq.sh

2. The program can't find my files and stops prematurely.

3. A certain tool failed and it wasn't a file error.

-Question 1

Ensure you have given persmissions to the main script and to the scripts in the bin. If you were denied permission try:

sudo chmod +x [script]

-Question 2

Make sure your directories contain the correct files. When specifying the main working directory, do not link to a certain file, but the directory containing the files (i.e. /../../fastafiles NOT /../../fastafiles/fc2010.fq). When linking the multiplexing adapter, the reference genome, and the bamlist, ensure that you are write the path to the file itself. If you are still having issues, check to ensure that your files have the correct extension specified by the prompts. The following table shows the correct files and extensions for each step:

-Pipeline Step 			-Filetype 		-Extension
Demultiplexing 			Fasta 			.fq
Trimming and QC 		Fasta 			.fastq
Reference Genome Indexing 	Refgenome 		.fa
BWA Fasta Align 		Fasta 	.fastq
Samtools SAM to BAM 		Sequence Alignment 	.sam
Platypus Variant Calling 	Binary Alignment 	.bam

-Question 3

If a certain tool fails even if the correct filetypes and paths are specified, then most likely the documentation for that given tool needs to be consulted. Most of the tools used in Light-Seq have dependancies (such as htslib for Platypus), and the user must ensure that the tool is installed correctly with the right dependancies. If the error persists, please open up an issue on the github page and the Light-Seq team will respond as soon as possible.
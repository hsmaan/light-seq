# Light-Seq DNA Sequence Analysis Pipeline

## Overview

Light-Seq is a sequencing analysis pipeline that takes in reads in the form of FASTA files (or downstream files) and outputs variant-calling files (VCF). The pipeline can take input at various steps and is quite versatile. It can perform demultiplexing, adapter trimming, reference genome indexing, read alignment, read mapping and indexing, and variant calling. 

Light-Seq will prompt the user to declare the task using the command-line interface and specify the file-paths necessary. In each case, the resulting output will be a VCF file after variant calling is done. 

## Requirements

Light-Seq relies on various tools that are assumed to be installed on the user's machine.

[Sabre for demultiplexing](https://github.com/najoshi/sabre)

[AfterQC for trimming and quality control](https://github.com/OpenGene/AfterQC)

[BWA for reference and read alignment](https://github.com/lh3/bwa)

[Samtools for SAM to BAM conversion](http://www.htslib.org/)

[Platypus for variant calling](https://github.com/andyrimmer/Platypus)

[GNU Parallel for parallel processing](https://www.gnu.org/software/parallel/)

[PyPy for python speed improvement](https://pypy.org/download.html)

## Rationale

* Sabre was used for demultiplexing because..
* AfterQC was used for trimming and quality control..
* BWA was used for reference genome indexing..
* Samtools was used for SAM to BAM conversion..
* Platypus was used for variant calling..

## Installation

Clone the repository to your machine using the terminal.

```bash
git clone https://github.com/hsmaan/light-seq.git
```

Change directories and add permissions to the script files.

```bash
cd light-seq
chmod +x lightseq.sh

cd bin
chmod +x *.sh
```

## Usage

Change to back to the light-seq main directory. Ensure you have the paths to all the necessary files and tools used in the pipeline.

Execute the light-seq script using:

```bash
./lightseq.sh
```
The script will have a series of prompts asking for the filepaths, filetypes, and type of analysis the user wants to conduct. In each case, the pipeline should produce a VCF file in the user-specified working directory.

## Troubleshooting FAQ

[1. I'm unable to run the program using ./lightseq.sh](#q1)

[2. The program can't find my files and stops prematurely.](#q2)

<a name="q1"></a>

####  Question 1
Ensure you have given persmissions to the main script and to the scripts in the bin. If you were denied permission try:

```bash
sudo chmod +x [script]
```
<a name="q2"></a>

#### Question 2
Make sure your directories contain the correct files. When specifying the main working directory, do not link to a certain      **file**, but the **directory** containing the files (i.e. /../../fastafiles **NOT** /../../fastafiles/fc2010.fq). When linking the multiplexing adapter, the reference genome, and the bamlist, ensure that you are write the path to the **file** itself. If you are still having issues, check to ensure that your files have the correct extension specified by the prompts. The following table shows the correct files and extensions for each step:


 | Pipeline Step        | Filetype           | Extension  |
 | :------------- |:-------------|:-----|
 | Demultiplexing      | Fasta | .fq  |
 | Trimming and QC      | Fasta      | .fastq  |
 | Reference Genome Indexing | Refgenome     | .fa  |
 | BWA Fasta Align | Fasta | .fastq |
 | Samtools SAM to BAM | Sequence Alignment | .sam |
 | Platypus Variant Calling | Binary Alignment | .bam | 

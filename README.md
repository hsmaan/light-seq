# Light-Seq DNA Sequence Analysis Pipeline

## Overview

Light-Seq is a sequencing analysis pipeline that takes in reads in the form of FASTA files (or downstream files) and outputs variant-calling files (VCF). The pipeline can take input at various steps and is quite versatile. It can perform demultiplexing, adapter trimming, reference genome indexing, read alignment, read mapping and indexing, and variant calling. 

Light-Seq will prompt the user to declare the task using the command-line interface and specify the file-paths necessary. In each case, the resulting output will be a VCF file after variant calling is done. 

## Requirements

Light-Seq relies on various tools that are assumed to be installed on the user's machine.

[Sabre for demultiplexing] (https://github.com/najoshi/sabre)

[AfterQC for trimming and quality control] (https://github.com/OpenGene/AfterQC)

[BWA for reference and read alignment] (https://github.com/lh3/bwa)

[Samtools for SAM to BAM conversion] (http://www.htslib.org/)

[Platypus for variant calling] (https://github.com/andyrimmer/Platypus)


## Installation



![RNA-seq Flowchart - Module 2](Images/RNA-seq_Flowchart2.png)

#2-v. RNAseq Data
## Obtain RNA-seq test data. 
 
The test data consists of two commercially available RNA samples: Universal Human Reference (UHR) and Human Brain Reference (HBR).  In addition, a spike-in control was used called ERCC ExFold. Mix1 and Mix2 have 3 replicates each. 

ADD MORE EXPERIMENTAL DESIGN BACKGROUND
	
Each data set has a corresponding pair of fastq files (read 1 and read 2 of paired end reads).  
The reads are paired-end 101-mers generated on an Illumina HiSeq instrument.
The test data has been pre-filtered for reads that appear to map to chromosome 22

	cd $RNA_HOME/
	mkdir -p data
	cd data
	
Make a copy of the test data

	wget https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/brain_vs_uhr_w_ercc/downsampled_5pc_chr22/HBR_UHR_ERCC_ds_5pc.tar
	
Unpack the test data.  You should see 6 sets of paired end fastq files

	tar -xvf HBR_UHR_ERCC_ds_5pc.tar
	
Enter the data directory and view the first two read records of a file (in fastq format each read corresponds to 4 lines of data)

	zcat UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz | head -n 8
	
Identify the following components of each read: read name, read sequence, and quality string
	
How many reads are there in the first library?
Decompress file on the fly with 'zcat', pipe into 'grep', search for the read name prefix and pipe into 'wc' to do a word count ('-l' gives lines)

	zcat UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz | grep -P "^\@HWI" | wc -l

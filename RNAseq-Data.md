# RNAseq Data
## Obtain RNA-seq test data.  
The test data consists of colon cancer libraries for a Tumor and matched Normal comparison.  
Tumor and Normal have 4 replicates each.  
Each replicate actually corresponds to a different library preparation method using the same input RNAs.  
Each library is marked as either cDNA-1 or cDNA2 and either lib1 or lib2
cDNA-1 = total RNA (total)
cDNA-2 = polyA selected RNA (polyA)
lib1 = standard RNAseq (nocap)
lib2 = cDNA capture RNAseq where library was enriched using probes targeting the exome (cap).
e.g., The library called: *-Normal-cDNA-1-lib1 was constructed from total RNA and sequenced by standard RNAseq protocol (without cDNA capture).
2 conditions (Normal/Tumor) x 4 replicates (total_nocap/total_cap/polyA_nocap/polyA_cap) = 8 sets of data.
	
In this tutorial we will just compare the two cDNA capture libraries (lib2) from tumor vs normal (2 conditions with 2 "replicates" = 4 samples in total)
	
Each data set has a corresponding pair of fastq files (read 1 and read 2 of paired end reads).  
The reads are paired-end 101-mers generated on an Illumina HiSeq instrument.
The test data has been pre-filtered for reads that appear to map to chromosome 22

	cd $RNA_HOME/
	mkdir -p data
	cd data
	
Make a copy of the test data

	wget https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/colon_tumor_vs_normal/downsampled_10pc_chr22/OvationV2_ds_10pc.tar
	
Unpack the test data.  You should see 12 sets of paired end fastq files
	tar -xvf OvationV2_ds_10pc.tar
	
Enter the data directory and view the first two read records of a file (in fastq format each read corresponds to 4 lines of data)

	zcat H_KH-540077-Normal-cDNA-1-lib1_ds_10pc_1.fastq.gz | head -n 8
	zcat H_KH-540077-Normal-cDNA-1-lib1_ds_10pc_2.fastq.gz | head -n 8
	
Identify the following components of each read: read name, read sequence, and quality string
	
How many reads are there in the first library?
Decompress file on the fly with 'zcat', pipe into 'grep', search for the read name prefix and pipe into 'wc' to do a word count ('-l' gives lines)

	zcat H_KH-540077-Normal-cDNA-1-lib1_ds_10pc_1.fastq.gz | grep -P "^\@HWI" | wc -l
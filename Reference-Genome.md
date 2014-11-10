#Reference Genome
Obtain a reference genome from iGenomes.  In this example analysis we will use the human hg19/NCBI build 37 version of the genome  
In this tutorial we are actually going to perform the analysis using only a single chromosome (chr22) and the ERCC spike-in to make it run faster...

Create the necessary working directory

	cd $RNA_HOME
	mkdir -p refs/hg19/fasta/22/
	cd refs/hg19/fasta/22/
	
Make a copy of chr22 fasta from the CourseData directory to your working directory
The complete data from which these files were obtained can be found at: http://cufflinks.cbcb.umd.edu/igenomes.html
You could use wget to download the Homo_sapiens_Ensembl_GRCh37.tar.gz file (under Homo sapiens -> Ensembl -> GRCh37), then unzip/untar.

This has been done for you and that data placed on an ftp server. Download it now.

     wget https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/brain_vs_uhr_w_ercc/downsampled_5pc_chr22/chr22_ERCC92.fa.gz
     gunzip chr22_ERCC92.fa.gz
	
View the first 10 lines of this file

	head chr22_ERCC92.fa
	
How many lines and characters are in this file?

	wc chr22_ERCC92.fa
	
To get all chromosomes instead of just chr22 you could do the following:

```
cd $RNA_HOME
mkdir -p refs/hg19/fasta/
cd refs/hg19/fasta/
cp /media/cbwdata/CourseData/RNA_data/iGenomes/Homo_sapiens/Ensembl/GRCh37/Sequence/Chromosomes/* .
cat *.fa > hg19.fa
```

Note: Instead of the above, you might consider getting reference genomes and associated annotations from UCSC  
e.g., ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/  
Wherever you get them from, the names of your reference sequences (chromosomes) must those matched in your annotation gtf files.

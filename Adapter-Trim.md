![RNA-seq Flowchart - Module 3](Images/RNA-seq_Flowchart3.png)

#3-i. Adapter Trim
Use Flexbar to trim sequence adapter from the read FASTQ files.  The output of this step will be trimmed FASTQ files for each data set.

Refer to TopHat manual and tutorial for a more detailed explanation:
http://sourceforge.net/projects/flexbar/
http://sourceforge.net/p/flexbar/wiki/Manual/

Flexbar basic usage:
```
#flexbar -r reads [-t target] [-b barcodes] [-a adapters] [options]
```
	
Extra options specified below:

* --minimum-adapter-length 7
* 

##Flexbar trim
	
	cd $RNA_HOME/
	export RNA_DATA_DIR=$RNA_HOME/data/
	echo $RNA_DATA_DIR
	
	mkdir -p $RNA_DATA_DIR/trimmed
        export RNA_DATA_TRIM_DIR=$RNA_DATA_DIR/trimmed
        echo $RNA_DATA_TRIM_DIR
	
In our tests, each sample took ~30 seconds to trim
	
        flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters /gscmnt/gc7004/info/illumina_adapters/illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads $RNA_DATA_DIR/UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz --reads2 $RNA_DATA_DIR/UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz --target $RNA_DATA_TRIM_DIR/UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22
        flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters /gscmnt/gc7004/info/illumina_adapters/illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads $RNA_DATA_DIR/UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz --reads2 $RNA_DATA_DIR/UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz --target $RNA_DATA_TRIM_DIR/UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22
        flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters /gscmnt/gc7004/info/illumina_adapters/illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads $RNA_DATA_DIR/UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz --reads2 $RNA_DATA_DIR/UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz --target $RNA_DATA_TRIM_DIR/UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22
        

	flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters /gscmnt/gc7004/info/illumina_adapters/illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz --reads2 $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz --target $RNA_DATA_TRIM_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22
        flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters /gscmnt/gc7004/info/illumina_adapters/illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads $RNA_DATA_DIR/HBR_Rep2_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz --reads2 $RNA_DATA_DIR/HBR_Rep2_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz --target $RNA_DATA_TRIM_DIR/HBR_Rep2_ERCC-Mix2_Build37-ErccTranscripts-chr22
        flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters /gscmnt/gc7004/info/illumina_adapters/illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads $RNA_DATA_DIR/HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz --reads2 $RNA_DATA_DIR/HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz --target $RNA_DATA_TRIM_DIR/HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22	


| [[Previous Section|PreAlignment-QC]] | [[This Section|Adapter Trim]] | [[Next Section|Alignment]] |
|:------------------------------------:|:--------------------------:|:--------------------------------------------:|
| [[Data QC|PreAlignment-QC]]          | [[Adapter Trim|Adapter-Trim]]    | [[Alignment|Alignment]]         |

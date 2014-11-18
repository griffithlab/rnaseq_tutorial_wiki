![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#5-i. Reference Guided Transcript Assembly
Note on de novo transcript discovery and differential expression using Cufflinks and Cuffdiff.

In the previous module we ran Cufflinks in 'reference only' mode using the '-G/--GTF' Cufflinks option.
	
In this module we will run Cufflinks in two additional modes: (1) 'reference guided' mode and (2) 'de novo' mode. Cufflinks can predict the transcripts present in each library with or without help from knowledge of known transcripts. Cufflinks will then assign arbitrary transcript IDs to each transcript assembled from the data and estimate expression for those transcripts. One complication with this method is that in each library a different set of transcripts is likely to be predicted for each library. There may be a lot of similarities but the number of transcripts and their exact structure will differ in the output files for each library.  Before you can compare across libraries you therefore need to determine which transcripts correspond to each other across the libraries. Cufflinks provides 'cuffmerge' to combine predicted transcript GTF files from across different libraries.

Once you have a merged GTF file you can run Cuffdiff with this instead of the known transcripts GTF file we used above.
	
To run Cufflinks in 'reference guided' mode: use the '-g/--GTF-guide' option

To run Cufflinks in 'de novo' mode do *not* specify either of the '-G/--GTF' OR '-g/--GTF-guide' options. 
	
Refer to the Cufflinks manual for a more detailed explanation:
http://cufflinks.cbcb.umd.edu/manual.html
	
 Cufflinks basic usage:
 cufflinks [options] <hits.sam>
	
###Running Cufflinks in Reference Guided Mode
Using the alignments we generated in the previous modules we will now run Cuffinks in reference guided mode using the '-g/--GTF-guide' option.

Extra options specified below
* '-p 8' tells Cufflinks to use eight CPUs
* '-g/--GTF-guide <known transcripts file>' Tells Cufflinks to consider known transcript annotations during the assembly process
* '-o' tells Cufflinks to write output to a particular directory (one per sample)
	
	cd $RNA_HOME/expression/
	mkdir -p tophat_cufflinks/ref_guided
	cd tophat_cufflinks/ref_guided
	
	cufflinks -p 8 -o HBR_Rep1_ERCC-Mix2 --GTF-guide $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/HBR_Rep1_ERCC-Mix2/accepted_hits.bam
	cufflinks -p 8 -o HBR_Rep2_ERCC-Mix2 --GTF-guide $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/HBR_Rep2_ERCC-Mix2/accepted_hits.bam
	cufflinks -p 8 -o HBR_Rep3_ERCC-Mix2 --GTF-guide $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/HBR_Rep3_ERCC-Mix2/accepted_hits.bam

	cufflinks -p 8 -o UHR_Rep1_ERCC-Mix1 --GTF-guide $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/UHR_Rep1_ERCC-Mix1/accepted_hits.bam
	cufflinks -p 8 -o UHR_Rep2_ERCC-Mix1 --GTF-guide $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/UHR_Rep2_ERCC-Mix1/accepted_hits.bam
	cufflinks -p 8 -o UHR_Rep3_ERCC-Mix1 --GTF-guide $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/UHR_Rep3_ERCC-Mix1/accepted_hits.bam

| [[Previous Section|DE-Visualization]] | [[This Section|Reference-Guided-Transcript-Assembly]] | [[Next Section|de-novo-Transcript-Assembly]] |
|:-------------------------------------:|:-----------------------------------------------------:|:--------------------------------------------:|
| [[DE Visualization|DE-Visualization]] | [[Ref Guided|Reference-Guided-Transcript-Assembly]]   | [[De novo|de-novo-Transcript-Assembly]]      |
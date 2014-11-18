![RNA-seq Flowchart - Module 3](Images/RNA-seq_Flowchart3.png)

#3-iii. Post-Alignment QC
##Use samtools, samstat, and FastQC to evaluate the alignments

Use `samtools view` to see the format of a SAM/BAM alignment file

	cd $RNA_HOME/alignments/tophat/UHR_ERCC-Mix1_ALL
	samtools view -H accepted_hits.bam
	samtools view accepted_hits.bam | head
	
Try filtering the BAM file to require or exclude certain flags. This can be done with `samtools view -f -F` options

 -f INT   required flag  
 -F INT   filtering flag  

"Samtools flags explained"
* http://broadinstitute.github.io/picard/explain-flags.html

Try requiring that alignments are 'paired' and 'mapped in a proper pair' (=3). Also filter out alignments that are 'unmapped', the 'mate is unmapped', and 'not primary alignment' (=268)

	samtools view -f 3 -F 268 accepted_hits.bam | head
	
Now require that the alignments be only for 'PCR or optical duplicate'. How many reads meet this criteria? Why?

	samtools view -f 1024 accepted_hits.bam | head
	
Use `samtools flagstat` to get a basic summary of an alignment.  What percent of reads are mapped? Is this realistic? Why?

	cd $RNA_HOME/alignments/tophat/
	samtools flagstat UHR_Rep1_ERCC-Mix1/accepted_hits.bam
	samtools flagstat UHR_Rep1_ERCC-Mix1//accepted_hits.bam
	
Run `samstat` on UHR/HBR BAMs

	cd $RNA_HOME/alignments/tophat/
	samstat UHR_ERCC-Mix1_ALL/accepted_hits.bam
	samstat HBR_ERCC-Mix2_ALL/accepted_hits.bam

This may cause a segfault and produce incomplete results. If so you can try downloading an older version of the samstat software:

	cd ~/bin
	wget https://dl.dropboxusercontent.com/u/16769159/samstat
	cd $RNA_HOME/alignments/tophat/
	~/bin/samstat UHR_ERCC-Mix1_ALL/accepted_hits.bam
	~/bin/samstat HBR_ERCC-Mix2_ALL/accepted_hits.bam
	
View the `samstat` summary file in a web browser. Note, you must replace ## with your own amazon instance number (e.g., "01")):  
* http://cshl##.dyndns.org/workspace/rnaseq/alignments/tophat/UHR_ERCC-Mix1_ALL/accepted_hits.bam.samstat.html  
* http://cshl##.dyndns.org/workspace/rnaseq/alignments/tophat/HBR_ERCC-Mix2_ALL/accepted_hits.bam.samstat.html  
	
Details of the SAM/BAM format can be found here:  
http://samtools.sourceforge.net/SAM1.pdf

##Using FastQC
You can use FastQC to perform basic QC of your accepted_hits.bam file (See [Pre-Alignment QC](https://github.com/griffithlab/rnaseq_tutorial/wiki/PreAlignment-QC)). This will give you output very similar to when you ran FastQC on your fastq files.  

| [[Previous Section|PostAlignment-Visualization]]        | [[This Section|PostAlignment-QC]] | [[Next Section|Expression]]      |
|:-------------------------------------------------------:|:---------------------------------:|:---------------------------------------------:|
| [[Alignment Visualization|PostAlignment-Visualization]] | [[Alignment QC|PostAlignment-QC]] | [[Expression|Expression]] |
	

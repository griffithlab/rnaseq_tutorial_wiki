![RNA-seq Flowchart - Module 3](Images/RNA-seq_Flowchart3.png)

#3-ii. Post-Alignment Visualization
Index BAM files to allow viewing in IGV (using samtools index)

      cd $RNA_HOME
      export RNA_ALIGN_DIR=$RNA_HOME/alignments/tophat/
      echo $RNA_ALIGN_DIR
      cd $RNA_ALIGN_DIR
	
Display samtools index commands to be run (i.e. 'echo' the command that will be executed by unix find)
You could copy and paste these commands to run them, or repeat the find command without the 'echo' as below

    find $RNA_ALIGN_DIR*/accepted_hits.bam -exec echo samtools index {} \;
	        
Now run the index commands

    find $RNA_ALIGN_DIR*/accepted_hits.bam -exec samtools index {} \;

---
###OPTIONAL ALTERNATIVE
Create comparable files for the STAR alignments

       cd $RNA_HOME
       export STAR_ALIGN_DIR=$RNA_HOME/alignments/star/
       echo $STAR_ALIGN_DIR
       cd $STAR_ALIGN_DIR
       find $STAR_ALIGN_DIR*/Aligned.out.sorted.bam -exec samtools index {} \;
---

##Visualize alignments
Start IGV on your laptop. Load the UHR_ERCC-Mix1_ALL & HBR_ERCC-Mix2_ALL BAM files (accepted_hits.bam) in IGV. You can load the necessary files in IGV directly from your web accessible amazon workspace (see below) using 'File' -> 'Load from URL'. You may wish to customize the track names as you load them in to keep them straight. Do this by right-clicking on the alignment track and choosing 'Rename Track'. Note, you must replace cbw## with your own amazon instance number (e.g., "cbw01")).
* http://cbw##.ssh01.com/rnaseq/alignments/tophat/UHR_ERCC-Mix1_ALL/accepted_hits.bam (UHR Tophat)
* http://cbw##.ssh01.com/rnaseq/alignments/tophat/HBR_ERCC-Mix2_ALL/accepted_hits.bam (HBR Tophat)

Go to an example gene locus on chr22:
 e.g. EIF3L, NDUFA6, RBX1 have nice coverage
 e.g. MMP11 and TST are differentially expressed. Are they up-regulated or down-regulated in the tumor?
 Mouse over some reads and use the read group (RG) flag to determine which protocol the reads come from.

---
###OPTIONAL ALTERNATIVE
Now load the STAR alignments. How do the STAR and TopHat alignments compare?

* http://cbw##.ssh01.com/rnaseq/alignments/star/UHR_ERCC-Mix1_ALL/Aligned.out.sorted.bam (Normal STAR)
* http://cbw##.ssh01.com/rnaseq/alignments/star/HBR_ERCC-Mix2_ALL/Aligned.out.sorted.bam (Tumor STAR)

---

Try to find a variant position in the RNAseq data:  
HINT: DDX17 is a highly expressed gene with several variants in its 3' UTR.  
Other highly expressed genes you might explore are: NUP50, CYB5R3, and EIF3L (all have at least one transcribed variant).  
Are these variants previously known (e.g., present in dbSNP)?  
Homozygous or heterozygous?  
Germline or somatic?  
Do they display allele-specific expression?  
Take note of the genomic position of your variant. We will need this later.  
	
##BAM READ COUNTING
Using one of the variant positions identified above, count the number of supporting reference and variant reads
First, use samtools mpileup to visualize a region of alignment with a variant

       cd $RNA_HOME
       mkdir bam_readcount
       cd bam_readcount
	
Create list of bam files to process

       find $RNA_HOME/alignments/tophat/*_ALL/accepted_hits.bam > bamfilelist.txt
	
Create faidx indexed reference sequence file for use with mpileup

       samtools faidx $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/chr22_ERCC92.fa
	
Run samtools mpileup on a region of interest

    samtools mpileup -b bamfilelist.txt -f $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/chr22_ERCC92.fa -r 22:18905970-18905980
	
See samtools pileup/mpileup documentation for explanation of output
 http://samtools.sourceforge.net/pileup.shtml
 http://samtools.sourceforge.net/mpileup.shtml
	
Now, use bam-readcount to count reference and variant bases at a specific position
First, create a bed file with some positions of interest (We will create a file called snvs.bed using the echo command)
It will contains a single line specify a variant position on chr22 and position 18905977.  i.e.:
22	38879688	38879688
	
Create the bed file

       echo "22 38879688 38879688"
       echo "22 38879688 38879688" > snvs.bed
	
Run bam-readcount on this list for the tumor and normal merged bam files

    bam-readcount -l snvs.bed -f $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/chr22_ERCC92.fa $RNA_HOME/alignments/tophat/UHR_ERCC-Mix1_ALL/accepted_hits.bam 2>/dev/null
    bam-readcount -l snvs.bed -f $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/chr22_ERCC92.fa $RNA_HOME/alignments/tophat/HBR_ERCC-Mix2_ALL/accepted_hits.bam 2>/dev/null

Now, run again, but ignore stderr and redirect stdout to file:

     bam-readcount -l snvs.bed -f $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/chr22_ERCC92.fa $RNA_HOME/alignments/tophat/UHR_ERCC-Mix1_ALL/accepted_hits.bam 2>/dev/null 1>UHR_bam-readcounts.txt
     bam-readcount -l snvs.bed -f $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/chr22_ERCC92.fa $RNA_HOME/alignments/tophat/HBR_ERCC-Mix2_ALL/accepted_hits.bam 2>/dev/null 1>HBR_bam-readcounts.txt
	
From this output you could parse the read counts for each base

     cat UHR_bam-readcounts.txt | perl -ne '@data=split("\t", $_); @Adata=split(":", $data[5]); @Cdata=split(":", $data[6]); @Gdata=split(":", $data[7]); @Tdata=split(":", $data[8]); print "$data[0]\t$data[1]\tA: $Adata[1]\tC: $Cdata[1]\tT: $Tdata[1]\tG: $Gdata[1]\n";'
     cat HBR_bam-readcounts.txt | perl -ne '@data=split("\t", $_); @Adata=split(":", $data[5]); @Cdata=split(":", $data[6]); @Gdata=split(":", $data[7]); @Tdata=split(":", $data[8]); print "$data[0]\t$data[1]\tA: $Adata[1]\tC: $Cdata[1]\tT: $Tdata[1]\tG: $Gdata[1]\n";'

| [[Previous Section|Alignment]] | [[This Section|PostAlignment-Visualization]]            | [[Next Section|PostAlignment-QC]] |
|:------------------------------:|:-------------------------------------------------------:|:-------------------------------------------------:|
| [[Alignment|Alignment]]        | [[Alignment Visualization|PostAlignment-Visualization]] | [[Alignment QC|PostAlignment-QC]]      |

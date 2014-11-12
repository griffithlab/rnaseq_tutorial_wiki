#Alignment
Use Bowtie2/Tophat2 to align all pairs of read files to the genome.  The output of this step will be a SAM/BAM files for each data set.

Refer to TopHat manual and tutorial for a more detailed explanation:
http://tophat.cbcb.umd.edu/manual.html
http://tophat.cbcb.umd.edu/tutorial.html
	
TopHat basic usage
tophat [options] <bowtie_index> <lane1_reads1[,lane2_reads1,...]> <lane1_reads2[,lane2_reads2,...]> 
	
Extra options specified below:
'-p 8' tells TopHat to use eight CPUs for bowtie alignments
'-r 150' tells TopHat the expected inner distance between the reads of a pair. [fragment size - (2*read length)].  300 - (2*80) = 140 
'-o' tells TopHat to write the output to a particular directory (one per sample)
'--rg-id' specifies a read group ID
'--rg-sample' specified a read group sample ID. This together with rg-id will allow you to determine which reads came from which library in the merged bam later on
'-G <known transcripts file>' supplies a list of known transcript models.  These will be used to help TopHat measure known exon-exon connections (novel connections will still be predicted)
Note that the '-G' option for TopHat has a different meaning than the '-G' option of Cufflinks that we will use in step 9 later
'--transcriptome-index'  TopHat will align to both the transcriptome and genome and figure out the 'best' alignments for you.  
In order to perform alignments to the transcriptome, an index must be created as we did for the genome.  
This parameter tells TopHat where to store it and allows it to be reused in multiple TopHat runs. 

##TopHat alignment
	
	cd $RNA_HOME/
	export RNA_DATA_DIR=$RNA_HOME/data/
	echo $RNA_DATA_DIR
	
	mkdir -p alignments/tophat/trans_idx
	cd alignments/tophat
	export TRANS_IDX_DIR=$RNA_HOME/alignments/tophat/trans_idx/
	echo $TRANS_IDX_DIR
	
In our tests, each sample took ~1-1.5 minutes to align

	tophat2 -p 8 -r 60 --rg-id=HBR_Rep1 --rg-sample=HBR_Rep1_ERCC-Mix2 -o HBR_Rep1_ERCC-Mix2 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz
	tophat2 -p 8 -r 60 --rg-id=HBR_Rep2 --rg-sample=HBR_Rep2_ERCC-Mix2 -o HBR_Rep2_ERCC-Mix2 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/HBR_Rep2_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/HBR_Rep2_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz
	tophat2 -p 8 -r 60 --rg-id=HBR_Rep3 --rg-sample=HBR_Rep3_ERCC-Mix2 -o HBR_Rep3_ERCC-Mix2 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz
	
	tophat2 -p 8 -r 60 --rg-id=UHR_Rep1 --rg-sample=UHR_Rep1_ERCC-Mix1 -o UHR_Rep1_ERCC-Mix1 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz
	tophat2 -p 8 -r 60 --rg-id=UHR_Rep2 --rg-sample=UHR_Rep2_ERCC-Mix1 -o UHR_Rep2_ERCC-Mix1 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz
	tophat2 -p 8 -r 60 --rg-id=UHR_Rep3 --rg-sample=UHR_Rep3_ERCC-Mix1 -o UHR_Rep3_ERCC-Mix1 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz
	
Note: in the above alignments, we are treating each library as an independent data set.  If you had multiple lanes of data for a single library, you would want to align them all together in one TopHat command
Similarly you might combine technical replicates into a single alignment run (perhaps after examining them and removing outliers...)
To combine multiple lanes, you would provide all the read1 files as a comma separated list, followed by a space, and then all read2 files as a comma separated list (where both lists have the same order):
You can also use samtools merge to combine bam files after alignment. This is the approach we will take.
	
##OPTIONAL STAR alignment
perform alignments with STAR
STAR alignment results can be used for Cufflinks analysis or other further RNA-seq analysis
Some further optional parameter might be needed though (see STAR manual: 8.2.3: XS SAM strand attribute for Cufflinks/Cuffdiff).
	
	cd $RNA_HOME/
	mkdir -p alignments/star
	cd alignments/star
	mkdir Normal_cDNA1_lib2 Normal_cDNA2_lib2 Tumor_cDNA1_lib2 Tumor_cDNA2_lib2
	
	STAR --genomeDir $RNA_HOME/refs/hg19/star/22 --readFilesIn $RNA_DATA_DIR/H_KH-540077-Normal-cDNA-1-lib2_ds_10pc_1.fastq.gz $RNA_DATA_DIR/H_KH-540077-Normal-cDNA-1-lib2_ds_10pc_2.fastq.gz --runThreadN 8 --readFilesCommand zcat --outFileNamePrefix Normal_cDNA1_lib2/ --outSAMstrandField intronMotif
	STAR --genomeDir $RNA_HOME/refs/hg19/star/22 --readFilesIn $RNA_DATA_DIR/H_KH-540077-Normal-cDNA-2-lib2_ds_10pc_1.fastq.gz $RNA_DATA_DIR/H_KH-540077-Normal-cDNA-2-lib2_ds_10pc_2.fastq.gz --runThreadN 8 --readFilesCommand zcat --outFileNamePrefix Normal_cDNA2_lib2/ --outSAMstrandField intronMotif
	STAR --genomeDir $RNA_HOME/refs/hg19/star/22 --readFilesIn $RNA_DATA_DIR/H_KH-540077-Tumor-cDNA-1-lib2_ds_10pc_1.fastq.gz $RNA_DATA_DIR/H_KH-540077-Tumor-cDNA-1-lib2_ds_10pc_2.fastq.gz --runThreadN 8 --readFilesCommand zcat --outFileNamePrefix Tumor_cDNA1_lib2/ --outSAMstrandField intronMotif
	STAR --genomeDir $RNA_HOME/refs/hg19/star/22 --readFilesIn $RNA_DATA_DIR/H_KH-540077-Tumor-cDNA-2-lib2_ds_10pc_1.fastq.gz $RNA_DATA_DIR/H_KH-540077-Tumor-cDNA-2-lib2_ds_10pc_2.fastq.gz --runThreadN 8 --readFilesCommand zcat --outFileNamePrefix Tumor_cDNA2_lib2/ --outSAMstrandField intronMotif
	
Convert to bam files (required for cufflinks)

	samtools view -b -S Normal_cDNA1_lib2/Aligned.out.sam > Normal_cDNA1_lib2/Aligned.out.bam
	samtools view -b -S Normal_cDNA2_lib2/Aligned.out.sam > Normal_cDNA2_lib2/Aligned.out.bam
	samtools view -b -S Tumor_cDNA1_lib2/Aligned.out.sam > Tumor_cDNA1_lib2/Aligned.out.bam
	samtools view -b -S Tumor_cDNA2_lib2/Aligned.out.sam > Tumor_cDNA2_lib2/Aligned.out.bam
	
Now sort the bam files (also required for cufflinks)

	samtools sort Normal_cDNA1_lib2/Aligned.out.bam Normal_cDNA1_lib2/Aligned.out.sorted
	samtools sort Normal_cDNA2_lib2/Aligned.out.bam Normal_cDNA2_lib2/Aligned.out.sorted
	samtools sort Tumor_cDNA1_lib2/Aligned.out.bam Tumor_cDNA1_lib2/Aligned.out.sorted
	samtools sort Tumor_cDNA2_lib2/Aligned.out.bam Tumor_cDNA2_lib2/Aligned.out.sorted

##Merge TopHat bam files	
Make one glorious BAM combining all Tumor data and another for all Normal data
Note: This could be done in several ways such as 'samtools merge', 'bamtools merge', or using picard-tools (see below). We chose the third method because it did the best job at merging the bam header information

Normal

	cd $RNA_HOME/alignments/tophat
	mkdir Normal_ALL
	java -Xmx2g -jar $RNA_HOME/tools/picard-tools-1.114/MergeSamFiles.jar OUTPUT=Normal_ALL/accepted_hits.bam INPUT=Normal_cDNA1_lib2/accepted_hits.bam INPUT=Normal_cDNA2_lib2/accepted_hits.bam
	
Tumor

	mkdir Tumor_ALL
	java -Xmx2g -jar $RNA_HOME/tools/picard-tools-1.114/MergeSamFiles.jar OUTPUT=Tumor_ALL/accepted_hits.bam INPUT=Tumor_cDNA1_lib2/accepted_hits.bam INPUT=Tumor_cDNA2_lib2/accepted_hits.bam
	
Count the alignment (BAM) files to make sure all were created successfully (you should have 6 total)

	ls -l */accepted_hits.bam | wc -l
	ls -l */accepted_hits.bam
	
##OPTIONAL - Merge STAR bam files
Create comparable files for the STAR alignments by merging individual bam files generated by STAR

	cd $RNA_HOME/alignments/star
	mkdir Normal_ALL
	java -Xmx2g -jar $RNA_HOME/tools/picard-tools-1.114/MergeSamFiles.jar OUTPUT=Normal_ALL/Aligned.out.sorted.bam INPUT=Normal_cDNA1_lib2/Aligned.out.sorted.bam INPUT=Normal_cDNA2_lib2/Aligned.out.sorted.bam
	mkdir Tumor_ALL
	java -Xmx2g -jar $RNA_HOME/tools/picard-tools-1.114/MergeSamFiles.jar OUTPUT=Tumor_ALL/Aligned.out.sorted.bam INPUT=Tumor_cDNA1_lib2/Aligned.out.sorted.bam INPUT=Tumor_cDNA2_lib2/Aligned.out.sorted.bam
	
	
##PRACTICAL EXERCISE
Perform some alignments on an additional pair of read data sets
Do this in a separate working directory called ‘temp’!
In this exercise you will download some publicly available read data in *BAM* format, convert this to FASTQ format and compress it
Then you will align the reads using the skills you learned above.  Try using Tophat or STAR or both aligners.
	cd $RNA_HOME
	mkdir temp
	cd $RNA_HOME/temp
	wget https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/hcc1395_1tenth_percent/gerald_C2DBEACXX_3.bam
	mv gerald_C2DBEACXX_3.bam hcc1395_normal.bam
	java -Xmx2g -jar $RNA_HOME/tools/picard-tools-1.114/SamToFastq.jar INPUT=hcc1395_normal.bam FASTQ=hcc1395_normal_1.fastq SECOND_END_FASTQ=hcc1395_normal_2.fastq
	wc -l hcc1395_normal_*.fastq
	wget https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/hcc1395_1tenth_percent/gerald_C1TD1ACXX_8_ACAGTG.bam
	mv gerald_C1TD1ACXX_8_ACAGTG.bam hcc1395_tumor.bam
	java -Xmx2g -jar $RNA_HOME/tools/picard-tools-1.114/SamToFastq.jar INPUT=hcc1395_tumor.bam FASTQ=hcc1395_tumor_1.fastq SECOND_END_FASTQ=hcc1395_tumor_2.fastq
	wc -l hcc1395_tumor_*.fastq
	gzip *.fastq
	
	
	
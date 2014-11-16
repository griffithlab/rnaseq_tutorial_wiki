![RNA-seq Flowchart - Module 2](Images/RNA-seq_Flowchart2.png)

#2-iv. Indexing

###Create a bowtie index

Create a bowtie index for chr22 and the ERCC spike-in sequences and write it to a 'bwt' sub-directory:

	cd $RNA_HOME/refs/hg19/
	mkdir -p bwt/chr22_ERCC92
	bowtie2-build fasta/chr22_ERCC92/chr22_ERCC92.fa bwt/chr22_ERCC92/chr22_ERCC92
	cp $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/*.fa $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/
	ls bwt/chr22_ERCC92/
	
To create an index for all chromosomes instead of just chr22 you would do the following:
```
cd $RNA_HOME/refs/hg19/
mkdir bwt
bowtie2-build fasta/hg19.fa bwt/hg19
mv $RNA_HOME/refs/hg19/fasta/hg19.fa $RNA_HOME/refs/hg19/bwt/
```

---
###OPTIONAL ALTERNATIVE
Create index files for use with STAR

	cd $RNA_HOME/refs/hg19/
	mkdir -p star/chr22_ERCC92
	STAR --runMode genomeGenerate --genomeDir $RNA_HOME/refs/hg19/star/chr22_ERCC92 --genomeFastaFiles $RNA_HOME/refs/hg19/fasta/chr22_ERCC92/chr22_ERCC92.fa --runThreadN 8 --sjdbGTFfile $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --sjdbOverhang 100
---
	
| [[Previous Section|Annotation]] | [[This Section|Indexing]]   | [[Next Section|RNAseq-Data]] |
|:-------------------------------:|:---------------------------:|:----------------------------:|
| [[Annotation|Annotation]]       | [[Indexing|Indexing]]       | [[Data|RNAseq-Data]]         |
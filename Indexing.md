#INDEXING
Create a bowtie index of the genome and write it to a 'bwt' sub-directory

Create a bowtie index for chr22 only
	cd $RNA_HOME/refs/hg19/
	mkdir -p bwt/22
	bowtie2-build fasta/22/22.fa bwt/22/22
	cp $RNA_HOME/refs/hg19/fasta/22/22.fa $RNA_HOME/refs/hg19/bwt/22/22.fa
	ls bwt/22/
	
To create an index for all chromosomes instead of just chr22 you would do the following:
```
cd $RNA_HOME/refs/hg19/
mkdir bwt
bowtie-build fasta/hg19.fa bwt/hg19
mv $RNA_HOME/refs/hg19/fasta/hg19.fa $RNA_HOME/refs/hg19/bwt/
```

##OPTIONAL
Create genome files for use with STAR
	cd $RNA_HOME/refs/hg19/
	mkdir -p star/22
	STAR --runMode genomeGenerate --genomeDir $RNA_HOME/refs/hg19/star/22 --genomeFastaFiles $RNA_HOME/refs/hg19/fasta/22/22.fa --runThreadN 8 --sjdbGTFfile $RNA_HOME/refs/hg19/genes/genes_chr22.gtf --sjdbOverhang 100
	
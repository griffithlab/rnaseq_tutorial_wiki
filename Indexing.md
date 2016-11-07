![RNA-seq Flowchart - Module 2](Images/RNA-seq_Flowchart2.png)

#1-iv. Indexing

###Create a HISAT2 index

Create a HISAT2 index for chr22 and the ERCC spike-in sequences. HISAT2 can incoroprate the exons and splice sites into the index file for alignment.  First create a splice site file, then an exon file.  Finally make the aligner FM index.

TODO: How is the HISAT2 index uniqe from other next gen aligners?

```bash

cd $RNA_HOME/refs/hg19/
mkdir -p hisat2/chr22_ERCC92
hisat2_extract_splice_sites.py $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf > $RNA_HOME/refs/hg19/hisat2/chr22_ERCC92/splicesites.tsv
hisat2_extract_exons.py $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf > $RNA_HOME/refs/hg19/hisat2/chr22_ERCC92/exons.tsv
hisat2-build -p 8 --ss $RNA_HOME/refs/hg19/hisat2/chr22_ERCC92/splicesites.tsv --exon $RNA_HOME/refs/hg19/hisat2/chr22_ERCC92/exons.tsv $RNA_HOME/refs/hg19/fasta/chr22_ERCC92.fa $RNA_HOME/refs/hg19/hisat2/chr22_ERCC92

```

To create an index for all chromosomes instead of just chr22 you would do the following:

NOTE: The below example does NOT take advantage of adding the splice sites and exons to the index. If desired, you would make those files using the full GTF and add them to the command using the appropriate options.

```bash

cd $RNA_HOME/refs/hg19/
mkdir hisat2
hisat2-build -p 8 fasta/hg19.fa hisat2/hg19

```


| [[Previous Section|Annotation]] | [[This Section|Indexing]]   | [[Next Section|RNAseq-Data]] |
|:-------------------------------:|:---------------------------:|:----------------------------:|
| [[Annotations|Annotation]]       | [[Indexing|Indexing]]       | [[Data|RNAseq-Data]]         |

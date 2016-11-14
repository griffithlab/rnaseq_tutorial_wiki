![RNA-seq Flowchart - Module 1](Images/RNA-seq_Flowchart2.png)

#1-iv. Indexing

###Create a HISAT2 index

Create a HISAT2 index for chr22 and the ERCC spike-in sequences. HISAT2 can incorporate exons and splice sites into the index file for alignment.  First create a splice site file, then an exon file.  Finally make the aligner FM index.

TODO: How is the HISAT2 index unique from other next gen aligners?

```bash

cd $RNA_HOME
hisat2_extract_splice_sites.py $RNA_REF_GTF > $RNA_REFS_DIR/splicesites.tsv
hisat2_extract_exons.py $RNA_REF_GTF > $RNA_REFS_DIR/exons.tsv
hisat2-build -p 8 --ss $RNA_REFS_DIR/splicesites.tsv --exon $RNA_REFS_DIR/exons.tsv $RNA_REF_FASTA $RNA_REF_INDEX

```

**[OPTIONAL]**
To create an index for all chromosomes instead of just chr22 you would do the following:

**NOTE:** The below example does **NOT** take advantage of adding the splice sites and exons to the index. If desired, you would make those files using the full GTF and add them to the command using the appropriate options.

**WARNING:** In order to index the entire human genome, HISAT2 requires 160GB of RAM. Your AWS instance size will run out of RAM.

```bash

#cd /home/ubuntu/workspace/data/fasta/GRCh38
#hisat2-build -p 8 Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa Homo_sapiens.GRCh38.dna_sm.primary_assembly

```


| [[Previous Section|Annotation]] | [[This Section|Indexing]]   | [[Next Section|RNAseq-Data]] |
|:-------------------------------:|:---------------------------:|:----------------------------:|
| [[Annotations|Annotation]]       | [[Indexing|Indexing]]       | [[Data|RNAseq-Data]]         |

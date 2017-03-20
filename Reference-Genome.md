![RNA-seq Flowchart - Module 1](Images/RNA-seq_Flowchart2.png)

# 1-ii. Reference Genomes

Obtain a reference genome from Ensembl, iGenomes, NCBI or UCSC. In this example analysis we will use the human GRCh38 version of the genome from Ensembl. Furthermore, we are actually going to perform the analysis using only a single chromosome (chr22) and the ERCC spike-in to make it run faster...

Create the necessary working directory

```bash

cd $RNA_HOME
echo $RNA_REFS_DIR
mkdir -p $RNA_REFS_DIR

```

The complete data from which these files were obtained can be found at: ftp://ftp.ensembl.org/pub/release-86/fasta/homo_sapiens/dna/. You could use wget to download the Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz file, then unzip/untar.

This has been done for you and that data placed on your AWS instance. It contains chr22 and ERCC transcript fasta files in both a single combined file and individual files. Copy the file to the rnaseq working directory

```bash

cd $RNA_REFS_DIR
cp $RNA_EXT_DATA_DIR/fasta/GRCh38/chr22_with_ERCC92.fa .
ls 

```

View the first 10 lines of this file. Why does it look like this?

```bash

head chr22_with_ERCC92.fa

```

How many lines and characters are in this file? How long is this chromosome (in bases and Mbp)?

```bash

wc chr22_with_ERCC92.fa

```

View 10 lines from approximately the middle of this file. What is the significance of the upper and lower case characters?

```bash

head -n 425000 chr22_with_ERCC92.fa | tail

```

What is the count of each base in this chromosome?

```bash

cat chr22_with_ERCC92.fa | grep -v ">" | perl -ne 'chomp $_; $bases{$_}++ for split //; if (eof){print "$_ $bases{$_}\n" for sort keys %bases}'
```


Note: Instead of the above, you might consider getting reference genomes and associated annotations from UCSC. e.g., [USCS GRCh38 download](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/).

Wherever you get them from, remember that the names of your reference sequences (chromosomes) must those matched in your annotation gtf files (described in the next section).

| [[Previous Section|Installation]] | [[This Section|Reference-Genome]]      | [[Next Section|Annotation]] |
|:---------------------------------:|:--------------------------------------:|:---------------------------:|
| [[Installation|Installation]]     | [[Reference Genomes|Reference-Genome]] | [[Annotations|Annotation]]   |

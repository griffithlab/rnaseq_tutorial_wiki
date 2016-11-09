![RNA-seq Flowchart - Module 2](Images/RNA-seq_Flowchart2.png)

#1-ii. Reference Genomes

Obtain a reference genome from Ensembl, iGenomes, NCBI or UCSC. In this example analysis we will use the human GRCh38 version of the genome from Ensembl. Furthermore, we are actually going to perform the analysis using only a single chromosome (chr22) and the ERCC spike-in to make it run faster...

Create the necessary working directory

```bash

cd $RNA_HOME
mkdir -p $RNA_REFS_DIR
echo $RNA_REFS_DIR

```

The complete data from which these files were obtained can be found at: ftp://ftp.ensembl.org/pub/release-85/fasta/homo_sapiens/dna/. You could use wget to download the Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz file, then unzip/untar.

This has been done for you and that data placed on your AWS instance. It contains chr22 and ERCC transcript fasta files in both a single combined file and individual files. Copy the file to the rnaseq working directory

```bash

cd $RNA_REFS_DIR
cp /home/ubuntu/workspace/data/fasta/GRCh38/chr22_with_ERCC92.fa .
ls 

```

View the first 10 lines of this file

```bash

head $RNA_REF_FASTA

```

How many lines and characters are in this file?

```bash

wc $RNA_REF_FASTA

```

View 10 lines from approximately the middle of this file

```bash

head -n 425000 $RNA_REF_FASTA | tail

```

Note: Instead of the above, you might consider getting reference genomes and associated annotations from UCSC. e.g., http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/.
Wherever you get them from, the names of your reference sequences (chromosomes) must those matched in your annotation gtf files (described in the next section).

| [[Previous Section|Installation]] | [[This Section|Reference-Genome]]      | [[Next Section|Annotation]] |
|:---------------------------------:|:--------------------------------------:|:---------------------------:|
| [[Installation|Installation]]     | [[Reference Genomes|Reference-Genome]] | [[Annotations|Annotation]]   |

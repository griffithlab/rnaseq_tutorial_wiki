#5-iii. Practical exercise solutions

This page presents solutions to exercises/assignments from throughout the workshop

###Practical Exercise 1 - Software installation
To install bedtools:
* Google "bedtools" and find 
 * software page: https://github.com/arq5x/bedtools2
 * documentation page: http://bedtools.readthedocs.org/en/latest/
 * Note: If you find the old bedtools page (https://code.google.com/p/bedtools/) it will point you to above
* Go to Releases, find the latest version (e.g., bedtools-2.25.0.tar.gz), right-click and save url
* Go to tools directory and download the archive, then unpack, and compile
```
cd $RNA_HOME/tools/
wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz
tar -zxvf bedtools-2.25.0.tar.gz
cd bedtools2/
make
./bin/bedtools
```

###Practical Exercise 2 - Data

```
cd $RNA_HOME
mkdir -p practice/data
cd $RNA_HOME/practice/data
wget http://genome.wustl.edu/pub/rnaseq/data/alignment_practical.tar
tar -xvf alignment_practical.tar
```

###Practical Exercise 3 - QC
On you local machine, download this file: http://cbw**.dyndns.info/rnaseq/practice/data/hcc1395_normal_1.fastq.gz

Using FastQC, open this file and allow it to complete the QC analysis

* How many total sequences are there? 455,217
* What is the range (x - y) of read lengths observed? 25 - 100
* What is the most common average sequence quality score? 38
* What is the most common kmer that is observed? AACCATC


###Practical Exercise 4 - Trim

```
cd $RNA_HOME/practice/data/
mkdir trimmed
wget http://genome.wustl.edu/pub/rnaseq/trim/illumina_multiplex.fa
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_normal_1.fastq.gz --reads2 hcc1395_normal_2.fastq.gz --target trimmed/hcc1395_normal
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_tumor_1.fastq.gz --reads2 hcc1395_tumor_2.fastq.gz --target trimmed/hcc1395_tumor

```

Compare these files using FastQC: 
* http://cbw##.dyndns.info/rnaseq/practice/data/hcc1395_normal_1.fastq.gz
* http://cbw##.dyndns.info/rnaseq/practice/data/trimmed/hcc1395_normal_1.fastq.gz

###Practical Exercise 5 - Alignment

```
export RNA_HOME=~/workspace/rnaseq
export RNA_DATA_DIR=$RNA_HOME/practice/data
cd $RNA_HOME/practice/

mkdir -p alignments/tophat/trans_idx
export TRANS_IDX_DIR=$RNA_HOME/practice/alignments/tophat/trans_idx/
cd alignments/tophat

tophat2 -p 8 -r 60 --rg-id=HCC1395_normal --rg-sample=HCC1395_normal -o HCC1395_normal -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/hcc1395_normal_1.fastq.gz $RNA_DATA_DIR/hcc1395_normal_2.fastq.gz
tophat2 -p 8 -r 60 --rg-id=HCC1395_tumor --rg-sample=HCC1395_tumor -o HCC1395_tumor -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/hcc1395_tumor_1.fastq.gz $RNA_DATA_DIR/hcc1395_tumor_2.fastq.gz

```


| [[Previous Section|Lectures]]  | [[This Section|Solutions]]         | [[Next Section|Integrated-Assignment]]          |
|:-------------------------------:|:----------------------------------:|:---------------------:|
| [[Lectures|Lectures]]         | [[Practical Exercise Solutions|Solutions]] |  [[Integrated Assignment|Integrated-Assignment]] |


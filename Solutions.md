#5-iii. Practical exercise solutions

This page presents solutions to exercises/assignments from throughout the workshop

###Practical Exercise 1 - Software installation
To install bedtools:
* Google "bedtools" and find 
 * software page: https://github.com/arq5x/bedtools2
 * documentation page: http://bedtools.readthedocs.org/en/latest/
 * Note: If you find the old bedtools page (https://code.google.com/p/bedtools/) it will point you to above
* Go to Releases, find the latest version (e.g., bedtools-2.26.0.tar.gz), right-click and save url
* Go to tools directory and download the archive, then unpack, and compile
```
cd $RNA_HOME/tools/
wget https://github.com/arq5x/bedtools2/releases/download/v2.26.0/bedtools-2.26.0.tar.gz
tar -zxvf bedtools-2.26.0.tar.gz
cd bedtools2/
make
./bin/bedtools
```

###Practical Exercise 2 - Data

```
cd $RNA_HOME
mkdir -p practice/data
cd $RNA_HOME/practice/data
wget http://genome.wustl.edu/pub/rnaseq/data/practical.tar
tar -xvf practical.tar
```

###Practical Exercise 3 - QC

```bash

cd $RNA_HOME/practice/data
fastqc *.fastq.gz

```

Then, go to the following url in your browser:
* http://__YOUR_DNS_NAME__/rnaseq/practice/data/
* Note, you must replace __YOUR_DNS_NAME__ with your own amazon instance DNS (e.g., ec2-54-187-159-113.us-west-2.compute.amazonaws.com))
* Click on any of the *_fastqc.html files to view the FastQC report

* How many total sequences are there? 455,217
* What is the range (x - y) of read lengths observed? 25 - 100
* What is the most common average sequence quality score? 38
* What is the most common kmer that is observed? AACCATC


###Practical Exercise 4 - Trim

```
cd $RNA_HOME/practice/data/
mkdir trimmed
wget http://genome.wustl.edu/pub/rnaseq/trim/illumina_multiplex.fa
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_normal_rep1_r1.fastq.gz --reads2 hcc1395_normal_rep1_r2.fastq.gz --target trimmed/hcc1395_normal_rep1
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_normal_rep2_r1.fastq.gz --reads2 hcc1395_normal_rep2_r2.fastq.gz --target trimmed/hcc1395_normal_rep2
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_normal_rep3_r1.fastq.gz --reads2 hcc1395_normal_rep3_r2.fastq.gz --target trimmed/hcc1395_normal_rep3

flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_tumor_rep1_r1.fastq.gz --reads2 hcc1395_tumor_rep1_r2.fastq.gz --target trimmed/hcc1395_tumor_rep1
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_tumor_rep2_r1.fastq.gz --reads2 hcc1395_tumor_rep2_r2.fastq.gz --target trimmed/hcc1395_tumor_rep2
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_tumor_rep3_r1.fastq.gz --reads2 hcc1395_tumor_rep3_r2.fastq.gz --target trimmed/hcc1395_tumor_rep3

```

Compare these files using FastQC: 

```
cd $RNA_HOME/practice/data/trimmed/
fastqc *.fastq.gz
```

* http://YOUR_DNS_NAME/rnaseq/practice/data/hcc1395_normal_rep1_r1_fastqc.html
* http://YOUR_DNS_NAME/rnaseq/practice/data/trimmed/hcc1395_normal_rep1_1_fastqc.html

###Practical Exercise 5 - Alignment

```
export RNA_HOME=~/workspace/rnaseq
export RNA_PRACTICE_DATA_DIR=$RNA_HOME/practice/data
cd $RNA_HOME/practice/

mkdir -p alignments/hisat2
cd alignments/hisat2

hisat2 -p 8 --rg-id=HCC1395_normal --rg SM:HCC1395_normal --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_2.fastq.gz -S ./HCC1395_normal.sam
hisat2 -p 8 --rg-id=HCC1395_tumor --rg SM:HCC1395_tumor --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_2.fastq.gz -S ./HCC1395_tumor.sam

```


| [[Previous Section|Lectures]]  | [[This Section|Solutions]]         | [[Next Section|Integrated-Assignment]]          |
|:-------------------------------:|:----------------------------------:|:---------------------:|
| [[Lectures|Lectures]]         | [[Practical Exercise Solutions|Solutions]] |  [[Integrated Assignment|Integrated-Assignment]] |


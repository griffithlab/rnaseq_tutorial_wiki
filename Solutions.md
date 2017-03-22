# 5-iii. Practical exercise solutions

This page presents solutions to exercises/assignments from throughout the workshop

### Practical Exercise 1 - Software installation
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

**Answers**
* What happens when you run bedtools without any options? The basic usage documentation is printed. 
* Where can you find detailed documentation on how to use bedtools? http://bedtools.readthedocs.io/en/latest/
* How many general categories of analysis can you perform with bedtools? What are they? There are 8. They are 'Genome arithmetic', 'Multi-way file comparisons', 'Paired-end manipulation', 'Format conversion', 'Fasta manipulation', 'BAM focused tools', 'Statistical relationships', and 'Miscellaneous tools'.

---

### Practical Exercise 2 - Data

```
cd $RNA_HOME
mkdir -p practice/data
cd $RNA_HOME/practice/data
wget http://genome.wustl.edu/pub/rnaseq/data/practical.tar
tar -xvf practical.tar
ll -1 *.fastq.gz | wc -l
zcat hcc1395_normal_rep1_r1.fastq.gz | head -n 1
zcat hcc1395_normal_rep1_r1.fastq.gz | head -n 2 | tail -n 1 | perl -ne '$_ = s/T/X/g; print "\n\n$_\n\n"'
```

**Answers**
* How many data files were contained in the 'practical.tar' archive? What commonly used sequence data file format are they? There are 12 data files in the package. Each is a FASTQ file that has been compressed.
* In the first read of the hcc1395, normal, replicate 1, read 1 file, what was the physical location of the read on the flow cell (i.e. lane, tile, x, y)? Lane = 4, tile = 1101, x = 10003, y = 44458. 
* In the first read of this same file, how many 'T' bases are there? 32.

---

### Practical Exercise 3 - Data QC

```bash

cd $RNA_HOME/practice/data
fastqc *.fastq.gz

```

Then, go to the following url in your browser:
* http://__YOUR_DNS_NAME__/rnaseq/practice/data/
* Note, you must replace __YOUR_DNS_NAME__ with your own amazon instance IP or DNS (e.g., cbw##.dyndns.info)
* Click on any of the *_fastqc.html files to view the FastQC report (e.g., hcc1395_normal_rep1_r1_fastqc.html)

**Answers**
* How many total sequences are there? 331,958
* What is the range (x - y) of read lengths observed? 151
* What is the most common average sequence quality score? 41
* What is the most common kmer that is observed? GAATCGG

---

### Practical Exercise 4 - Trim

```
cd $RNA_HOME/practice/data/
mkdir trimmed
wget http://genome.wustl.edu/pub/rnaseq/trim/illumina_multiplex.fa
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_normal_rep1_r1.fastq.gz --reads2 hcc1395_normal_rep1_r2.fastq.gz --target trimmed/hcc1395_normal_rep1
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_normal_rep2_r1.fastq.gz --reads2 hcc1395_normal_rep2_r2.fastq.gz --target trimmed/hcc1395_normal_rep2
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_normal_rep3_r1.fastq.gz --reads2 hcc1395_normal_rep3_r2.fastq.gz --target trimmed/hcc1395_normal_rep3

flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_tumor_rep1_r1.fastq.gz --reads2 hcc1395_tumor_rep1_r2.fastq.gz --target trimmed/hcc1395_tumor_rep1
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_tumor_rep2_r1.fastq.gz --reads2 hcc1395_tumor_rep2_r2.fastq.gz --target trimmed/hcc1395_tumor_rep2
flexbar --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads 8 --zip-output GZ --reads hcc1395_tumor_rep3_r1.fastq.gz --reads2 hcc1395_tumor_rep3_r2.fastq.gz --target trimmed/hcc1395_tumor_rep3

```

Compare these files using FastQC: 

```
cd $RNA_HOME/practice/data/trimmed/
fastqc *.fastq.gz
```

* http://YOUR_DNS_NAME/rnaseq/practice/data/hcc1395_normal_rep1_r1_fastqc.html
* http://YOUR_DNS_NAME/rnaseq/practice/data/trimmed/hcc1395_normal_rep1_1_fastqc.html

* After trimming, what is the range of read lengths observed for hcc1395 normal replicate 1, read 1? 25-151
* Which sections of the FastQC report are most informative for observing the effect of trimming? 'Basic Statistics', 'Sequence Length Distribution', and 'Adapter Content'
* In the 'Per base sequence content section', what pattern do you see? What could explain this pattern? The first 9 base positions show a spiky pattern, suggesting biased representation of each base near the beginning of our reads/fragments. One possible explanation is that random hexamer priming for cDNA synthesis during library prep is happening in a non-random way. i.e. certain random hexamers are favored, therefore the creation of fragments (and ultimately reads) has a non-random pattern near the beginning. 

---

### Practical Exercise 5 - Alignment

Perform alignments:

```
export RNA_HOME=~/workspace/rnaseq
export RNA_PRACTICE_DATA_DIR=$RNA_HOME/practice/data
cd $RNA_HOME/practice/

mkdir -p alignments/hisat2
cd alignments/hisat2

hisat2 -p 8 --rg-id=HCC1395_normal_rep1 --rg SM:HCC1395_normal_rep1 --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_rep1_r1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_rep1_r2.fastq.gz -S ./HCC1395_normal_rep1.sam
hisat2 -p 8 --rg-id=HCC1395_normal_rep2 --rg SM:HCC1395_normal_rep2 --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_rep2_r1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_rep2_r2.fastq.gz -S ./HCC1395_normal_rep2.sam
hisat2 -p 8 --rg-id=HCC1395_normal_rep3 --rg SM:HCC1395_normal_rep3 --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_rep3_r1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_normal_rep3_r2.fastq.gz -S ./HCC1395_normal_rep3.sam

hisat2 -p 8 --rg-id=HCC1395_tumor_rep1 --rg SM:HCC1395_tumor_rep1 --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_rep1_r1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_rep1_r2.fastq.gz -S ./HCC1395_tumor_rep1.sam
hisat2 -p 8 --rg-id=HCC1395_tumor_rep2 --rg SM:HCC1395_tumor_rep2 --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_rep2_r1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_rep2_r2.fastq.gz -S ./HCC1395_tumor_rep2.sam
hisat2 -p 8 --rg-id=HCC1395_tumor_rep3 --rg SM:HCC1395_tumor_rep3 --rg PL:ILLUMINA -x $RNA_REF_INDEX --dta --rna-strandness RF -1 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_rep3_r1.fastq.gz -2 $RNA_PRACTICE_DATA_DIR/hcc1395_tumor_rep3_r2.fastq.gz -S ./HCC1395_tumor_rep3.sam

```

Sort and convert SAM to BAM:
```bash

samtools sort -@ 8 -o HCC1395_normal_rep1.bam HCC1395_normal_rep1.sam
samtools sort -@ 8 -o HCC1395_normal_rep2.bam HCC1395_normal_rep2.sam 
samtools sort -@ 8 -o HCC1395_normal_rep3.bam HCC1395_normal_rep3.sam
samtools sort -@ 8 -o HCC1395_tumor_rep1.bam HCC1395_tumor_rep1.sam
samtools sort -@ 8 -o HCC1395_tumor_rep2.bam HCC1395_tumor_rep2.sam
samtools sort -@ 8 -o HCC1395_tumor_rep3.bam HCC1395_tumor_rep3.sam

```

Merge HISAT2 BAM files

```bash

java -Xmx2g -jar $RNA_HOME/tools/picard.jar MergeSamFiles OUTPUT=HCC1395_normal.bam INPUT=HCC1395_normal_rep1.bam INPUT=HCC1395_normal_rep2.bam INPUT=HCC1395_normal_rep3.bam
java -Xmx2g -jar $RNA_HOME/tools/picard.jar MergeSamFiles OUTPUT=HCC1395_tumor.bam INPUT=HCC1395_tumor_rep1.bam INPUT=HCC1395_tumor_rep2.bam INPUT=HCC1395_tumor_rep3.bam

```

---

### Practical Exercise 6 - Visualize

```
cd $RNA_HOME/practice/alignments/hisat2
samtools index HCC1395_normal.bam
samtools index HCC1395_tumor.bam

```

Start IGV on your laptop. Load the HCC1395_normal.bam & HCC1395_tumor.bam files in IGV. You can load the necessary files in IGV directly from your web accessible amazon workspace (see below) using 'File' -> 'Load from URL'. 

**HCC1395BL (normal) alignment**: 

http://__YOUR_DNS_NAME__/rnaseq/practice/alignments/hisat2/HCC1395_normal.bam

**HCC1395 tumor alignment**:

http://__YOUR_DNS_NAME__/rnaseq/practice/alignments/hisat2/HCC1395_tumor.bam

---

### Practical Exercise 7 - Expression

```bash

cd $RNA_HOME/practice/
mkdir -p expression/stringtie/ref_only/
cd expression/stringtie/ref_only/

stringtie -p 8 -G $RNA_REF_GTF -e -B -o HCC1395_tumor_rep1/transcripts.gtf $RNA_HOME/practice/alignments/hisat2/HCC1395_tumor_rep1.bam
stringtie -p 8 -G $RNA_REF_GTF -e -B -o HCC1395_tumor_rep2/transcripts.gtf $RNA_HOME/practice/alignments/hisat2/HCC1395_tumor_rep2.bam
stringtie -p 8 -G $RNA_REF_GTF -e -B -o HCC1395_tumor_rep3/transcripts.gtf $RNA_HOME/practice/alignments/hisat2/HCC1395_tumor_rep3.bam

stringtie -p 8 -G $RNA_REF_GTF -e -B -o HCC1395_normal_rep1/transcripts.gtf $RNA_HOME/practice/alignments/hisat2/HCC1395_normal_rep1.bam
stringtie -p 8 -G $RNA_REF_GTF -e -B -o HCC1395_normal_rep2/transcripts.gtf $RNA_HOME/practice/alignments/hisat2/HCC1395_normal_rep2.bam
stringtie -p 8 -G $RNA_REF_GTF -e -B -o HCC1395_normal_rep3/transcripts.gtf $RNA_HOME/practice/alignments/hisat2/HCC1395_normal_rep3.bam

```

---

| [[Previous Section|Lectures]]  | [[This Section|Solutions]]         | [[Next Section|Integrated-Assignment]]          |
|:-------------------------------:|:----------------------------------:|:---------------------:|
| [[Lectures|Lectures]]         | [[Practical Exercise Solutions|Solutions]] |  [[Integrated Assignment|Integrated-Assignment]] |


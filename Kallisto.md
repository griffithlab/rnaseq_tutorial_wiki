#5-i Kallisto


##Using Kallisto for reference free transcript expression abundance estimation from RNA-seq data

For more information on Kallisto, refer to the <a href="https://pachterlab.github.io/kallisto/about.html">Kallisto project page</a> and <a href="https://pachterlab.github.io/kallisto/manual.html">Kallisto manual page</a>. 

##Install Kallisto
**TODO: after development is complete, this can be moved to the installation section** 

```
cd $RNA_HOME/
cd tools/
wget https://github.com/pachterlab/kallisto/releases/download/v0.42.4/kallisto_linux-v0.42.4.tar.gz
tar -zxvf kallisto_linux-v0.42.4.tar.gz

```

##Add Kallisto to PATH environment variable
```
export PATH=/home/ubuntu/workspace/rnaseq/tools/kallisto_linux-v0.42.4/:$PATH
kallisto
```

##Obtain transcript sequences in fasta format
Note that we already have fasta sequences of reference genome sequence from earlier in the RNA-seq tutorial. Kallisto works directly on target cDNA/transcript sequences. We have transcript models for genes on chromosome 22. These transcript models were downloaded from Ensembl in GTF format. This GTF contains a description of the coordinates of exons that make up each transcript but it does not contain the transcript sequences themselves. So currently we do not have transcript sequences needed by Kallisto. There are many places we could obtain  transcript sequences. For example, we could download them directly in Fasta format from the <a href="http://www.ensembl.org/info/data/ftp/index.html">Ensembl FTP site</a>. 

However, to allow us to compare Kallisto results to expression results from Cufflinks, perhaps we should create a custom Fasta files that corresponds to the transcripts we used for the Cufflinks analysis. How can we obtain these transcript sequences in Fasta format?

We could download the complete fasta transcript database for human and pull out only those for genes on chromosome 22. Or we could use a tool from `tophat` called `gtf_to_fasta` to generate a fasta sequence from our GTF file. This approach is convenient because it will also include the sequences for the ERCC spike in controls, allowing us to generate Kallisto abundance estimates for those features as well. 

```
cd $RNA_HOME/refs/hg19/genes/
gtf_to_fasta genes_chr22_ERCC92.gtf ../fasta/chr22_ERCC92/chr22_ERCC92.fa chr22_ERCC92_transcripts.fa
```

##Build a Kallisto transcriptome index
Remember that Kallisto does not perform *alignment* or use a reference genome sequence. Instead it performs *pseudoalignment* to determine the *compatibility* of reads with targets (transcript sequences in this case). However, similar to alignment algorithms like Tophat or STAR, Kallisto requires an **index** to assess this compatibility efficiently and quickly.  

```
cd $RNA_HOME/refs/hg19/
mkdir kallisto
cd kallisto
kallisto index --index=chr22_ERCC92_transcripts_kallisto_index ../genes/chr22_ERCC92_transcripts.fa
```

##Generate abundance estimates for all samples using Kallisto
As we did with `Cufflinks` and `HT-Seq` we will generate transcript abundances for each of our demonstration samples using `Kallisto`.

```
export RNA_DATA_DIR=$RNA_HOME/data/
echo $RNA_DATA_DIR

cd $RNA_HOME/expression/
mkdir kallisto
cd kallisto
kallisto quant --index=$RNA_HOME/refs/hg19/kallisto/chr22_ERCC92_transcripts_kallisto_index --output-dir=testdir --threads=4 --plaintext $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz



```







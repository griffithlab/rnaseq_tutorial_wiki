This page presents solutions to exercises/assignments from throughout the workshop

##Practical Exercise 1 - Software installation
To install bedtools:
* Google "bedtools" and find 
 * software page: https://github.com/arq5x/bedtools2
 * documentation page: http://bedtools.readthedocs.org/en/latest/
 * Note: If you find the old bedtools page (https://code.google.com/p/bedtools/) it will point you to above
* Go to Releases, find the latest version (e.g., bedtools-2.22.0.tar.gz), right-click and save url
* Go to tools directory and download the archive, then unpack, and compile
```
cd $RNA_HOME/tools/
wget https://github.com/arq5x/bedtools2/releases/download/v2.22.0/bedtools-2.22.0.tar.gz
tar -zxvf bedtools-2.22.0.tar.gz
cd bedtools2/
make
```

##Practical Exercise 2 - Alignment

```
cd $RNA_HOME/practice/
export RNA_DATA_DIR=$RNA_HOME/practice/
echo $RNA_DATA_DIR

mkdir -p alignments/tophat/trans_idx
cd alignments/tophat
export TRANS_IDX_DIR=$RNA_HOME/alignments/tophat/trans_idx/
echo $TRANS_IDX_DIR

tophat2 -p 8 -r 60 --rg-id=HBR_Rep1 --rg-sample=HBR_Rep1_ERCC-Mix2 -o HBR_Rep1_ERCC-Mix2 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz

```
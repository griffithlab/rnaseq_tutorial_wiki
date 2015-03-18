#6-ii. Practical exercise solutions

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


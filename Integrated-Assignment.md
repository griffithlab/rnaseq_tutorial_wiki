#5-iv. Integrated assignment
###Readings:
http://www.ncbi.nlm.nih.gov/pubmed/21571633 [download] 


###Assignment Questions
[Assignment [download word version]](https://raw.githubusercontent.com/wiki/griffithlab/rnaseq_tutorial/LectureFiles/cbw-cshl-nygc/2015/assignment_questions_only.doc)

[Assignment [download PDF version]](https://raw.githubusercontent.com/wiki/griffithlab/rnaseq_tutorial/LectureFiles/cbw-cshl-nygc/2015/assignment_questions_only.pdf)


**Background: PCA3 gene plays a role in Prostate Cancer detection due to its localized expression in prostate tissues and its over-expression in tumour tissues. This gene's expression profile makes it a useful marker that can complement the most frequently used biomarker for prostate cancer, PSA.  There are cancer assays available that tests the presence of PCA3 in urine.** 

Objectives: In this assignment, we will be using a subset of the GSE22260 dataset, which consists of 30 RNA-seq tumour normal pairs, to assess the prostate cancer specific expression of the PCA3 gene. 

Things to keep in mind:

- The libraries are polyA selected.
- The libraries are prepared as paired end.
- The samples are sequenced on Illumina's Genome Analyzer II.
- Each read is 36 bp long
- The average insert size is 150 bp with standard deviation of 38bp.
- We will only look at chromosome 9 in this exercise. 
- Dataset is located here: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE22260
- 20 tumour and 10 normal samples are available
- For this exercise we will pick 3 matched pairs (C02,C03,C06 for tumour and N02,N03,N06 for normal). We can do more if we have time.

# PART 1 : Obtaining Data and References

Goals:
- Obtain the files necessary for data processing
- Familiarize yourself with reference and annotation file format
- Familiarize yourself with sequence FASTQ format

#set your working directory
      mkdir -p ~/workspace/rnaseq/integrated_assignment/
      export RNA_HOME=~/workspace/rnaseq/integrated_assignment
#copy the necessary reference and annotation files
Note: when initiating an environment variable, we don't need the $; however, everytime we call the variable, it needs to be preceeded by a $.

     echo $RNA_HOME
     cp -r ~/CourseData/RNA_data/integrated_assignment_files/* $RNA_HOME
     cd $RNA_HOME


Q1) How many directories are there under the “refs” directory? 


Q2)  How many exons does the gene PCA3 have?


Q3) How many cancer/normal samples do you see under the data directory?

NOTE: The fasta files you have copied above contain sequences for chr9 only. I have pre-processed those fasta files to obtain chr9 and also matched read1/read2 sequences for each of the samples. You do not need to redo this; However, I will explain below the process I went through to get them to this point.

Q4) What sample has the highest number of reads?


# PART 2: Data alignment

Goals:
- Familiarize yourself with Tophat/Bowtie alignment options
- Perform alignments
- Obtain alignment summary

Q5) What is the value of --mate-inner-dist? What calculation did you do to get that answer?


Q6) Considering that the read length in this exercise is 36bp, what should you set the --segment-length to (default is 25bp)?

    cd $RNA_HOME/
    export RNA_DATA_DIR=$RNA_HOME/data/
    echo $RNA_DATA_DIR
    mkdir -p alignments/tophat/trans_idx
    cd alignments/tophat
    export TRANS_IDX_DIR=$RNA_HOME/alignments/tophat/trans_idx/
    echo $TRANS_IDX_DIR

_**NOTE: Take a minute and try to figure out what each parameter means and how we go the numbers. **_

    tophat2 -p 8 --mate-inner-dist 80 --mate-std-dev 38 --segment-length 18 --rg-id=normal --rg-sample=normal_N02 -o normal_N02 -G $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/9/9 $RNA_DATA_DIR/normal_N02_read1.fasta $RNA_DATA_DIR/normal_N02_read2.fasta

    tophat2 -p 8 --mate-inner-dist 80 --mate-std-dev 38 --segment-length 18 --rg-id=normal --rg-sample=normal_N03 -o normal_N03 -G $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/9/9 $RNA_DATA_DIR/normal_N03_read1.fasta $RNA_DATA_DIR/normal_N03_read2.fasta

    tophat2 -p 8 --mate-inner-dist 80 --mate-std-dev 38 --segment-length 18 --rg-id=normal --rg-sample=normal_N06 -o normal_N06 -G $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/9/9 $RNA_DATA_DIR/normal_N06_read1.fasta $RNA_DATA_DIR/normal_N06_read2.fasta

    tophat2 -p 8 --mate-inner-dist 80 --mate-std-dev 38 --segment-length 18 --rg-id=carcinoma --rg-sample=carcinoma_C02 -o carcinoma_C02 -G $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/9/9 $RNA_DATA_DIR/carcinoma_C02_read1.fasta $RNA_DATA_DIR/carcinoma_C02_read2.fasta

    tophat2 -p 8 --mate-inner-dist 80 --mate-std-dev 38 --segment-length 18 --rg-id=carcinoma --rg-sample=carcinoma_C03 -o carcinoma_C03 -G $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/9/9 $RNA_DATA_DIR/carcinoma_C03_read1.fasta $RNA_DATA_DIR/carcinoma_C03_read2.fasta

    tophat2 -p 8 --mate-inner-dist 80 --mate-std-dev 38 --segment-length 18 --rg-id=carcinoma --rg-sample=carcinoma_C06 -o carcinoma_C06 -G $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/9/9 $RNA_DATA_DIR/carcinoma_C06_read1.fasta $RNA_DATA_DIR/carcinoma_C06_read2.fasta

Q7) How would you obtain summary statistics for each aligned file?

# PART 3: Expression Estimation

Goals:
- Familiarize yourself with Cufflinks options
- Run Cufflinks to obtain expression values
- Obtain expression values for the gene PCA3

    cd $RNA_HOME
    mkdir expression
    cd expression

_**example (how to run cufflinks for one sample):**_

    cufflinks -p 8 -o normal_N02 --GTF $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --no-update-check $RNA_HOME/alignments/tophat/normal_N02/accepted_hits.bam 
    cufflinks -p 8 -o normal_N03 --GTF $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --no-update-check $RNA_HOME/alignments/tophat/normal_N03/accepted_hits.bam 
    cufflinks -p 8 -o normal_N06 --GTF $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --no-update-check $RNA_HOME/alignments/tophat/normal_N06/accepted_hits.bam 

    cufflinks -p 8 -o carcinoma_C02 --GTF $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --no-update-check $RNA_HOME/alignments/tophat/carcinoma_C02/accepted_hits.bam 
    cufflinks -p 8 -o carcinoma_C03 --GTF $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --no-update-check $RNA_HOME/alignments/tophat/carcinoma_C03/accepted_hits.bam 
    cufflinks -p 8 -o carcinoma_C06 --GTF $RNA_HOME/refs/hg19/genes/genes_chr9.gtf --no-update-check $RNA_HOME/alignments/tophat/carcinoma_C06/accepted_hits.bam 

Q8) How do you get the expression of PCA3 across the normal and carcinoma samples?


# PART 4: Differential Expression Analysis 

Goals:
- Perform differential analysis between tumor and normal samples
- Check if PCA3 is differentially expressed

     cd $RNA_HOME/expression
     ls -l */transcripts.gtf > assembly_GTF_list.txt
     cuffmerge -p 8 -o merged -g $RNA_HOME/refs/hg19/genes/genes_chr9.gtf -s $RNA_HOME/refs/hg19/bwt/9/assembly_GTF_list.txt
    cd $RNA_HOME/
    mkdir de
    mkdir de/reference_only
    cd $RNA_HOME/alignments/tophat

#run cuffdiff to perform comparison

    cuffdiff -p 8 -L Normal,Carcinoma -o $RNA_HOME/de/reference_only/ --no-update-check $RNA_HOME/expression/merged/merged.gtf normal_N02/accepted_hits.bam,normal_N03/accepted_hits.bam,normal_N06/accepted_hits.bam carcinoma_C02/accepted_hits.bam,carcinoma_C03/accepted_hits.bam,carcinoma_C06/accepted_hits.bam

Q9) any significant genes that are differentially expressed? what about PCA3? 

_**NOTE: Make a copy of the data to use in generateCummerbund plots generation**_

    cd $RNA_HOME/
    mkdir final_results
    cd $RNA_HOME/final_results
    mkdir reference_only
    cp $RNA_HOME/de/reference_only/isoform* reference_only/
    cp $RNA_HOME/de/reference_only/read_groups.info reference_only/

_**NOTE: Rerun Obi's CummerBund Script focusing on PCA3 genes.**_

Q10) What plots can you generate to help you visualize this gene's expression profile?

| [[Previous Section|Solutions]]       | [[This Section|Integrated-Assignment]] | [[Next Section|Proposed-Improvements]]   |
|:------------------------------------------------------------:|:--------------------------:|:-------------------------------------------:|
| [[Practical Exercise Solutions|Solutions]] | [[Integrated Assignment|Integrated-Assignment]]    | [[Proposed Improvements|Proposed-Improvements]] |

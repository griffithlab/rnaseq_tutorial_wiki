
#1-iii. Annotations
###Obtain known gene/transcript annotations

In this tutorial we will use annotations obtained from Ensembl (ftp://ftp.ensembl.org/pub/release-86/gtf/homo_sapiens/Homo_sapiens.GRCh38.86.gtf.gz) for chromosome 22 only. For time reasons, these are prepared for you and made available on your AWS instance. But you should get familiar with sources of gene annotations for RNA-seq analysis. 

Copy the gene annotation files to the working directory. 

```bash

echo $RNA_REFS_DIR
cd $RNA_REFS_DIR
cp /home/ubuntu/workspace/data/annotations/GRCh38/chr22_with_ERCC92.gtf .  

```

Take a look at the contents of the gtf file. Press 'q' to exit the 'less' display.

```bash

less -p start_codon -S $RNA_REF_GTF

```

How many unique gene IDs are in the .gtf file?

We can use a perl command-line command to find out:

```bash

perl -ne 'if ($_ =~ /(gene_id\s\"ENSG\w+\")/){print "$1\n"}' $RNA_REF_GTF | sort | uniq | wc -l

```

* Using perl -ne '' will execute the code between single quotes, on the .gtf file, line-by-line.
* The $_ variable holds the contents of each line.
* The 'if ($_ =~//)' is a pattern-matching command which will look for the pattern "gene_id" followed by a space followed by "ENSG" and one or more word characters (indicated by \w+) surrounded by double quotes.
* The pattern to be matched is enclosed in parentheses. This allows us to print it out from the special variable $1.
* The output of this perl command will be a long list of ENSG Ids. 
* By piping to sort, then uniq, then word count we can count the unique number of genes in the file.


Now view the structure of a single transcript in GTF format. Press 'q' to exit the 'less' display when you are done.

```bash

grep ENST00000342247 $RNA_REF_GTF | less -p "exon\s" -S

```

To learn more, see:
* http://perldoc.perl.org/perlre.html#Regular-Expressions
* http://www.perl.com/pub/2004/08/09/commandline.html
	
	
###Definitions:

- Reference genome - The nucleotide sequence of the chromosomes of a species.  Genes are the functional units of a reference genome and gene annotations describe the structure of transcripts expressed from those gene loci.  

- Gene annotations - Descriptions of gene/transcript models for a genome.  A transcript model consists of the *coordinates* of the exons of a transcript on a reference genome.  Additional information such as the strand the transcript is generated from, gene name, coding portion of the transcript, alternate transcript start sites, and other information may be provided.

- GTF (.gtf) file - A common file format referred to as Gene Transfer Format used to store gene and transcript annotation information.  You can learn more about this format here:
http://genome.ucsc.edu/FAQ/FAQformat#format3
http://genome.ucsc.edu/FAQ/FAQformat#format4
	
###The purpose of gene annotations (gtf file)

When running the HISAT2/StringTie/Ballgown pipeline, known gene/transcript annotations are used for several purposes:
* During the HISAT2 index creation step, annotations may be provided to create local indexes to represent transcripts as well as a global index for the entire reference genome. This allows for faster mapping and better mapping across exon boundaries and splice sites. If an alignment still can not be found it will attempt to determine if the read corresponds to a novel exon-exon junction. See the Indexing section and the HISAT2 publication for more details. 
* During the StringTie step, a .gtf file can be used to specify the transcript models to estimate expression estimates for using the '-G' and '-e' option.  This mode of StringTie will give you one expression estimate for each of the transcripts in your .gtf file giving you a 'microarray like' expression result.
* During the StringTie step, a .gtf file can be used to 'guide' the assembly of novel transcripts using the '-G' option **ONLY**.  Instead of assuming the known transcript models are correct, they are used as a guide and the resulting expression estimates will correspond to both known and novel/predicted transcripts.
* During the StringTie and gffcompare steps, a .gtf file is used to determine the transcripts that will be examined for differential expression using Ballgown.  These may be known transcripts that you download from a public source or a .gtf of transcripts predicted by StringTie from the read data in an earlier step.
	
###Sources for obtaining gene annotation files formatted for HISAT2/StringTie/Ballgown

There are many possible sources of .gtf gene/transcript annotation files.  For example, from Ensembl, 1000 Genomes, Illumina iGenomes, UCSC, RefSeq, etc.  Four options and related instructions for obtaining the gene annotation files are provided below.
	
####I. ILLUMINA IGENOMES.  
Formatted specifically for use with TopHat Cuffinks.  Based on UCSC, Refseq/NCBI, or Ensembl annotations.  Available for many species.  Bowtie indexed reference genome files are pre-computed for your convenience.  Download here:
http://cole-trapnell-lab.github.io/cufflinks//igenome_table/index.html

  * Use wget (or similar) to download the Homo_sapiens_Ensembl_GRCh37.tar.gz file 
  * This is found under Homo sapiens -> Ensembl -> GRCh37
  * unzip/untar
  * Individual chromosome fasta sequence files can be in Homo_sapiens/Ensembl/GRCh37/Sequence/Chromosomes/
  * GTF file can be found in Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf

Note, the Igenomes file is huge and contains many files (including archived versions) that you likely do not need. After download of the tar file, one space-saving solution is to perform only a selective unarchive. For example:

```bash

cd $RNA_REFS_DIR
wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/Ensembl/GRCh37/Homo_sapiens_Ensembl_GRCh37.tar.gz
tar --exclude='Homo_sapiens/Ensembl/GRCh37/Annotation/Archives/archive-2010*' --exclude='Homo_sapiens/Ensembl/GRCh37/Annotation/Archives/archive-2011*' --exclude='Homo_sapiens/Ensembl/GRCh37/Annotation/Archives/archive-2012*' --exclude='Homo_sapiens/Ensembl/GRCh37/Annotation/Archives/archive-2013*' --exclude='Homo_sapiens/Ensembl/GRCh37/Sequence/BWAIndex' --exclude='Homo_sapiens/Ensembl/GRCh37/Sequence/BowtieIndex' --exclude='Homo_sapiens/Ensembl/GRCh37/Sequence/AbundantSequences' -zxvf Homo_sapiens_Ensembl_GRCh37.tar.gz

```

Then, the files you would need for the workflow presented in this original TopHat/Cufflinks/Cuffdiff version of this tutorial would be:

* GTF file: Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf
* Reference genome (combined): Homo_sapiens/Ensembl/GRCh37/Sequence/WholeGenomeFasta/genome.fa
* Reference genome (individual): Homo_sapiens/Ensembl/GRCh37/Sequence/Chromosomes/*.fa
* Bowtie2 index: Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome.*
	
####II. ENSEMBL FTP SITE  

Based on Ensembl annotations only.  Available for many species.
http://useast.ensembl.org/info/data/ftp/index.html
	
####III. UCSC TABLE BROWSER  

Based on UCSC annotations or several other possible annotation sources collected by UCSC. You might chose this option if you want to have a lot of flexibility in the annotations you obtain.  e.g. to grab only the transcripts from chromosome 22 as in the following example:
  * Open the following in your browser: http://genome.ucsc.edu/
  * Click 'Tables' at the top of the page.
  * Select 'Mammal', 'Human', and 'Feb. 2009 (GRCh37/hg19)' from the first row of drop down menus.
  * Select 'Genes and Gene Prediction Tracks' and 'UCSC Genes' from the second row of drop down menus.
    To limit your selection to only chromosome 22, select the 'position' option beside 'region', enter 'chr22' in the 'position' box.
  * Select 'GTF - gene transfer format' for output format and enter 'UCSC_Genes.gtf' for output file.
  * Hit the 'get output' button and save the file.  Make note of its location
	
In addition to the .gtf file you may find uses for some extra files providing alternatively formatted or additional information on the same transcripts.  For example:
How to get a Gene bed file:
  * Change the output format to 'BED - browser extensible data'.
  * Change the output file to 'UCSC_Genes.bed', and hit the 'get output' button.
  * Make sure 'Whole Gene' is selected, hit the 'get BED' button, and save the file.
	
How to get an Exon bed file:  
  * Go back one page in your browser and change the output file to 'UCSC_Exons.bed', the hit the 'get output' button again.  
  * Select 'Exons plus', enter 0 in the adjacent box, hit the 'get BED' button, and save the file.  
	
How to get gene symbols and descriptions for all UCSC genes:  
  * Again go back one page in your browser and change the 'output format' to 'selected fields from primary and related tables'.  
  * Change the output file to 'UCSC_Names.txt', and hit the 'get output' button.  
  * Make sure 'chrom' is selected near the top of the page.  
  * Under 'Linked Tables' make sure 'kgXref' is selected, and then hit 'Allow Selection From Checked Tables'.  This will link the table and give you access to its fields.  
  * Under 'hg19.kgXref fields' select: 'kgID', 'geneSymbol', 'description'.  
  * Hit the 'get output' button and save the file.  
	
To get annotations for the whole genome, make sure 'genome' is selected beside 'region'.
By default, the files downloaded above will be compressed.  To decompress, use 'gunzip filename' in linux.

####IV. HISAT2 Precomputed Genome Index

HISAT2 has prebuilt reference genome index files for both DNA and RNA alignment. Various versions of the index files include SNPs and/or transcript splice sites. Versions of both the Ensembl and UCSC genomes for human build 38 are linked from the main HISAT2 page:
https://ccb.jhu.edu/software/hisat2/index.shtml

Or those same files are directly available from their FTP site:
ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/data/

Important note on chromosome naming conventions:  
In order for your RNA-seq analysis to work, the chromosome names in your .gtf file **must match** those in your reference genome (i.e. your reference genome fasta file).  If you get a StringTie result where all transcripts have an expression value of 0, you may have overlooked this.  Unfortunately, Ensembl, NCBI, and UCSC can not agree on how to name the chromosomes in many species, so this problem may come up often.  You can avoid this by getting a complete reference genome and gene annotation package from the Illumina iGenomes project mentioned above.
	
Important note on reference genome builds:  
Your annotations must correspond to the same reference genome build as your reference genome fasta file.  e.g. both correspond to UCSC human build 'hg38', NCBI human build 'GRCh38', etc..  Even if both your reference genome and annotations are from UCSC or Ensembl they could still correspond to different versions of that genome.  This would cause problems in any RNA-seq pipeline.
	
| [[Previous Section|Reference-Genome]]  | [[This Section|Annotation]] | [[Next Section|Indexing]] |
|:--------------------------------------:|:---------------------------:|:-------------------------:|
| [[Reference Genomes|Reference-Genome]] | [[Annotations|Annotation]]  | [[Indexing|Indexing]]     |

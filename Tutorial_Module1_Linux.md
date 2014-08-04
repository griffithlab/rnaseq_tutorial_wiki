Tutorial Module1 Linux
======================
	
*Malachi Griffith, mgriffit[AT]genome.wustl.edu
*Obi Griffith, ogriffit[AT]genome.wustl.edu
*Jason Walker, jwalker[AT]genome.wustl.edu
The Genome Institute, Washington University School of Medicine
	
This document assumes a Linux computer with an 'x86_64' architecture
The rest of the tutorial should be conducted in a linux Terminal session
	
All lines starting with a '#' are comments and will not be executed.
Before proceeding you must define a global working directory by setting the environment variable: 'RNA_HOME'
Log into a server and SET THIS BEFORE RUNNING EVERYTHING.  
You can then PLACE IT IN YOUR .bashrc and then logout and login again to avoid having to worry about it
	
#ENVIRONMENT
        #Create a working directory and set the 'RNA_HOME' environment variable
	mkdir -p ~/workspace/rnaseq/
	export RNA_HOME=~/workspace/rnaseq
	
        #Make sure whatever the working dir is, that it is set and is valid
	echo $RNA_HOME
	
#INSTALLATION
1) Installation.  Tools needed for this analysis are: samtools, bam-readcount, bowtie, tophat, star, cufflinks, htseq-count, R, cummeRbund, fastqc, picard-tools, and samstat.
In the following installation example the installs are local and will work whether you have root (i.e. admin) access or not
However, if root is available some binaries can/will be copies to system-wide locations (e.g., /usr/bin/)
	
        #Set up tool installation location
	cd $RNA_HOME
	mkdir tools
	cd tools
	
If for some strange reason, 'wget' is not installed on your Linux or Mac system but curl is.  You can install it as follows (NOTE: remove '#' to execute):
   #curl -O http://ftp.gnu.org/gnu/wget/wget-1.13.4.tar.gz
   #tar -xzvf wget-1.13.4.tar.gz
   #cd wget-1.13.4
   #./configure --with-ssl=openssl
   #make
   #make install
	
##Intall SamTools
         #Documentation and download: http://sourceforge.net/projects/samtools/
	cd $RNA_HOME/tools/
	wget http://sourceforge.net/projects/samtools/files/samtools/0.1.19/samtools-0.1.19.tar.bz2/download -O samtools-0.1.19.tar.bz2
	bunzip2 samtools-0.1.19.tar.bz2 
	tar -xvf samtools-0.1.19.tar
	cd samtools-0.1.19
	make
	./samtools
	
##Install bam-readcount
          #Documentation and download: https://github.com/genome/bam-readcount
	cd $RNA_HOME/tools/
	mkdir git
	cd git
	git clone --recursive git://github.com/genome/bam-readcount.git
	cd $RNA_HOME/tools/
	mkdir bam-readcount
	cd bam-readcount
	export SAMTOOLS_ROOT=$RNA_HOME/tools/samtools-0.1.19
	cmake $RNA_HOME/tools/git/bam-readcount
	make
	./bin/bam-readcount
	
##Intall Bowtie2
         #Documentation and download: http://bowtie-bio.sourceforge.net/bowtie2/index.shtml
	cd $RNA_HOME/tools/
	wget http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.1.0/bowtie2-2.1.0-linux-x86_64.zip
	unzip bowtie2-2.1.0-linux-x86_64.zip
	cd bowtie2-2.1.0
	./bowtie2
	./bowtie2-build
	
##Install Tophat2
          #Documentation and download: http://tophat.cbcb.umd.edu/
	cd $RNA_HOME/tools/
	wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.8b.Linux_x86_64.tar.gz
	tar -zxvf tophat-2.0.8b.Linux_x86_64.tar.gz
	cd tophat-2.0.8b.Linux_x86_64
	./tophat2
	
OPTIONAL
##Install STAR (alternative to Tophat2)
######Documentation: https://code.google.com/p/rna-star/
######Download: https://code.google.com/p/rna-star/downloads/list
	cd $RNA_HOME/tools/
	wget http://rna-star.googlecode.com/files/STAR_2.3.0e.Linux_x86_64_static.tgz
	tar -zxvf STAR_2.3.0e.Linux_x86_64_static.tgz
	file STAR_2.3.0e.Linux_x86_64_static/STAR
	
######Install Cufflinks2
######Documentation and download: http://cufflinks.cbcb.umd.edu/
	cd $RNA_HOME/tools/
	wget http://cufflinks.cbcb.umd.edu/downloads/cufflinks-2.1.1.Linux_x86_64.tar.gz
	tar -zxvf cufflinks-2.1.1.Linux_x86_64.tar.gz
	cd cufflinks-2.1.1.Linux_x86_64
	./cufflinks
	
######Install htseq-count
######Documentation: http://www-huber.embl.de/users/anders/HTSeq/doc/count.html
######Download: https://pypi.python.org/packages/source/H/HTSeq/
	cd $RNA_HOME/tools/
	wget https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1p1.tar.gz
	tar -zxvf HTSeq-0.6.1p1.tar.gz
	cd HTSeq-0.6.1p1/
	python setup.py install --user
	chmod +x scripts/htseq-count
	./scripts/htseq-count
	
######Install R
######This install takes a while so check if you have R installed already by typing 'which R'
######It is already installed on the Cloud, but for completeness, here is how it was done.
######cd $RNA_HOME/tools/
######export R_LIBS=
######wget http://cran.r-project.org/src/base/R-3/R-3.1.0.tar.gz
######tar -zxvf R-3.1.0.tar.gz
######cd R-3.1.0
######Note, X11 libraries are not available on Amazon cloud so you need use '--with-x=no' during config, on a regular linux system you would not use this option:
######./configure --with-x=no --prefix=$RNA_HOME/tools/R-3.1.0/
######make
######make install
######./bin/Rscript
	
######Install R add-on libraries: 'gplots' and 'ggplot2'
######launch R (enter "R" at command prompt) and type the following at R prompt
######cd $RNA_HOME/tools/
######./R-3.1.0/bin/R
######install.packages("gplots")
######install.packages("ggplot2")
######quit()
	
######Install R bioconductor libraries: 'cummeRbund' and 'edgeR'
######launch R (enter "R" at command prompt) and type the following at R prompt
######cd $RNA_HOME/tools/
######./R-3.1.0/bin/R
######source("http://bioconductor.org/biocLite.R")
######biocLite("cummeRbund")
######biocLite("edgeR")
######If prompted, type "a" to update all old packages
######quit()
	
######Install fastqc
######Note, the linux installation below will not work without X11 libraries (as on Amazon cloud)
######For the course we will instead install on student laptops
######Download from http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
######For completeness, here is how it would be installed on a linux system with X11 libraries
######cd $RNA_HOME/tools/
######wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.10.1.zip
######unzip fastqc_v0.10.1.zip
######cd FastQC/
######chmod 755 fastqc
######./fastqc --help
	
######Install Picard tools
######Documentation: http://picard.sourceforge.net/command-line-overview.shtml
######Download: 
	cd $RNA_HOME/tools/
	wget http://sourceforge.net/projects/picard/files/picard-tools/1.114/picard-tools-1.114.zip
	unzip picard-tools-1.114.zip
	java -Xmx2g -jar $RNA_HOME/tools/picard-tools-1.114/MergeSamFiles.jar --help
	
######Install samstat
######cd $RNA_HOME/tools/
######wget http://sourceforge.net/projects/samstat/files/latest/download -O samstat.tgz
######tar -xzvf samstat.tgz
######cd samstat/src
######make
	
######Note: for some reason samstat will not compile on our Amazon instances. 
######We were able to compile offline on ubuntu and archlinux
######Therefore the instructions above should work in your home lab
######For now you can copy a pre-compiled version to your tools dir
	cd $RNA_HOME/tools/
	mkdir samstat
	cp /media/cbwdata/CourseData/RNA_data/samstat $RNA_HOME/tools/samstat/
	$RNA_HOME/tools/samstat/samstat
######If you get a permissions error, try the following
	chmod +x $RNA_HOME/tools/samstat/samstat
	
######Add locally installed tools to your PATH
######To use the locally installed version of each tool without having to specify complete paths, you could add the install directory of each tool to your '$PATH' variable
	
	export RNA_HOME=~/workspace/rnaseq
	export PATH=$RNA_HOME/tools/samtools-0.1.19:$RNA_HOME/tools/bam-readcount/bin:$RNA_HOME/tools/bowtie2-2.1.0:$RNA_HOME/tools/tophat-2.0.8b.Linux_x86_64:$RNA_HOME/tools/STAR_2.3.0e.Linux_x86_64_static:$RNA_HOME/tools/cufflinks-2.1.1.Linux_x86_64:$RNA_HOME/tools/HTSeq-0.6.1p1/scripts:$RNA_HOME/R-3.1.0/bin:$RNA_HOME/tools/FastQC:$RNA_HOME/tools/picard-tools-1.114:$RNA_HOME/tools/samstat:$PATH
	echo $PATH
	
######You can make these changes permanent by adding the following lines to your .bashrc file
######use a text editor to open your bashrc file. For example:
	vi ~/.bashrc
######Using your cursor, navigate down to the "export PATH" commands at the end of the file.
######Delete the line starting with PATH using the vi command "dd".
######Press the "i" key to enter insert mode. Go to an empty line with you cursor and copy paste the new RNA_HOME and PATH commands into the file
######Press the "esc" key to exit insert mode.
######press the ":" key to enter command mode.
######type "wq" to save and quit vi
	
######NOTE: If you are worried your .bashrc is messed up you can redownload as follows:
	cd ~
	wget -N https://dl.dropboxusercontent.com/u/16769159/.bashrc
	
	
######PRACTICAL EXERCISE
######Try to install bedtools on your own
######Make sure you install it in your tools folder
	cd $RNA_HOME/tools/
######Now, download, unpack, compile, and test
######Hint - google "bedtools" to find the source code
######Hint - there is a README file that will give you hints on how to install
######Hint - If your install has worked you should be able to run bedtools as follows:
	$RNA_HOME/tools/bedtools-2.17.0/bin/bedtools
	
######REFERENCE GENOME
######2.) Obtain a reference genome from iGenomes.  In this example analysis we will use the human hg19/NCBI build 37 version of the genome
######In this tutorial we are actually going to perform the analysis using only a single chromosome (chr22) to make it run faster...
######Create the necessary working directory
	cd $RNA_HOME
	mkdir refs
	mkdir refs/hg19/
	mkdir refs/hg19/fasta/
	mkdir refs/hg19/fasta/22/
	cd refs/hg19/fasta/22/
	
######Make a copy of chr22 fasta from the CourseData directory to your working directory
######The complete data from which these files were obtained can be found at: http://cufflinks.cbcb.umd.edu/igenomes.html
######You could use wget to download the Homo_sapiens_Ensembl_GRCh37.tar.gz file (under Homo sapiens -> Ensembl -> GRCh37), then unzip/untar
######This has been done for you and that data placed in /media/cbwdata/CourseData/RNA_data/
	cp /media/cbwdata/CourseData/RNA_data/iGenomes/Homo_sapiens/Ensembl/GRCh37/Sequence/Chromosomes/22.fa .
	
######View the first 10 lines of this file
	head 22.fa
	
######How many lines and characters are in this file? 
	wc 22.fa
	
######To get all chromosomes instead of just chr22 you could do the following:
######cd $RNA_HOME
######mkdir -p refs/hg19/fasta/
######cd refs/hg19/fasta/
######cp /media/cbwdata/CourseData/RNA_data/iGenomes/Homo_sapiens/Ensembl/GRCh37/Sequence/Chromosomes/* .
######cat *.fa > hg19.fa
	
######Note: Instead of the above, you might consider getting reference genomes and associated annotations from UCSC
######e.g., ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/
######Wherever you get them from, the names of your reference sequences (chromosomes) must those matched in your annotation gtf files.
	
	
######ANNOTATION
######3.) Obtain known gene/transcript annotations
###### In this tutorial we will use annotations obtained from Illumina's iGenomes for chromosome 22 only
###### For time reasons, these have been downloaded for you.
###### But you should get familiar with sources of gene annotations for RNA-seq analysis
###### Copy the gene annotation files to the working directory. 
	
	cd $RNA_HOME/refs/hg19/
	mkdir genes
	cd genes
	cp /media/cbwdata/CourseData/RNA_data/iGenomes/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes_chr22.gtf .
	less -p start_codon -S genes_chr22.gtf
######Press 'q' to exit the 'less' display
	
######How many unique gene IDs are in the .gtf file?
######We can use a perl command-line command to find out:
	perl -ne 'if ($_ =~ /(gene_id\s\"ENSG\w+\")/){print "$1\n"}' genes_chr22.gtf | sort | uniq | wc -l
	
######Using perl -ne '' will execute the code between single quotes, on the .gtf file, line-by-line.
######The $_ variable holds the contents of each line
######The 'if ($_ =~//)' is a pattern-matching command which will look for the pattern "gene_id" followed by a space followed by "ENSG" and one or more word characters (indicated by \w+) surrounded by double quotes.
######The pattern to be matched is enclosed in parentheses. This allows us to print it out from the special variable $1.
######The output of this perl command will be a long list of ENSG Ids. By piping to sort, then uniq, then word count we can count the unique number of genes in the file
######To learn more, see:
######http://perldoc.perl.org/perlre.html#Regular-Expressions
######http://www.perl.com/pub/2004/08/09/commandline.html
	
	
######Definitions:
######Reference genome - The nucleotide sequence of the chromosomes of a species.  Genes are the functional units of a reference genome and gene annotations describe the structure of transcripts expressed from those gene loci.  
######Gene annotations - Descriptions of gene/transcript models for a genome.  A transcript model consists of the *coordinates* of the exons of a transcript on a reference genome.  Additional information such as the strand the transcript is generated from, gene name, coding portion of the transcript, alternate transcript start sites, and other information may be provided.
######GTF (.gtf) file - A common file format referred to as Gene Transfer Format used to store gene and transcript annotation information.  You can learn more about this format here:
######http://genome.ucsc.edu/FAQ/FAQformat#format3
######http://genome.ucsc.edu/FAQ/FAQformat#format4
	
######The purpose of gene annotations (obtained as a .gtf file):
######When running the TopHat/Cufflinks/CuffDiff pipeline, known gene/transcript annotations are used for several purposes:
######a.) During the TopHat alignment step, annotations may be provided as a .gtf file using the '-G' option.  TopHat will align reads against the transcriptome first followed by the reference genome.
######b.) During the TopHat alignment step, a junctions database will be assembled from the transcripts in your .gtf file.  TopHat will align reads that do not map within an exon against this junctions database to identify spliced read alignments.  If an alignment still can not be found it will attempt to determine if the read corresponds to a novel exon-exon junction.
######c.) During the Cufflinks step, a .gtf file can be used to specify the transcript models to estimate expression estimates for using the '-G' option (not the same as the -G option for TopHat mentioned above).  This mode of Cufflinks will give you one expression estimate for each of the transcripts in your .gtf file giving you a 'microarray like' expression result.
######d.) During the Cufflinks step, a .gtf file can be used to 'guide' the assembly of novel transcripts (using the '-g' option).  Instead of assuming the known transcript models are correct, they are used as a guide and the resulting expression estimates will correspond to both known and novel/predicted transcripts.
######e.) During the Cuffdiff step, a .gtf file is used to determine the transcripts that will be examined for differential expression.  These may be known transcripts that you download from a public source or a .gtf of transcripts predicted by Cufflinks from the read data.
	
######Obtaining gene annotation files formatted for TopHat/Cufflinks/Cuffdiff.
######There are many possible sources of .gtf gene/transcript annotation files.  For example, from Ensembl, UCSC, RefSeq, etc.  Three options and related instructions for obtaining the gene annotation files are provided below.
	
######I.) ILLUMINA IGENOMES.  
######Formatted specifically for use with TopHat Cuffinks.  Based on UCSC, Refseq/NCBI, or Ensembl annotations.  Available for many species.  Bowtie indexed reference genome files are pre-computed for your convenience.  Download here:
######http://cufflinks.cbcb.umd.edu/igenomes.html
######a) Use wget (or similar) to download the Homo_sapiens_Ensembl_GRCh37.tar.gz file 
######b) This is found under Homo sapiens -> Ensembl -> GRCh37
######c) unzip/untar
######d) Individual chromosome fasta sequence files can be in Homo_sapiens/Ensembl/GRCh37/Sequence/Chromosomes/
######e) GTF file can be found in Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf
	
######II.) ENSEMBL FTP SITE  
######Based on Ensembl annotations only.  Available for many species.
######http://useast.ensembl.org/info/data/ftp/index.html
	
######III.) UCSC TABLE BROWSER  
######Based on UCSC annotations or several other possible annotation sources collected by UCSC. You might chose this option if you want to have a lot of flexibility in the annotations you obtain.  e.g. to grab only the transcripts from chromosome 22 as in the following example:
######a.) Open the following in your browser: http://genome.ucsc.edu/
######b.) Click 'Tables' at the top of the page.
######c.) Select 'Mammal', 'Human', and 'Feb. 2009 (GRCh37/hg19)' from the first row of drop down menus.
######d.) Select 'Genes and Gene Prediction Tracks' and 'UCSC Genes' from the second row of drop down menus.
######    To limit your selection to only chromosome 22, select the 'position' option beside 'region', enter 'chr22' in the 'position' box.
######e.) Select 'GTF - gene transfer format' for output format and enter 'UCSC_Genes.gtf' for output file.
######d.) Hit the 'get output' button and save the file.  Make note of its location
	
######In addition to the .gtf file you may find uses for some extra files providing alternatively formatted or additional information on the same transcripts.  For example:
######How to get a Gene bed file:
######f.) Change the output format to 'BED - browser extensible data'.
######g.) Change the output file to 'UCSC_Genes.bed', and hit the 'get output' button.
######h.) Make sure 'Whole Gene' is selected, hit the 'get BED' button, and save the file.
	
######How to get an Exon bed file:
######i.) Go back one page in your browser and change the output file to 'UCSC_Exons.bed', the hit the 'get output' button again.
######j.) Select 'Exons plus', enter 0 in the adjacent box, hit the 'get BED' button, and save the file.
	
######How to get gene symbols and descriptions for all UCSC genes:
######k.) Again go back one page in your browser and change the 'output format' to 'selected fields from primary and related tables'.
######l.) Change the output file to 'UCSC_Names.txt', and hit the 'get output' button.
######m.) Make sure 'chrom' is selected near the top of the page.
######m.) Under 'Linked Tables' make sure 'kgXref' is selected, and then hit 'Allow Selection From Checked Tables'.  This will link the table and give you access to its fields.
######n.) Under 'hg19.kgXref fields' select: 'kgID', 'geneSymbol', 'description'. 
######o.) Hit the 'get output' button and save the file.
	
######To get annotations for the whole genome, make sure 'genome' is selected beside 'region'.
######By default, the files downloaded above will be compressed.  To decompress, use 'gunzip filename' in linux.
	
######Important note on chromosome naming conventions:
######In order for your TopHat/Cufflinks analysis to work, the chromosome names in you .gtf file *must match* those in your reference genome (i.e. your reference genome fasta file).  If you get a Cufflinks result where all transcripts have an expression value of 0, you may have overlooked this.  Unfortunately, Ensembl, NCBI, and UCSC can not agree on how to name the chromosomes in many species, so this problem may come up often.  You can avoid this by getting a complete reference genome and gene annotation package from the Illumina iGenomes project mentioned above.
	
######Important note on reference genome builds:
######Your annotations must correspond to the same reference genome build as your reference genome fasta file.  e.g. both correspond to UCSC human build 'hg18', NCBI human build '37', etc..  Even if both your reference genome and annotations are from UCSC or Ensembl they could still correspond to different versions of that genome.  This would cause problems in any RNA-seq pipeline.
	
######INDEXING
######4.) Create a bowtie index of the genome and write it to a 'bwt' sub-directory
######Create a bowtie index for chr22 only
	cd $RNA_HOME/refs/hg19/
	mkdir -p bwt/22
	bowtie2-build fasta/22/22.fa bwt/22/22
	cp $RNA_HOME/refs/hg19/fasta/22/22.fa $RNA_HOME/refs/hg19/bwt/22/22.fa
	ls bwt/22/
	
######To create an index for all chromosomes instead of just chr22 you would do the following:
######cd $RNA_HOME/refs/hg19/
######mkdir bwt
######bowtie-build fasta/hg19.fa bwt/hg19
######mv $RNA_HOME/refs/hg19/fasta/hg19.fa $RNA_HOME/refs/hg19/bwt/
	
######OPTIONAL
######Create genome files for use with STAR
	cd $RNA_HOME/refs/hg19/
	mkdir -p star/22
	STAR --runMode genomeGenerate --genomeDir $RNA_HOME/refs/hg19/star/22 --genomeFastaFiles $RNA_HOME/refs/hg19/fasta/22/22.fa --runThreadN 8 --sjdbGTFfile $RNA_HOME/refs/hg19/genes/genes_chr22.gtf --sjdbOverhang 100
	
	
######RNA-SEQ DATA
######5.) Obtain RNA-seq test data.  
######The test data consists of colon cancer libraries for a Tumor and matched Normal comparison.  
######Tumor and Normal have 4 replicates each.  
######Each replicate actually corresponds to a different library preparation method using the same input RNAs.  
######Each library is marked as either cDNA-1 or cDNA2 and either lib1 or lib2
######cDNA-1 = total RNA (total)
######cDNA-2 = polyA selected RNA (polyA)
######lib1 = standard RNAseq (nocap)
######lib2 = cDNA capture RNAseq where library was enriched using probes targeting the exome (cap).
######e.g., The library called: *-Normal-cDNA-1-lib1 was constructed from total RNA and sequenced by standard RNAseq protocol (without cDNA capture).
######2 conditions (Normal/Tumor) x 4 replicates (total_nocap/total_cap/polyA_nocap/polyA_cap) = 8 sets of data.
	
######In this tutorial we will just compare the two cDNA capture libraries (lib2) from tumor vs normal (2 conditions with 2 "replicates" = 4 samples in total)
	
######Each data set has a corresponding pair of fastq files (read 1 and read 2 of paired end reads).  
######The reads are paired-end 101-mers generated on an Illumina HiSeq instrument.
######The test data has been pre-filtered for reads that appear to map to chromosome 22
	cd $RNA_HOME/
	mkdir -p data
	cd data
	
######Make a copy of the test data
	cp /media/cbwdata/CourseData/RNA_data/CBW_OvationV2_ds_10pc.tar .
	
######Unpack the test data.  You should see 12 sets of paired end fastq files
	tar -xvf CBW_OvationV2_ds_10pc.tar
	
######Enter the data directory and view the first two read records of a file (in fastq format each read corresponds to 4 lines of data)
	zcat H_KH-540077-Normal-cDNA-1-lib1_ds_10pc_1.fastq.gz | head -n 8
	zcat H_KH-540077-Normal-cDNA-1-lib1_ds_10pc_2.fastq.gz | head -n 8
	
######Identify the following components of each read: read name, read sequence, and quality string
	
######How many reads are there in the first library?
######Decompress file on the fly with 'zcat', pipe into 'grep', search for the read name prefix and pipe into 'wc' to do a word count ('-l' gives lines)
	zcat H_KH-540077-Normal-cDNA-1-lib1_ds_10pc_1.fastq.gz | grep -P "^\@HWI" | wc -l
	
	
######PRE-ALIGNMENT QC
######You can use FastQC to get a sense of your data quality before alignment
######http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
######Video Tutorial here: http://www.youtube.com/watch?v=bz93ReOv87Y
######Try to run it on one of your fastq files
######Go to the following url in your browser, right-click to save a fastq file to your laptop
######Note, you must replace cbw** with your own amazon instance number (e.g., "cbw01"))
######http://cbw**.ssh01.com/rnaseq/data/

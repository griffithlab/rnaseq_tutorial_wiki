###Note:
First, make sure your [[environment|Environment]] is set up correctly.

#1-i. Installation
Tools needed for this analysis are: samtools, bam-readcount, HISAT2, stringtie, gffcompare, htseq-count, flexbar, R, ballgown, fastqc and picard-tools. In the following installation example the installs are local and will work whether you have root (i.e. admin) access or not. However, if root is available some binaries can/will be copied to system-wide locations (e.g., /usr/bin/).

Set up tool installation location:

```bash

cd $RNA_HOME
mkdir tools
cd tools

```

##[SAMtools](http://samtools.sourceforge.net/)

```bash

cd $RNA_HOME/tools/
wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2
bunzip2 samtools-1.3.1.tar.bz2
tar -xvf samtools-1.3.1.tar
cd samtools-1.3.1
make
./samtools

```

##[bam-readcount](https://github.com/genome/bam-readcount)

```bash

cd $RNA_HOME/tools/
mkdir git
cd git
git clone --recursive git://github.com/genome/bam-readcount.git
cd $RNA_HOME/tools/
mkdir bam-readcount
cd bam-readcount
export SAMTOOLS_ROOT=$RNA_HOME/tools/samtools-1.3.1
cmake $RNA_HOME/tools/git/bam-readcount
make
./bin/bam-readcount

```

##[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml)

```bash
cd $RNA_HOME/tools/
wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.4-Linux_x86_64.zip
unzip hisat2-2.0.4-Linux_x86_64.zip
cd hisat2-2.0.4
./hisat2

```

##[StringTie](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)

```bash

cd $RNA_HOME/tools/
wget http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.3.0.Linux_x86_64.tar.gz
tar -xzvf stringtie-1.3.0.Linux_x86_64.tar.gz
cd stringtie-1.3.0.Linux_x86_64
./stringtie

```

##[gffcompare](http://ccb.jhu.edu/software/stringtie/gff.shtml#gffcompare)

```bash

cd $RNA_HOME/tools/
wget http://ccb.jhu.edu/software/stringtie/dl/gffcompare-0.9.8.Linux_x86_64.tar.gz
tar -xzvf gffcompare-0.9.8.Linux_x86_64.tar.gz
cd gffcompare-0.9.8.Linux_x86_64
./gffcompare

```

##[htseq-count](http://www-huber.embl.de/users/anders/HTSeq/doc/count.html)

```bash

cd $RNA_HOME/tools/
wget --no-check-certificate https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1p1.tar.gz
tar -zxvf HTSeq-0.6.1p1.tar.gz
cd HTSeq-0.6.1p1/
python setup.py install --user
chmod +x scripts/htseq-count
./scripts/htseq-count

```

##[FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
In addition to installing on the cloud you should also install FastQC on your own laptop/desktop

```bash

cd $RNA_HOME/tools/
wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip
unzip fastqc_v0.11.5.zip
cd FastQC/
chmod 755 fastqc
./fastqc --help

```

##[Picard](http://picard.sourceforge.net/command-line-overview.shtml)

```bash

cd $RNA_HOME/tools/
wget https://github.com/broadinstitute/picard/releases/download/2.6.0/picard.jar -O picard.jar
java -jar $RNA_HOME/tools/picard.jar

```
        
##[Flexbar](http://sourceforge.net/projects/flexbar/)

```bash

cd $RNA_HOME/tools/
wget https://github.com/seqan/flexbar/releases/download/v2.4.0/flexbar_v2.4_linux64.tgz
tar -xzvf flexbar_v2.4_linux64.tgz
cd flexbar_v2.4_linux64
export LD_LIBRARY_PATH=$RNA_HOME/tools/flexbar_v2.4_linux64:$LD_LIBRARY_PATH
./flexbar

```

##[R](http://www.r-project.org/)

This install takes a while so check if you have R installed already by typing `which R`.
It is already installed on the Cloud, but for completeness, here is how it was done. Please skip all R installation!

```bash

cd $RNA_HOME/tools/
export R_LIBS=
wget https://cran.r-project.org/src/base/R-3/R-3.2.5.tar.gz
tar -zxvf R-3.2.5.tar.gz
cd R-3.2.5
./configure --prefix=$RNA_HOME/tools/R-3.2.5/ --with-x=no
make
make install
./bin/Rscript

```

Note, if X11 libraries are not available you may need to use '--with-x=no' during config, on a regular linux system you would not use this option:

##R Libraries

For this tutorial we require:
- [devtools](https://cran.r-project.org/web/packages/devtools/index.html)
- [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)
- [gplots](http://cran.r-project.org/web/packages/gplots/index.html)
- [ggplot2](http://ggplot2.org/)

launch R (enter `R` at linux command prompt) and type the following at an R command prompt. NOTE: This has been pre-installed for you, so these commands can be skipped.

```R

install.packages(c("devtools","dplyr","gplots","ggplot2"),repos="http://cran.us.r-project.org")
quit(save="no")

```

##[Bioconductor](http://www.bioconductor.org/)

For this tutorial we require:
- [genefilter](http://bioconductor.org/packages/release/bioc/html/genefilter.html)
- [ballgown](http://bioconductor.org/packages/release/bioc/html/ballgown.html)
- [edgeR](http://www.bioconductor.org/packages/release/bioc/html/edgeR.html)

launch R (enter `R` at linux command prompt) and type the following at an R command prompt. If prompted, type "a" to update all old packages. NOTE: This has been pre-installed for you, so these commands can be skipped.

```R

source("http://bioconductor.org/biocLite.R")
biocLite(c("genefilter","ballgown","edgeR"))
quit(save="no")

```


---
##Practical Exercise 1 - Software Installation

Assignment: Install bedtools on your own. Make sure you install it in your tools folder. Download, unpack, compile, and test the bedtools software.

```bash 

cd $RNA_HOME/tools/

```

* Hint: google "bedtools" to find the source code
* Hint: there is a README file that will give you hints on how to install
* Hint: If your install has worked you should be able to run bedtools as follows:

```bash

$RNA_HOME/tools/bedtools2/bin/bedtools

```

Solution: When you are ready you can check your approach against the [Solutions](https://github.com/griffithlab/rnaseq_tutorial/wiki/Solutions#practical-exercise-1---software-installation)

---

##Add locally installed tools to your PATH [OPTIONAL]

To use the locally installed version of each tool without having to specify complete paths, you could add the install directory of each tool to your '$PATH' variable

```bash

export RNA_HOME=~/workspace/rnaseq

export RNA_DATA_DIR=$RNA_HOME/data
export RNA_DATA_TRIM_DIR=$RNA_DATA_DIR/trimmed

export RNA_REFS_DIR=$RNA_HOME/refs
export RNA_REF_INDEX=$RNA_REFS_DIR/chr22_with_ERCC92
export RNA_REF_FASTA=$RNA_REF_INDEX.fa
export RNA_REF_GTF=$RNA_REF_INDEX.gtf

export RNA_ALIGN_DIR=$RNA_HOME/alignments/hisat2

export PATH=$RNA_HOME/tools/samtools-1.3.1:$RNA_HOME/tools/bam-readcount/bin:$RNA_HOME/tools/hisat2-2.0.4:$RNA_HOME/tools/stringtie-1.3.0.Linux_x86_64:$RNA_HOME/tools/gffcompare-0.9.8.Linux_x86_64:$RNA_HOME/tools/HTSeq-0.6.1p1/scripts:$RNA_HOME/tools/R-3.2.5/bin:$RNA_HOME/tools/FastQC:$RNA_HOME/tools/flexbar_v2.4_linux64:/home/ubuntu/bin/bedtools2/bin:$PATH

echo $PATH

```

You can make these changes permanent by adding the above lines to your .bashrc file
use a text editor to open your bashrc file. For example:

```bash

vi ~/.bashrc

```

###Vi instructions

1. Using your cursor, navigate down to the "export PATH" commands at the end of the file.
2. Delete the line starting with PATH using the vi command "dd".
3. Press the "i" key to enter insert mode. Go to an empty line with you cursor and copy paste the new RNA_HOME and PATH commands into the file
4. Press the "esc" key to exit insert mode.
5. Press the ":" key to enter command mode.
6. Type "wq" to save and quit vi

If you would like to learn more about how to use vi, try this tutorial/game: [VIM Adventures](http://vim-adventures.com/)

NOTE: If you are worried your .bashrc is messed up you can redownload as follows:

```bash

cd ~
wget -N https://github.com/griffithlab/rnaseq_tutorial/wiki/config/.bashrc

```

## Installing tools from official ubuntu packages [OPTIONAL]

Some useful tools are available as official ubuntu packages.  These can be installed using the linux package management system `apt`.  Most bioinformatic tools (especially the latest versions) are not available as official packages.  Nevertheless, here is how you would update your `apt` library, upgrade existing packages, and install an Ubuntu tool called `tree`.

```bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install tree
tree

```

| [[Previous Section|Resources]] | [[This Section|Installation]] | [[Next Section|Reference-Genome]]     |
|:------------------------------:|:-----------------------------:|:-------------------------------------:|
| [[Resources|Resources]]        | [[Installation|Installation]] | [[Reference Genomes|Reference-Genome]] |

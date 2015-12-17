# 5-v. Proposed improvements

### More independent exercises, group exercises, and integrated assignments
- Each module should have at least two exercises where the students are not copying/pasting anything.  One could be at 1/2 way point, and the other at the end of the module.  The one at the end could be a group exercise.
- Each day should end with at least one hour of integrated assignment.

### Update the AMI to use bash instead of dash as default shell
The STAR aligner currently throws errors when run on an ubuntu system because `/bin/sh` is linked to `/bin/dash` and not to `/bin/bash`.

```
ls -l /bin/sh
sudo mv /bin/sh /bin/sh.orig
sudo ln -s /bin/bash /bin/sh
```

### Install 'tree' command into the AMI
Pre-install the `tree` command in the Amazon AMI so that it is ready for students to use

### Install 'pip' command into the AMI
In order for htseq-count to use bam files directly it needs pysam. This can be installed with pip but that is not available by default.

Then, On AMI install and test htseq-count with bam files:
```
sudo apt-get install python-pip
sudo pip install pysam
```

An alternative install procedure that has been tested and worked is as follows. The above procedure is preferred and should be tried first.

```
cd ~/bin/
wget https://pysam.googlecode.com/files/pysam-0.7.5.tar.gz
tar -zxvf pysam-0.7.5.tar.gz
cd pysam-0.7.5/
python setup.py build
sudo python setup.py install
```

### Get X11 support working on AMI
For R and other applications it would be nice if X11 worked. Note the install instructions for R would need to change as well.

### Create a trimming section 
Create a wiki section and exercise that summarizes read trimming concepts. Start with some raw data, including aligned reads.  Align these reads without any trimming and assess alignment statistics using Picard, FastQC, etc.  Now take these same reads and perform both adaptor trimming and quality trimming.  Re-align the trimmed reads and assess the effect of trimming on alignment metrics.

### Add a Vi/Vim tutorial and pre-requisites/resources to course

### Add RSeQC to tutorial
Add installation and running of RSeQC 
This could possible replace Samstat which never works very well

### Create a batch effect section
We should add a section about batch effects.  Both detecting the presence of batch effects as well as correcting for them during analysis.

### Add documentation to detailed cloud tutorial to provide some better security practices
For convenience the cloud instances have been set up with very permissive security. Some better practices should be documented. 

### Add a fusion detection section
We previously had a fusion detection module but it was difficult to complete in time frames appropriate for a workshop.  Further optimization is required.  Another challenge is the lack of well engineered fusion detection software.  This publication [State-of-the-art fusion-finder algorithms sensitivity and specificity](http://www.ncbi.nlm.nih.gov/pubmed/23555082) does a decent job of summarizing the current options available.  Another caveat of this topic is that is mostly of interest to cancer researchers so it might only be included where there are sufficient students with this interest.

### Improve alignment QC section
In particular we should add use of `Picard CollectRnaSeqMetrics` (https://broadinstitute.github.io/picard/command-line-overview.html) and `RNA-SeQC` (http://www.broadinstitute.org/cancer/cga/rna-seqc).  It would also be good to include use of splicing metrics calculated from the TopHat junctions files.  A standalone version of the TGI tool that does this would need to be created for this purpose.

### Improve Expression/Differential expression lectures
There a some nice slides/concepts that we could borrow from the BaseSpace Demo slides (see Obi's ~/Dropbox Teaching/CSHL/2015/Workshop-CSHL-RNA-Seq-Metagenomics.pdf).

### Create a genome reference free analysis module.
Can expand on the current Kallisto exercise.

### Add more content on downstream analysis
For example, pathway analysis of RNA-seq data, clustering, etc.

### Identify more interesting data sets to use for the alternative splicing module
http://www.ncbi.nlm.nih.gov/gds/?term=rna-seq+splicing
- [GSE63953](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63953)
- [GSE63375](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63375)
- [GSE63569](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63569)
- [GSE45119](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE45119)
- [GSE48263](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE48263)
- [GSE44402](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE44402)

Gray lab breast cancer cell line dataset:
- http://www.ncbi.nlm.nih.gov/pubmed/24176112
- https://www.biostars.org/p/111040/ (biostars tutorial on downloading data)
- https://github.com/genome/gms/wiki/Guide-to-Importing-and-Analyzing-External-Data (another guide on downloading and reformatting this data)

### Update the tutorial to take into account recent developments in RNA-seq analysis methods, best practices, and new tools
- [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml)
- [StringTie](http://www.nature.com/nbt/journal/v33/n3/full/nbt.3122.html )
- [Ballgown](http://www.ncbi.nlm.nih.gov/pubmed/25748911)
- [Kallisto](http://arxiv.org/abs/1505.02710) and Sleuth
- [Salmon](https://github.com/COMBINE-lab/salmon)
- [featureCounts](http://bioinf.wehi.edu.au/featureCounts/) instead of HtSeq

Perhaps HISAT2 can be used instead of TopHat/STAR.  Using only a single aligner would save time for exploring more concepts downstream. Not sure of the value of using multiple alignments anyway. Time to shift focus a bit more towards the downstream stuff as alignment and QC become more routine.


| [[Previous Section|Integrated-Assignment]]       | [[This Section|Proposed-Improvements]] | [[Next Section|AWS-Setup]]   |
|:------------------------------------------------------------:|:--------------------------:|:-------------------------------------------:|
| [[Integrated Assignment|Integrated-Assignment]] | [[Proposed Improvements|Proposed-Improvements]]    | [[AWS Setup|AWS-Setup]] |

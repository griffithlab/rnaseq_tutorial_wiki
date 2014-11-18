
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
In order for htseq-count to use bam files directly it needs pysam. This can be installed with pip but that is not available by default. Remove the install method of pysam from [[Expression|Expression]] page.

Then, On AMI install and test htseq-count with bam files:
```
sudo apt-get install python-pip
sudo pip install pysam
```

### Create a trimming section 
Create a wiki section and exercise that summarizes read trimming concepts. Start with some raw data, including aligned reads.  Align these reads without any trimming and assess alignment statistics using Picard, FastQC, etc.  Now take these same reads and perform both adaptor trimming and quality trimming.  Re-align the trimmed reads and assess the effect of trimming on alignment metrics.

### Add integrated assignment content to the wiki
Get the integrated wiki from CBW and incorporate that here.


| [[Previous Section|Solutions]]       | [[This Section|Proposed-Improvements]] | [[Next Section|AWS-Setup]]   |
|:------------------------------------------------------------:|:--------------------------:|:-------------------------------------------:|
| [[Solutions|Solutions]] | [[Proposed Improvements|Proposed-Improvements]]    | [[AWS Setup|AWS-Setup]] |
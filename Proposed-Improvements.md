## 6-iii. Proposed improvements

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

### Create a trimming section 
Create a wiki section and exercise that summarizes read trimming concepts. Start with some raw data, including aligned reads.  Align these reads without any trimming and assess alignment statistics using Picard, FastQC, etc.  Now take these same reads and perform both adaptor trimming and quality trimming.  Re-align the trimmed reads and assess the effect of trimming on alignment metrics.

### Add integrated assignment content to the wiki
Get the integrated wiki from CBW and incorporate that here.

### Create a batch effect section
We should add a section about batch effects.  Both detecting the presence of batch effects as well as correcting for them during analysis.

### Improve Cloud exercise
Have students actually spin up their own instances using IAM accounts (with one set up per student before the course). They would then be provided with their IAM user name, the appropriate AWS account #, and a default password. This account would have limited permissions to start EC2 instances but not much else.


| [[Previous Section|Solutions]]       | [[This Section|Proposed-Improvements]] | [[Next Section|AWS-Setup]]   |
|:------------------------------------------------------------:|:--------------------------:|:-------------------------------------------:|
| [[Solutions|Solutions]] | [[Proposed Improvements|Proposed-Improvements]]    | [[AWS Setup|AWS-Setup]] |
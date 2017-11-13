# 7-vii. Amazon AWS/AMI setup for use in workshop

This tutorial explains how Amazon cloud instances were configured for the course.  This exercise is not to be completed by the students but is provided as a reference for future course developers that wish to conduct their hands on exercises on Amazon AWS.

Before proceeding with below, first check to see if there are any [[Proposed Improvements|Proposed-Improvements]] to incorporate. 

### Create AWS account

A helpful tutorial can be found here:
https://github.com/genome/gms/wiki/Developers-guide-to-installing-the-GMS-on-an-AWS-instance

1. Create a new gmail account to use for the course
2. Use the above email account to set up a new AWS/Amazon user account.
Note: Any AWS account needs to be linked to an actual person and credit card account.
3. Optional - Set up an IAM account. Give this account full EC2 but no other permissions. This provides an account that can be shared with other instructors but does not have access to billing and other root account privelages.
4. Request limit increase for limit types you will be using. You need to be able to spin up at least one instance of the desired type for every student and TA/instructor. See: http://aws.amazon.com/about-aws/whats-new/2014/06/19/amazon-ec2-service-limits-report-now-available/. Note: You need to request an increase for each instance type and *region* you might use.
5. Sign into AWS Management Console: http://aws.amazon.com/console/
6. Go to EC2 services

### Start with existing community AMI

1. Select Launch instance. Search Community AMIs for and select `ubuntu/images/hvm-ssd/ubuntu-artful-17.10-amd64-server-20171026.1 - ami-3702cc4f`. Choose an instance type of `m4.2xlarge`. Increase root volume (e.g., 32GB) and add a second volume (e.g., 250gb). Review and Launch. If necessary, create a new key pair, name and save somewhere safe. Select 'View Instances'. Take note of public IP address of newly launched instance.
2. Change permissions on downloaded key pair with `chmod 400 [instructor-key].pem`
3. Login to instance with ubuntu user:

`ssh -i [instructor-key].pem ubuntu@[public.ip.address]`

### Perform basic linux configuration 

* To allow installation of bioinformatics tools some basic dependencies must be installed first.
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install make gcc zlib1g-dev libncurses5-dev libncursesw5-dev git cmake build-essential unzip python-dev python-numpy gfortran libreadline-dev default-jdk libx11-dev libxt-dev xorg-dev libxml2-dev libcurl4-openssl-dev apache2 python-pip csh ruby-full gnuplot cpanminus r-base libssl-dev gcc-4.8 g++-4.8
sudo timedatectl set-timezone America/New_York
```

* logout and log back in

### Set up additional storage for workspace
We may need to run a setup script to mount a workspace folder on ephemeral (or EBS) storage. This can not really be done ahead of time in the saved AMI. See https://github.com/griffithlab/rnaseq_tutorial/blob/master/setup/preinstall.sh. This script has been provided in the home directory of the AMI. It just needs to be run at first launch of the student instance. Copy/download the preinstall.sh script to the ubuntu home directory and create the necessary dirs and links as below. But, do not run `bash preinstall.sh` until later when actually spinning up student/instructor instance. NOTE: This may or may not be necessary depending on how you set up volumes and type of instance you choose. For example, if you setup an extra EBS volume (instead of relying on ephemeral storage) and mount this drive (for storing working data) and you create the appropriate fstab entries then create an AMI, new instances may just be ready to go. See https://github.com/griffithlab/rnaseq_tutorial/blob/master/setup/setup_mounts.sh
```
cd ~
ln -s /workspace workspace
```
### Install any desired informatics tools
* See https://github.com/griffithlab/rnaseq_tutorial/wiki/Installation for RNA-seq software
* Note: R in particular is a slow install. 
* All tools can be installed locally (e.g., /home/ubuntu/bin/) in a different location from where students will install tools in their exercises.
* Paths to pre-installed tools can be added to the .bashrc file. It may also be convenient to add `export RNA_HOME=~/workspace/rnaseq` to the .bashrc file. 
 * See https://github.com/griffithlab/rnaseq_tutorial/blob/master/setup/.bashrc.
*Note: In some installations of R there is an executable called pager that clashes with the system pager. This causes man to fail. Check with a `man ls` and if the problem exists, add the following to .bashrc:
```
export MANPAGER=less
```

#### Install TABIX (GEMINI pre-req)
```
sudo apt-get install tabix
```

#### Install GEMINI
```
mkdir -p $WORKSPACE/lib/gemini
mkdir -p $HOME/bin
wget https://raw.github.com/arq5x/gemini/master/gemini/scripts/gemini_install.py
sudo python gemini_install.py $HOME $WORKSPACE/lib/gemini
```

#### Install ALLPATHS-LG
```
# Install prerequisites
sudo apt install graphviz libgmp3-dev
cd $TOOLS
wget https://github.com/broadinstitute/picard/releases/download/2.14.1/picard.jar

wget ftp://ftp.broadinstitute.org/pub/crd/ALLPATHS/Release-LG/latest_source_code/LATEST_VERSION.tar.gz
tar -xvzf LATEST_VERSION.tar.gz
cd allpathslg-52488/
ln -s /usr/bin/gcc-4.8 gcc
ln -s /usr/bin/g++-4.8 g++
PATH=$PWD:$PATH
./configure --prefix=$TOOLS/allpathslg-52488/
make
make install
```

#### Install MUMmer
```
wget http://downloads.sourceforge.net/project/mummer/mummer/3.23/MUMmer3.23.tar.gz
tar -zxvf MUMmer3.23.tar.gz
cd MUMmer3.23
make check
make install
```

#### Install sniffles
```
wget https://github.com/fritzsedlazeck/Sniffles/archive/master.tar.gz -O Sniffles.tar.gz
tar -xzvf Sniffles.tar.gz
cd Sniffles-master/
mkdir -p build/
cd build/
cmake ..
make
```

#### Install NGM-LR
```
wget https://github.com/philres/ngmlr/releases/download/v0.2.6/ngmlr-0.2.6-beta-linux-x86_64.tar.gz
tar -xvzf ngmlr-0.2.6-beta-linux-x86_64.tar.gz
```

#### Install BWA
```
git clone https://github.com/lh3/bwa.git
cd bwa
make
```

#### Install SURVIVOR
```
git clone https://github.com/fritzsedlazeck/SURVIVOR.git
cd SURVIVOR/Debug
make
```

#### Install gkno
```
wget http://ftp.ps.pl/pub/apache//ant/binaries/apache-ant-1.9.9-bin.tar.gz
tar -xvzf apache-ant-1.9.9-bin.tar.gz
cd apache-ant-1.9.9
ANT_HOME=$TOOLS/apache-ant-1.9.9
PATH=$PATH:${ANT_HOME}/bin

cd $TOOLS
git clone https://github.com/gkno/gkno_launcher.git
cd gkno_launcher/
ln -s /usr/bin/gcc-4.8 gcc
ln -s /usr/bin/g++-4.8 g++
PATH=$TOOLS/gkno_launcher:$PATH
C=gcc-4.8 CXX=g++-4.8 ./gkno build

wget http://genomedata.org/seq-tec-workshop/gkno-precompiled-deps.tar.gz
tar -xvzf gkno-precompiled-deps.tar.gz
cp gkno-precompiled-deps/vt tools/vt
cp -r gkno-precompiled-deps/bin tools/vcflib

mkdir -p $DATA/gkno
mv resources/ $DATA/gkno
ln -s $DATA/gkno/resources
```

open the file: `PATH_TO_GKNO_LAUNCHER/src/gkno/conf/user_settings.json`

There is a list of compiled tools. Just add `vt`, and `vcflib` to this list, and gkno will think they are available.

#### Install salmon
```
wget https://github.com/COMBINE-lab/salmon/releases/download/v0.8.2/Salmon-0.8.2_linux_x86_64.tar.gz
tar -xvzf Salmon-0.8.2_linux_x86_64.tar.gz
```

#### Install bedtools
```
git clone https://github.com/arq5x/bedtools2.git
cd bedtools2
make
sudo make install
```

#### Install trinity (with gmap, bowtie2, emacs)
```
#prepreqs:
sudo apt-get install gmap bowtie2 emacs25

#data:
cd $DATA
wget http://genomedata.org/seq-tec-workshop/trinity.tar.gz
tar -xvzf trinity.tar.gz

#trinity:
wget https://github.com/trinityrnaseq/trinityrnaseq/archive/Trinity-v2.5.1.tar.gz
tar -xvzf Trinity-v2.5.1.tar.gz
cd trinityrnaseq-Trinity-v2.5.1/Chrysalis/
rm Makefile
wget http://genomedata.org/seq-tec-workshop/Makefile
cd ..
make
```

#### Install NCBI SRA toolkit and NCBI E-Utilities
```
sudo cpanm HTML::Entities
sudo cpanm LWP::Simple
cd /home/ubuntu/bin/
wget ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.tar.gz
tar -zxvf edirect.tar.gz
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
tar -zxvf sratoolkit.current-ubuntu64.tar.gz
export PATH=/home/ubuntu/bin/sratoolkit.2.5.4-1-ubuntu64/bin:$PATH
export PATH=/home/ubuntu/bin/edirect:$PATH
#For testing
fastq-dump -X 5 -Z SRR925811
esearch -db sra -query PRJNA40075  | efetch --format runinfo | cut -d ',' -f 1 | grep SRR | head -5 | xargs fastq-dump -X 10 --split-files
```

#### Download data files
```
cd $WORKSPACE
mkdir -p data/fasta/GRCh38
cd data/fasta/GRCh38
wget ftp://ftp.ensembl.org/pub/release-86/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
gunzip Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
wget ftp://ftp.ensembl.org/pub/release-86/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.chromosome.22.fa.gz
gunzip Homo_sapiens.GRCh38.dna_sm.chromosome.22.fa.gz
wget http://tools.thermofisher.com/downloads/ERCC92.fa
mkdir ../GRCh37
cd ../GRCh37
wget ftp://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna_sm.primary_assembly.fa.gz
gunzip Homo_sapiens.GRCh37.75.dna_sm.primary_assembly.fa.gz
wget ftp://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna_sm.chromosome.22.fa.gz
gunzip Homo_sapiens.GRCh37.75.dna_sm.chromosome.22.fa.gz
cd ../..
mkdir -p annotations/GRCh38
cd annotations/GRCh38
wget ftp://ftp.ensembl.org/pub/release-86/gtf/homo_sapiens/Homo_sapiens.GRCh38.86.gtf.gz
gunzip Homo_sapiens.GRCh38.86.gtf.gz
wget http://genome.wustl.edu/pub/rnaseq/data/brain_vs_uhr_w_ercc/ERCC/ERCC92_fix.gtf
awk ‘($1 == 22)’ > chr22.gtf
cat chr22.gtf ERCC92_fix.gtf > chr22_with_ERCC92.gtf
mkdir ../GRCH37
cd ../GRCH37
wget ftp://ftp.ensembl.org/pub/release-75/gtf/homo_sapiens/Homo_sapiens.GRCh37.75.gtf.gz
gunzip Homo_sapiens.GRCh37.75.gtf.gz

```

### Set up Apache web server
We will start an apache2 service and serve the contents of the students home directories for convenience. This allows easy download of files to their local hard drives, direct loading in IGV by url, etc. Note that when launching instances a security group will have to be selected/modified that allows http access via port 80.

* Edit config to allow files to be served from outside /usr/share and /var/www
```
sudo vim /etc/apache2/apache2.conf
```

* Add the following content to apache2.conf
```
<Directory /home/ubuntu/>
       Options Indexes FollowSymLinks
       AllowOverride None
       Require all granted
</Directory>
```

* Edit vhost file
```
sudo vim /etc/apache2/sites-available/000-default.conf
```

* Change document root in 000-default.conf
```
DocumentRoot /home/ubuntu
```

* Restart apache
```
sudo service apache2 restart
```

### Save a snapshot of workspace volume
To create a snapshot of the extra workspace volume, navigate to volumes, right-click, and choose Create Snapshot. Take note of the snapshot id for reference later (e.g., snap-154dc64c)

### Save a public AMI

Finally, save the instance as a new AMI by right clicking the instance and clicking on "Create Image". Enter an appropriate name and description and then save. If desired you may choose at this time to include the workspace snapshot in the AMI to avoid having to explicitly attach it later at launching of AMI instances. Change the permissions of the AMI to "public" if you would like it to be listed under the Community AMIs. Copy the AMI to any additional regions where you would like it to appear in Community AMI searches.

### Current Public AMIs:

* cshl_seqtec_2016_v7 - ami-1fa8067f (US West - Oregon)

### Create IAM account

From AWS Console select Services -> IAM. Go to Users, Create User, specify a user name, and Create. Download credentials to a safe location for later reference if needed. Select the new user and go to Security Credentials -> Manage Password -> 'Assign a Custom Password'. Go to Groups -> Create a New Group, specify a group name and Next. Attach a policy to the group. In this case we give all EC2 privileges but no other AWS privileges by specifying "AmazonEC2FullAccess". Hit Next, review and then Create Group. Select the Group -> Add Users to Group, select your new user to add it to the new group.

### Launch student instance
1. Go to AWS console. Login. Select EC2.
2. Launch Instance, search for "cshl_seqtec_2017_v1" in Community AMIs and Select.
3. Choose "m4.2xlarge" instance type.
4. Select one instance to launch (e.g., one per student and instructor), and select "Protect against accidental termination"
5. Make sure that you see two snapshots (e.g., the 32GB root volume and 80GB EBS volume you set up earlier)
6. Create a tag with name=StudentName
7. Choose existing security group call "SSH_HTTP_8081_IN_ALL_OUT". Review and Launch.
8. Choose an existing key pair (either CSHL.pem)
9. View instances and wait for them to finish initiating.
10. Find your instance in console and select it, then hit connect to get your public.ip.address.
11. Login to node `ssh -i cshl_2017.pem ubuntu@[public.ip.address]`.
12. Optional - set up DNS redirects (see below)

### Set up a dynamic DNS service

Rather than handing out ip addresses for each student instance to each student you can instead set up DNS records to redirect from a more human readable name to the IP address. After spinning up all student instances, use a service like http://dyn.com (or http://entrydns.net, http://dyn.com/, etc.) to create hostnames like rna01.dyndns.org, rna02.dyndns.org, etc that point to each public IP address of student instances.

### Host necessary files for the course

Currently, all miscellaneous data files, annotations, etc. are hosted on an ftp server at the Genome Institute. In the future more data files could be pre-loaded onto the EBS snapshot. 

* Files copied to: /gscmnt/sata102/info/ftp-staging/pub/rnaseq/
* Appear here: http://genome.wustl.edu/pub/rnaseq/

### After course reminders
* Delete the student IAM account created above otherwise students will continue to have EC2 privileges. 
* Terminate all instances and clean up any unnecessary volumes, snapshots, etc. 

| [[Proposed Improvements\|Proposed-Improvements]]       | [[This Section\|AWS-Setup]] | Next Section   |
|:------------------------------------------------------------:|:--------------------------:|:-------------------------------------------:|
| [[Proposed Improvements\|Proposed-Improvements]] | [[AWS Setup\|AWS-Setup]]    |  |

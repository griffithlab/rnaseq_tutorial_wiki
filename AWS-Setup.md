##6-v. Amazon AWS/AMI setup for use in workshop

This tutorial explains how Amazon cloud instances were configured for the course.  This exercise is not to be completed by the students but is provided as a reference for future course developers that wish to conduct their hands on exercises on Amazon AWS.

###Create AWS account

A helpful tutorial can be found here:
https://github.com/genome/gms/wiki/Developers-guide-to-installing-the-GMS-on-an-AWS-instance

1. Create a new gmail account to use for the course
2. Use the above email account to set up a new AWS/Amazon user account.
Note: Any AWS account needs to be linked to an actual person and credit card account.
3. Optional - Set up an IAM account. Give this account full EC2 but no other permissions. This provides an account that can be shared with other instructors but does not have access to billing and other root account privelages.
4. Request limit increase for limit types you will be using. You need to be able to spin up at least one instance of the desired type for every student and TA/instructor. See: http://aws.amazon.com/about-aws/whats-new/2014/06/19/amazon-ec2-service-limits-report-now-available/. Note: You need to request an increase for each instance type and *region* you might use.
5. Sign into AWS Management Console: http://aws.amazon.com/console/
6. Go to EC2 services

###Start with existing community AMI

1. Select Launch instance. Search Community AMIs for and select "Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-3d50120d". Choose an instance type of "m3.xlarge". Review and Launch. If necessary, create a new key pair, name and save somewhere safe. Select 'View Instances'. Take note of public IP address of newly launched instance.
2. Change permissions on downloaded key pair with `chmod 600 [instructor-key].pem`
3. Login to instance with ubuntu user:

`ssh -i [instructor-key].pem ubuntu@[public.ip.address]`

###Perform basic linux configuration 
* To allow installation of bioinformatics tools some basic dependencies must be installed first.
```
sudo apt-get update
sudo apt-get -y install make gcc zlib1g-dev libncurses5-dev libncursesw5-dev git cmake build-essential unzip python-dev python-numpy gfortran libreadline-dev default-jdk libx11-dev libxt-dev xorg-dev libxml2-dev libcurl4-openssl-dev apache2 python-pip
```
* logout and log back in

###Install any desired informatics tools
* See https://github.com/griffithlab/rnaseq_tutorial/wiki/Installation 
* Note: R in particular is a slow install. This should be installed globally with sudo.
* All other tools can be installed locally (e.g., /home/ubuntu/bin/) in a different location from where students will install tools in their exercises.
* Paths to pre-installed tools can be added to the .bashrc file. It may also be convenient to add `export RNA_HOME=~/workspace/rnaseq` to the .bashrc file. 
 * See https://github.com/griffithlab/rnaseq_tutorial/blob/master/setup/.bashrc.

###Set up additional storage for workspace
We will need to run a setup script to mount a workspace folder on ephemeral storage. This can't really be done ahead of time in the saved AMI. See https://github.com/griffithlab/rnaseq_tutorial/blob/master/setup/preinstall.sh. This script has been provided in the home directory of the AMI. It just needs to be run at first launch of the student instance. Copy/download the preinstall.sh script to the ubuntu home directory and create the necessary dirs and links as below. But, do not run `bash preinstall.sh` until later when actually spinning up student/instructor instance.
```
mkdir /workspace
cd ~
ln -s /workspace workspace
```

###Set up Apache web server
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

###Save a public AMI

Finally, save the instance as a new AMI by right clicking the instance and clicking on "Create Image". Enter an appropriate name and description and then save. Change the permissions of the AMI to "public" if you would like it to be listed under the Community AMI's. Copy the AMI to any additional regions where you would like it to appear in Community AMI searches.

###Current Public AMIs:

* cshl_seqtec_rnaseq_2014_v2 - ami-7ff4bf4f (US West - Oregon)
* cshl_seqtec_rnaseq_2014_v2 - ami-eeae3b86 (US East - N. Virginia)
* cshl_seqtec_rnaseq_2014_v2 - ami-9df1e7d8 (US West - N. California)

###Launch student instances
1. Go to AWS console.
2. Launch Instance, search for "cshl_seqtec_rnaseq_2014_v2" in Community AMIs and Select.
3. Choose "m3.2xlarge" instance type.
4. Select number of instances to launch (e.g., one per student and instructor)
5. Leave options as default until 'Configure Security Group'. Choose existing security group call "SSH_HTTP_IN_ALL_OUT". Review and Launch.
6. Choose an existing key pair (either CSHLRNA or instructor-key)
7. View instances and wait for them to finish initiating.
8. Login to each node `ssh -i [instructor-key].pem ubuntu@[public.ip.address]` and run `bash preinstall.sh`.
9. Create DNS hostname for each IP address (see below).

###Set up a dynamic DNS service

Rather than handing out ip addresses for each student instance to each student you can instead set up DNS records to redirect from a more human readable name to the IP address. After spinning up all student instances, use a service like http://dyn.com to create hostnames like rna01.dyndns.org, rna02.dyndns.org, etc that point to each public IP address of student instances.

| [[Proposed Improvements|Proposed-Improvements]]       | [[This Section|AWS-Setup]] | Next Section   |
|:------------------------------------------------------------:|:--------------------------:|:-------------------------------------------:|
| [[Proposed Improvements|Proposed-Improvements]] | [[AWS Setup|AWS-Setup]]    |  |

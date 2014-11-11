##Amazon AWS/AMI setup for AWS use in workshop

1. Create a new gmail account to use for the course
2. Use the above email account to set up a new AWS/Amazon user account.
Note: Any AWS account needs to be linked to an actual person and credit card account.
3. Optional - Set up an IAM account. Give this account full EC2 but no other permissions. This provides an account that can be shared with other instructors but does not have access to billing and other root account privelages.
4. Request limit increase for limit types you will be using. You need to be allowed to spin up at least one for every student and TA/instructor. See: http://aws.amazon.com/about-aws/whats-new/2014/06/19/amazon-ec2-service-limits-report-now-available/. Note: You need to request an increase for each instance type and *region* you might use.
5. Sign into AWS Management Console: http://aws.amazon.com/console/
6. Go to EC2 services

##New AMI setup:

1. Select Launch instance. Search Community AMIs for and select "Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-3d50120d". Choose an instance type of "m3.xlarge". Review and Launch. If necessary, create a new key pair, name and save somewhere safe. Select 'View Instances'. Take note of public IP address of newly launched instance.
2. Change permissions on downloaded key pair with `chmod 600 [instructor-key].pem`
3. Login to instance with ubuntu user:

`ssh -i [instructor-key].pem ubuntu@[public.ip.address]`

##Basic linux admin setup needed to allow installation of bioinformatics tools:
```
sudo apt-get update
sudo apt-get -y install make gcc zlib1g-dev libncurses5-dev libncursesw5-dev git cmake build-essential unzip python-dev python-numpy gfortran libreadline-dev default-jdk libx11-dev libxt-dev xorg-dev libxml2-dev libcurl4-openssl-dev
```

logout and log back in

Pre-install any desired informatics tools (https://github.com/griffithlab/rnaseq_tutorial/wiki/Installation). Note: R in particular is a slow install. This should be installed globally with sudo.

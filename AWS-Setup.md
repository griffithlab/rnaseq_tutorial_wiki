Amazon AWS/AMI setup for AWS use in workshop
1. Create a new gmail account to use for the course
2. Use the above email account to set up a new AWS/Amazon user account.
Note: Any AWS account needs to be linked to an actual person and credit card account.
3. Optional - Set up an IAM account. Give this account full EC2 but no other permissions. This provides an account that can be shared with other instructors but does not have access to billing and other root account privelages.
4. Sign into AWS Management Console: http://aws.amazon.com/console/


Request limit increase for limit types you will be using. You need to be allowed to spin up at least one for every student and TA/instructor.
See: http://aws.amazon.com/about-aws/whats-new/2014/06/19/amazon-ec2-service-limits-report-now-available/
Note: You need to request an increase for each instance type and *region* you might use. Here is the link to limits for Oregon region:
https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#Limits:

New AMI setup:
Start with "Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-3d50120d" AMI

Launch instance with Instance type of: m3.xlarge
Login to instance with ubuntu user:

Basic linux admin setup needed for to allow installation of bioinformatics tools
sudo apt-get update
sudo apt-get -y install make gcc zlib1g-dev libncurses5-dev libncursesw5-dev git cmake build-essential unzip python-dev python-numpy gfortran libreadline-dev default-jdk libx11-dev libxt-dev xorg-dev libxml2-dev libcurl4-openssl-dev

logout and log back in

Pre-install any desired informatics tools:
https://github.com/griffithlab/rnaseq_tutorial/wiki/Installation

Note: R in particular is a slow install. This should be installed globally with sudo.

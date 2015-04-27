#0-vi. Environment
This tutorial assumes use of a Linux computer with an 'x86_64' architecture.  The rest of the tutorial should be conducted in a linux Terminal session.  In other words you must already be logged into the Amazon EC2 instance as described in the previous section.

Before proceeding you must define a global working directory by setting the environment variable: 'RNA_HOME'  
Log into a server and SET THIS BEFORE RUNNING EVERYTHING.    

Create a working directory and set the 'RNA_HOME' environment variable

	mkdir -p ~/workspace/rnaseq/
	export RNA_HOME=~/workspace/rnaseq
	
Make sure whatever the working dir is, that it is set and is valid

	echo $RNA_HOME

You can place the RNA_HOME variable in your .bashrc and then logout and login again to avoid having to worry about it. This has been done for you in the pre-configured amazon instance that you will be using.

| [[Previous Section|Logging-into-Amazon-Cloud]]          | [[This Section|Environment]] | [[Next Section|Resources]] |
|:-------------------------------------------------------:|:----------------------------:|:--------------------------------------------:|
| [[Logging into Amazon Cloud|Logging-into-Amazon-Cloud]] | [[Environment|Environment]]  | [[Resources|Resources]]         |

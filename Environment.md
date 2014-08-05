#ENVIRONMENT
Before proceeding you must define a global working directory by setting the environment variable: 'RNA_HOME'  
Log into a server and SET THIS BEFORE RUNNING EVERYTHING.    
You can then PLACE IT IN YOUR .bashrc and then logout and login again to avoid having to worry about it 

Create a working directory and set the 'RNA_HOME' environment variable

	mkdir -p ~/workspace/rnaseq/
	export RNA_HOME=~/workspace/rnaseq
	
Make sure whatever the working dir is, that it is set and is valid

	echo $RNA_HOME
        
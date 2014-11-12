#Logging into the Amazon cloud

* This will ONLY occur once we are in the classroom as it costs to have these servers running. Instructions will be provided in class.
* We have set up ~30 instances on the Amazon cloud - one for each student. In order to log in to your instance, you will need a security certificate. 
**If you plan on using '''Linux''' or '''Mac OS X''', please download this [[Media:CBWRNA.pem|CBWRNA.pem]]. 

* We have set up DNS shortcuts to the Amazon nodes so that we don't have to remember long hostnames like ec2-50-19-168-121.compute-1.amazonaws.com. Instead, we'll use the following hostnames: cshl#.dyndns.org where # is your assigned student number (01 - 30).

* On the cloud, we're going to use the default username: '''ubuntu'''

=== Logging in with ssh (Mac/Linux) ===

<font color="red">'''Logging in'''</font>

* Make sure the permissions on your certificate are secure. Use chmod on your downloaded certificate:

```
chmod 600 CSHLRNA.pem
```

* To log in to the node, use the -i command line argument to specify your certificate:

 ssh -i CSHLRNA.pem ubuntu@cshl##.dyndns.org

(where # is your assigned student number. Your student number is the number on the participant list. If your number less than 10, please add 0 in front of it.)

<font color="red">'''Copying files to your computer'''</font>

* To copy files from a node, use scp in a similar fashion (in this case to copy a file called nice_alignments.bam):

 scp -i CSHLRNA.pem ubuntu@cshl##.dyndns.org:workspace/nice_alignments.bam .

* Everything created in your workspace on the cloud is also available by a web server on your cloud instance.  Simply go to the following in your browser:

 <nowiki>http://cshl##.dyndns.org/</nowiki>

## File system layout

When you log in, you'll notice that you have two directories: '''bin''' and '''workspace'''.

* The <font color="red">'''bin'''</font> directory contains the tools that you'll need to complete your lab assignments. Actually you are going to learn to install your own copies of all these tools but these are in place as a backup.

* The <font color="red">'''workspace'''</font> directory is where we will keep our temporary files and analysis results. 

<br>
<hr>
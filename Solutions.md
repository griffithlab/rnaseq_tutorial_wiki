This page presents solutions to exercises/assignments from throughout the workshop

##Practical Exercise 1 - Software installation
To install bedtools:
* Google "bedtools" and find 
 * software page: https://github.com/arq5x/bedtools2
 * documentation page: http://bedtools.readthedocs.org/en/latest/
 * Note: if you find the old bedtools page (https://code.google.com/p/bedtools/) it will point you to above
* Go to Downloads, click on latest version (BEDTools.v2.17.0.tar.gz), right-click and save url
* Go to tools directory and download the archive, then unpack
```
cd $RNA_HOME/tools/
wget https://bedtools.googlecode.com/files/BEDTools.v2.17.0.tar.gz
tar -zxvf BEDTools.v2.17.0.tar.gz
cd bedtools-2.17.0/
make
```

##Practical Exercise 2 - Alignment
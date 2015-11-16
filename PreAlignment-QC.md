![RNA-seq Flowchart - Module 2](Images/RNA-seq_Flowchart2.png)

#1-vi. Pre-Alignment QC

You can use FastQC to get a sense of your data quality before alignment:
* http://www.bioinformatics.babraham.ac.uk/projects/fastqc/

Video Tutorial here: 
* http://www.youtube.com/watch?v=bz93ReOv87Y

Try to run FastQC on your fastq files:
```
cd $RNA_HOME/data
fastqc *.fastq.gz
```

Then, go to the following url in your browser:
* http://__YOUR_IP_ADDRESS__/workspace/rnaseq/data/
* Note, you must replace __YOUR_IP_ADDRESS__ with your own amazon instance IP (ex. 101.0.1.101))
* Click on any of the *_fastqc.html files to view the FastQC report

| [[Previous Section|RNAseq-Data]] | [[This Section|PreAlignment-QC]]    | [[Next Section|Adapter-Trim]] |
|:--------------------------------:|:-----------------------------------:|:--------------------------:|
| [[Data|RNAseq-Data]]             | [[Data QC|PreAlignment-QC]]         | [[Adapter Trim|Adapter-Trim]]    |

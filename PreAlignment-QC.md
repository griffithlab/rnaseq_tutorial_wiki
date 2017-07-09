![RNA-seq Flowchart - Module 1](Images/RNA-seq_Flowchart2.png)

# 1-vi. Pre-Alignment QC

You can use FastQC to get a sense of your data quality before alignment:
* http://www.bioinformatics.babraham.ac.uk/projects/fastqc/

Video Tutorial here: 
* http://www.youtube.com/watch?v=bz93ReOv87Y

Try to run FastQC on your fastq files:

```bash

cd $RNA_HOME/data
fastqc *.fastq.gz

```

Then, go to the following url in your browser:
* http://__YOUR_DNS_NAME__/rnaseq/data/
* Note, you must replace __YOUR_DNS_NAME__ with your own amazon instance DNS (e.g., ec2-54-187-159-113.us-west-2.compute.amazonaws.com))
* Click on any of the *_fastqc.html files to view the FastQC report

---
## PRACTICAL EXERCISE 4

Assignment: Run FASTQC on one of the additional fastq files you downloaded in the previous practical exercise. 

* Hint: Remember that you stored this data in a separate working directory called ‘practice’.
* Hint: Use the same approach as above to get a copy of the fastq file on your local machine by downloading it from your cloud instance.

Run FASTQC on the file 'hcc1395_normal_1.fastq.gz' and answer these questions by examining the output.

**Questions**
* How many total sequences are there?
* What is the range (x - y) of read lengths observed?
* What is the most common average sequence quality score?
* What is the most common kmer that is observed?

Solution: When you are ready you can check your approach against the [Solutions](https://github.com/griffithlab/rnaseq_tutorial/wiki/Solutions#practical-exercise-3---data-qc)

---


| [[Previous Section|RNAseq-Data]] | [[This Section|PreAlignment-QC]]    | [[Next Section|Adapter-Trim]] |
|:--------------------------------:|:-----------------------------------:|:--------------------------:|
| [[Data|RNAseq-Data]]             | [[Data QC|PreAlignment-QC]]         | [[Adapter Trim|Adapter-Trim]]    |

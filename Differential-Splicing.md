![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#4-iv. Differential Splicing

Use Cuffdiff to compare the UHR and HBR conditions.

Refer to the Cufflinks manual for a more detailed explanation:
http://cole-trapnell-lab.github.io/cufflinks/cuffdiff/index.html

Cuffdiff basic usage:
```bash

cuffdiff [options] <transcripts.gtf> <sample1_hits.sam> <sample2_hits.sam> [... sampleN_hits.sam]

```

* Supply replicate SAMs as comma separated lists for each condition: sample1_rep1.sam,sample1_rep2.sam,...sample1_repM.sam
* '-p 8' tells cuffdiff to use eight CPUs
* '-L' tells cuffdiff the labels to use for samples
	
Perform UHR vs. HBR comparison, for known/novel (reference guided mode) transcripts:

```bash

cd $RNA_HOME/
mkdir -p de/cufflinks/ref_guided/
cd $RNA_HOME/alignments/hisat2/

cuffdiff -p 8 -L UHR,HBR -o $RNA_HOME/de/cufflinks/ref_guided/ --no-update-check $RNA_HOME/expression/cufflinks/ref_guided/merged/merged.gtf UHR_Rep1.bam,UHR_Rep2.bam,UHR_Rep3.bam HBR_Rep1.bam,HBR_Rep2.bam,HBR_Rep3.bam

```

Perform UHR vs. HBR comparison, for known/novel (de novo mode) transcripts:

```bash

cd $RNA_HOME/
mkdir -p de/cufflinks/de_novo/
cd $RNA_HOME/alignments/hisat2/

cuffdiff -p 8 -L UHR,HBR -o $RNA_HOME/de/cufflinks/de_novo/ --no-update-check $RNA_HOME/expression/cufflinks/de_novo/merged/merged.gtf UHR_Rep1.bam,UHR_Rep2.bam,UHR_Rep3.bam HBR_Rep1.bam,HBR_Rep2.bam,HBR_Rep3.bam

```

| [[Previous Section|Transcript-Assembly-Merge]] | [[This Section|Differential-Splicing]]          | [[Next Section|Transcript-Assembly-Visualization]]        |
|:----------------------------------------------:|:-----------------------------------------------:|:-----------------------------------------------------------------:|
| [[Merging|Transcript-Assembly-Merge]]          | [[Differential Splicing|Differential-Splicing]] | [[Splicing Visualization|Transcript-Assembly-Visualization]]  |

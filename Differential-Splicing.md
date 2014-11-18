![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#5-iv. Differential Splicing

Use Cuffdiff to compare the UHR and HBR conditions.

Refer to the Cufflinks manual for a more detailed explanation:
http://cufflinks.cbcb.umd.edu/manual.html#cuffdiff
	
Cuffdiff basic usage:
```
cuffdiff [options] <transcripts.gtf> <sample1_hits.sam> <sample2_hits.sam> [... sampleN_hits.sam]
```

* Supply replicate SAMs as comma separated lists for each condition: sample1_rep1.sam,sample1_rep2.sam,...sample1_repM.sam
* '-p 8' tells cuffdiff to use eight CPUs
* '-L' tells cuffdiff the labels to use for samples
	
Perform UHR vs. HBR comparison, for known/novel (reference guided mode) transcripts:

	cd $RNA_HOME/
	mkdir -p de/tophat_cufflinks/ref_guided/
	cd $RNA_HOME/alignments/tophat/
	
	cuffdiff -p 8 -L UHR,HBR -o $RNA_HOME/de/tophat_cufflinks/ref_guided/ --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/expression/tophat_cufflinks/ref_guided/merged/merged.gtf UHR_Rep1_ERCC-Mix1/accepted_hits.bam,UHR_Rep2_ERCC-Mix1/accepted_hits.bam,UHR_Rep3_ERCC-Mix1/accepted_hits.bam HBR_Rep1_ERCC-Mix2/accepted_hits.bam,HBR_Rep2_ERCC-Mix2/accepted_hits.bam,HBR_Rep3_ERCC-Mix2/accepted_hits.bam
	
Perform UHR vs. HBR comparison, using just the capture libraries, for known/novel (de novo mode) transcripts:

	cd $RNA_HOME/
	mkdir -p de/tophat_cufflinks/de_novo/
	cd $RNA_HOME/alignments/tophat/
	
	cuffdiff -p 8 -L UHR,HBR -o $RNA_HOME/de/tophat_cufflinks/de_novo/ --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/expression/tophat_cufflinks/de_novo/merged/merged.gtf UHR_Rep1_ERCC-Mix1/accepted_hits.bam,UHR_Rep2_ERCC-Mix1/accepted_hits.bam,UHR_Rep3_ERCC-Mix1/accepted_hits.bam HBR_Rep1_ERCC-Mix2/accepted_hits.bam,HBR_Rep2_ERCC-Mix2/accepted_hits.bam,HBR_Rep3_ERCC-Mix2/accepted_hits.bam
        
| [[Previous Section|Transcript-Assembly-Merge]] | [[This Section|Differential-Splicing]]          | [[Next Section|Transcript-Assembly-Visualization]]        |
|:----------------------------------------------:|:-----------------------------------------------:|:-----------------------------------------------------------------:|
| [[Merging|Transcript-Assembly-Merge]]          | [[Differential Splicing|Differential-Splicing]] | [[Splicing Visualization|Transcript-Assembly-Visualization]]  |
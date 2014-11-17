![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#5-iv. Differential Splicing
Use Cuffdiff to compare the tumor and normal conditions.
Refer to the Cufflinks manual for a more detailed explanation:
http://cufflinks.cbcb.umd.edu/manual.html#cuffdiff
	
 Cuffdiff basic usage
 cuffdiff [options] <transcripts.gtf> <sample1_hits.sam> <sample2_hits.sam> [... sampleN_hits.sam]
 Supply replicate SAMs as comma separated lists for each condition: sample1_rep1.sam,sample1_rep2.sam,...sample1_repM.sam
 '-p 8' tells cuffdiff to use eight CPUs
 '-L' tells cuffdiff the labels to use for samples
	
 For reference guided mode:
	cd $RNA_HOME/
	mkdir -p de/tophat_cufflinks/ref_guided/
	cd $RNA_HOME/alignments/tophat/
	
Perform Tumor vs. Normal comparison, using just the capture libraries, for known/novel (reference guided mode) transcripts
	cuffdiff -p 8 -L Normal,Tumor -o $RNA_HOME/de/tophat_cufflinks/ref_guided/ --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/expression/tophat_cufflinks/ref_guided/merged/merged.gtf Normal_cDNA1_lib2/accepted_hits.bam,Normal_cDNA2_lib2/accepted_hits.bam Tumor_cDNA1_lib2/accepted_hits.bam,Tumor_cDNA2_lib2/accepted_hits.bam
	
 For de novo mode:
	cd $RNA_HOME/
	mkdir de/tophat_cufflinks/de_novo/
	cd $RNA_HOME/alignments/tophat/
	
Perform Tumor vs. Normal comparison, using just the capture libraries, for known/novel (de novo mode) transcripts
	cuffdiff -p 8 -L Normal,Tumor -o $RNA_HOME/de/tophat_cufflinks/de_novo/ --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/expression/tophat_cufflinks/de_novo/merged/merged.gtf Normal_cDNA1_lib2/accepted_hits.bam,Normal_cDNA2_lib2/accepted_hits.bam Tumor_cDNA1_lib2/accepted_hits.bam,Tumor_cDNA2_lib2/accepted_hits.bam
        
| [[Previous Section|Transcript-Assembly-Merge]] | [[This Section|Differential-Splicing]]          | [[Next Section|Transcript-Assembly-Visualization]]        |
|:----------------------------------------------:|:-----------------------------------------------:|:-----------------------------------------------------------------:|
| [[Merging|Transcript-Assembly-Merge]]          | [[Differential Splicing|Differential-Splicing]] | [[Splicing Visualization|Transcript-Assembly-Visualization]]  |
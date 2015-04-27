![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#4-ii. Cufflinks De Novo Mode
Note, to discover novel transcripts with Cufflinks 
Using the alignments we generated in the previous modules we will now run Cuffinks in de novo mode
To use de novo mode do *not* specify either of the '-G/--GTF' OR '-g/--GTF-guide' options.
	
	cd $RNA_HOME/expression/
	mkdir -p tophat_cufflinks/de_novo
	cd tophat_cufflinks/de_novo

	cufflinks -p 8 -o HBR_Rep1_ERCC-Mix2 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/HBR_Rep1_ERCC-Mix2/accepted_hits.bam
	cufflinks -p 8 -o HBR_Rep2_ERCC-Mix2 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/HBR_Rep2_ERCC-Mix2/accepted_hits.bam
	cufflinks -p 8 -o HBR_Rep3_ERCC-Mix2 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/HBR_Rep3_ERCC-Mix2/accepted_hits.bam

	cufflinks -p 8 -o UHR_Rep1_ERCC-Mix1 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/UHR_Rep1_ERCC-Mix1/accepted_hits.bam
	cufflinks -p 8 -o UHR_Rep2_ERCC-Mix1 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/UHR_Rep2_ERCC-Mix1/accepted_hits.bam
	cufflinks -p 8 -o UHR_Rep3_ERCC-Mix1 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/UHR_Rep3_ERCC-Mix1/accepted_hits.bam

| [[Previous Section|Reference-Guided-Transcript-Assembly]] | [[This Section|de-novo-Transcript-Assembly]] | [[Next Section|Transcript-Assembly-Merge]]   |
|:---------------------------------------------------------:|:--------------------------------------------:|:--------------------------------------------:|
| [[Ref Guided|Reference-Guided-Transcript-Assembly]]       | [[De novo|de-novo-Transcript-Assembly]]      | [[Merging|Transcript-Assembly-Merge]] |
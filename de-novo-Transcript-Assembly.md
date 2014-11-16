![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#CUFFLINKS DE NOVO MODE
Note, to discover novel transcripts with Cufflinks 
Using the alignments we generated in the previous modules we will now run Cuffinks in de novo mode
To use de novo mode do *not* specify either of the '-G/--GTF' OR '-g/--GTF-guide' options.
	
	cd $RNA_HOME/expression/
	mkdir -p tophat_cufflinks/de_novo
	cd tophat_cufflinks/de_novo
	cufflinks -p 8 -o Normal_cDNA1_lib2 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/Normal_cDNA1_lib2/accepted_hits.bam
	cufflinks -p 8 -o Normal_cDNA2_lib2 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/Normal_cDNA2_lib2/accepted_hits.bam
	cufflinks -p 8 -o Tumor_cDNA1_lib2 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/Tumor_cDNA1_lib2/accepted_hits.bam
	cufflinks -p 8 -o Tumor_cDNA2_lib2 --frag-len-mean 262 --frag-len-std-dev 80 --no-update-check $RNA_HOME/alignments/tophat/Tumor_cDNA2_lib2/accepted_hits.bam

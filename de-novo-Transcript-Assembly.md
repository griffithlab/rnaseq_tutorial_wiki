![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#4-ii. Cufflinks De Novo Mode

Note, to discover novel transcripts with Cufflinks 
Using the alignments we generated in the previous modules we will now run Cuffinks in de novo mode
To use de novo mode do *not* specify either of the '-G/--GTF' OR '-g/--GTF-guide' options.

```bash

cd $RNA_HOME/expression/
mkdir -p cufflinks/de_novo
cd cufflinks/de_novo

cufflinks -p 8 -o HBR_Rep1 --no-update-check $RNA_ALIGN_DIR/HBR_Rep1.bam
cufflinks -p 8 -o HBR_Rep2 --no-update-check $RNA_ALIGN_DIR/HBR_Rep2.bam
cufflinks -p 8 -o HBR_Rep3 --no-update-check $RNA_ALIGN_DIR/HBR_Rep3.bam

cufflinks -p 8 -o UHR_Rep1 --no-update-check $RNA_ALIGN_DIR/UHR_Rep1.bam
cufflinks -p 8 -o UHR_Rep2 --no-update-check $RNA_ALIGN_DIR/UHR_Rep2.bam
cufflinks -p 8 -o UHR_Rep3 --no-update-check $RNA_ALIGN_DIR/UHR_Rep3.bam

```

| [[Previous Section|Reference-Guided-Transcript-Assembly]] | [[This Section|de-novo-Transcript-Assembly]] | [[Next Section|Transcript-Assembly-Merge]]   |
|:---------------------------------------------------------:|:--------------------------------------------:|:--------------------------------------------:|
| [[Ref Guided|Reference-Guided-Transcript-Assembly]]       | [[De novo|de-novo-Transcript-Assembly]]      | [[Merging|Transcript-Assembly-Merge]] |
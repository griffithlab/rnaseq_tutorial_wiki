![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#4-ii. Stringtie De Novo Mode

Note, to discover novel transcripts with Stringtie 
Using the alignments we generated in the previous modules we will now run Stringtie in de novo mode
To use de novo mode do **NOT** specify either of the '-G' OR '-e' options.

Extra options specified below

*'-p 8' tells Stringtie to use eight CPUs
*'-l' name prefix for output transcripts (default: STRG)
*'-o' output path/file name for the assembled transcripts GTF (default: stdout)


```bash

cd $RNA_HOME/
mkdir -p expression/stringtie/de_novo/
cd expression/stringtie/de_novo/

stringtie -p 8 -l HBR_Rep1 -o HBR_Rep1/transcripts.gtf $RNA_ALIGN_DIR/HBR_Rep1.bam
stringtie -p 8 -l HBR_Rep2 -o HBR_Rep2/transcripts.gtf $RNA_ALIGN_DIR/HBR_Rep2.bam
stringtie -p 8 -l HBR_Rep3 -o HBR_Rep3/transcripts.gtf $RNA_ALIGN_DIR/HBR_Rep3.bam

stringtie -p 8 -l UHR_Rep1 -o UHR_Rep1/transcripts.gtf $RNA_ALIGN_DIR/UHR_Rep1.bam
stringtie -p 8 -l UHR_Rep2 -o UHR_Rep2/transcripts.gtf $RNA_ALIGN_DIR/UHR_Rep2.bam
stringtie -p 8 -l UHR_Rep3 -o UHR_Rep3/transcripts.gtf $RNA_ALIGN_DIR/UHR_Rep3.bam

```

| [[Previous Section|Reference-Guided-Transcript-Assembly]] | [[This Section|de-novo-Transcript-Assembly]] | [[Next Section|Transcript-Assembly-Merge]]   |
|:---------------------------------------------------------:|:--------------------------------------------:|:--------------------------------------------:|
| [[Ref Guided|Reference-Guided-Transcript-Assembly]]       | [[De novo|de-novo-Transcript-Assembly]]      | [[Merging|Transcript-Assembly-Merge]] |
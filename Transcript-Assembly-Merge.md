![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

#5-iii. CUFFMERGE
Use Cuffmerge to merge predicted transcripts from all libraries into a unified transcriptome. Refer to the Cufflinks manual for a more detailed explanation:

http://cufflinks.cbcb.umd.edu/manual.html#cuffmerge
	
Cuffmerge basic usage
```
cuffmerge [options]* <assembly_GTF_list.txt>
```

Options specified below:
* "assembly_GTF_list.txt" is a text file "manifest" with a list (one per line) of GTF files that you would like to merge together into a single GTF file. 
* '-p 8' tells cuffmerge to use eight CPUs
* '-o' tells cuffmerge to write output to a particular directory
* '-g' tells cuffmerge where to find reference gene annotations. It will use these annotations to gracefully merge novel isoforms (for de novo runs) and known isoforms and maximize overall assembly quality.
* '-s' tells cuffmerge where to find the reference genome files
	
Merge all 4 cufflinks results so that they will have the same set of transcripts for comparison purposes:
	
 For reference guided mode:

	cd $RNA_HOME/expression/tophat_cufflinks/ref_guided/
	ls -1 *Rep*_ERCC*/transcripts.gtf > assembly_GTF_list.txt
	cat assembly_GTF_list.txt
	cuffmerge -p 8 -o merged -g $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf -s $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/ assembly_GTF_list.txt
	
 For de novo mode:

	cd $RNA_HOME/expression/tophat_cufflinks/de_novo/
	ls -1 *Rep*_ERCC*/transcripts.gtf > assembly_GTF_list.txt
	cat assembly_GTF_list.txt
	cuffmerge -p 8 -o merged -g $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf -s $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/ assembly_GTF_list.txt
	
| [[Previous Section|de-novo-Transcript-Assembly]] | [[This Section|Transcript-Assembly-Merge]] | [[Next Section|Differential-Splicing]]    |
|:------------------------------------------------:|:------------------------------------------:|:----------------------------------------------------:|
| [[De novo|de-novo-Transcript-Assembly]]          | [[Merging|Transcript-Assembly-Merge]]      | [[Differential Splicing|Differential-Splicing]] |
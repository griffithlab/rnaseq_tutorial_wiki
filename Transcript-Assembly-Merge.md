![RNA-seq Flowchart - Module 5](Images/RNA-seq_Flowchart5.png)

# 4-iii. Stringtie Merge
Use Stringtie to merge predicted transcripts from all libraries into a unified transcriptome. Refer to the Stringtie manual for a more detailed explanation:
https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual	

Options specified below:
* "assembly_GTF_list.txt" is a text file "manifest" with a list (one per line) of GTF files that you would like to merge together into a single GTF file. 
* '-p 8' tells stringtie to use eight CPUs
* '-o' tells stringtie to write output to a particular file or directory
* '-G' tells stringtie where to find reference gene annotations. It will use these annotations to gracefully merge novel isoforms (for de novo runs) and known isoforms and maximize overall assembly quality.
	
Merge all 6 Stringtie results so that they will have the same set of transcripts for comparison purposes:
	
For reference guided mode:

```bash

cd $RNA_HOME/expression/stringtie/ref_guided/
ls -1 *Rep*/transcripts.gtf > assembly_GTF_list.txt
cat assembly_GTF_list.txt
stringtie --merge -p 8 -o stringtie_merged.gtf -G $RNA_REF_GTF assembly_GTF_list.txt

```

What do the resulting transcripts look like?

```bash

awk '{if($3=="transcript") print}' stringtie_merged.gtf | cut -f 1,4,9 | less

```

Press 'q' to exit the less viewer

Compare reference guided transcripts to known annotation:

```bash

gffcompare -r $RNA_REF_GTF -o merged stringtie_merged.gtf

cat merged.stats

```

What does the merged annotation look like after comparing it to known annotation?  How are the GTF lines different?

```bash

awk '{if($3=="transcript") print}' merged.annotated.gtf | cut -f 1,4,9 | less

```

Press 'q' to exit the less viewer


For de novo mode (again, we do not provide an Ensembl GTF):

```bash

cd $RNA_HOME/expression/stringtie/de_novo/
ls -1 *Rep*/transcripts.gtf > assembly_GTF_list.txt
cat assembly_GTF_list.txt
stringtie --merge -p 8 -o stringtie_merged.gtf assembly_GTF_list.txt

```

Compare the de novo merged transcritps to the known annotations:

```bash

gffcompare -r $RNA_REF_GTF -o merged stringtie_merged.gtf
cat merged.stats

```

| [[Previous Section|de-novo-Transcript-Assembly]] | [[This Section|Transcript-Assembly-Merge]] | [[Next Section|Differential-Splicing]]    |
|:------------------------------------------------:|:------------------------------------------:|:----------------------------------------------------:|
| [[De novo|de-novo-Transcript-Assembly]]          | [[Merging|Transcript-Assembly-Merge]]      | [[Differential Splicing|Differential-Splicing]] |

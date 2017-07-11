![RNA-seq Flowchart - Module 4](Images/RNA-seq_Flowchart4.png)

# 3-ii. Differential Expression
Use Ballgown to compare the tumor and normal conditions. Refer to the Ballgown manual for a more detailed explanation:
* https://www.bioconductor.org/packages/release/bioc/html/ballgown.html
`

Change to ref-only directory:

```bash

mkdir -p $RNA_HOME/de/ballgown/ref_only/
cd $RNA_HOME/de/ballgown/ref_only/

```

Perform UHR vs. HBR comparison, using all replicates, for known (reference only mode) transcripts:

First create a file that lists our 6 expression files, then view that file, then start an R session where we will examine these results:

```bash

printf "\"ids\",\"type\",\"path\"\n\"UHR_Rep1\",\"UHR\",\"$RNA_HOME/expression/stringtie/ref_only/UHR_Rep1\"\n\"UHR_Rep2\",\"UHR\",\"$RNA_HOME/expression/stringtie/ref_only/UHR_Rep2\"\n\"UHR_Rep3\",\"UHR\",\"$RNA_HOME/expression/stringtie/ref_only/UHR_Rep3\"\n\"HBR_Rep1\",\"HBR\",\"$RNA_HOME/expression/stringtie/ref_only/HBR_Rep1\"\n\"HBR_Rep2\",\"HBR\",\"$RNA_HOME/expression/stringtie/ref_only/HBR_Rep2\"\n\"HBR_Rep3\",\"HBR\",\"$RNA_HOME/expression/stringtie/ref_only/HBR_Rep3\"\n" > UHR_vs_HBR.csv
cat UHR_vs_HBR.csv

R

```
A separate R tutorial file has been provided in the github repo for part 1 of the tutorial: [Tutorial_Module4_Part1_ballgown.R](https://github.com/griffithlab/rnaseq_tutorial/blob/master/scripts/Tutorial_Module4_Part1_ballgown.R). Run the R commands detailed in the R script.

Once you have completed the Ballgown analysis in R, exit the R session and continue with the steps below. 

What does the raw output from Ballgown look like?

```bash

head UHR_vs_HBR_gene_results.tsv


```

How many genes are there on this chromosome?

```bash

grep -v feature UHR_vs_HBR_gene_results.tsv | wc -l

```

How many passed filter in UHR or HBR?

```bash

grep -v feature UHR_vs_HBR_gene_results_filtered.tsv | wc -l

```

How many differentially expressed genes were found on this chromosome (p-value < 0.05)?

```bash

grep -v feature UHR_vs_HBR_gene_results_sig.tsv | wc -l

```

Display the top 20 DE genes. Look at some of those genes in IGV - do they make sense?

```bash

grep -v feature UHR_vs_HBR_gene_results_sig.tsv | sort -rnk 4 | head -n 20 #Higher abundance in UHR
grep -v feature_UHR_vs_HBR_gene_results_sig.tsv | sort -nk 4 | head -n 20 #Higher abundance in HBR
```

Save all genes with P<0.05 to a new file.

```bash

grep -v feature UHR_vs_HBR_gene_results_sig.tsv | cut -f 7 | sed 's/\"//g' > DE_genes.txt
head DE_genes.txt

```

| [[Previous Section|Expression]] | [[This Section|Differential-Expression]]            | [[Next Section|DE-Visualization]] |
|:-------------------------------:|:---------------------------------------------------:|:-----------------------------------------:|
| [[Expression|Expression]]       | [[Differential Expression|Differential-Expression]] | [[DE Visualization|DE-Visualization]] |

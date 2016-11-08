![RNA-seq Flowchart - Module 4](Images/RNA-seq_Flowchart4.png)

#3-ii. Differential Expression
Use Ballgown to compare the tumor and normal conditions. Refer to the Ballgown manual for a more detailed explanation:
* https://www.bioconductor.org/packages/release/bioc/html/ballgown.html
`

Change to ref-only directory:

```bash

cd $RNA_HOME/expression/stringtie/ref_only/

```

Perform UHR vs. HBR comparison, using all replicates, for known (reference only mode) transcripts:

```bash

printf "\"ids\",\"type\"\n\"UHR_Rep1\",\"UHR\"\n\"UHR_Rep2\",\"UHR\"\n\"UHR_Rep3\",\"UHR\"\n\"HBR_Rep1\",\"HBR\"\n\"HBR_Rep2\",\"HBR\"\n\"HBR_Rep3\",\"HBR\"\n" > UHR_vs_HBR.csv

R

```

```bash

library(ballgown)
library(RSkittleBrewer)
library(genefilter)
library(dplyr)
library(devtools)

# Load phenotype data
pheno_data = read.csv("UHR_vs_HBR.csv")

# Load ballgown data structure
bg = ballgown(samples=c("UHR_Rep1","UHR_Rep2","UHR_Rep3","HBR_Rep1","HBR_Rep2","HBR_Rep3"),pData=pheno_data)

# Perform DE with no filtering
results_transcripts = stattest(bg, feature="transcript", covariate="type", getFC=TRUE, meas="FPKM")
results_genes = stattest(bg, feature="gene", covariate="type", getFC=TRUE, meas="FPKM")

write.table(results_transcripts,"UHR_vs_HBR_transcript_results.tsv",sep="\t")
write.table(results_genes,"UHR_vs_HBR_gene_results.tsv",sep="\t")

# Filter low-abundance genes
bg_filt = subset (bg,"rowVars(texpr(bg)) > 1", genomesubset=TRUE)
results_transcripts = stattest(bg_filt, feature="transcript", covariate="type", getFC=TRUE, meas="FPKM")
results_genes = stattest(bg_filt, feature="gene", covariate="type", getFC=TRUE, meas="FPKM")

write.table(results_transcripts,"UHR_vs_HBR_transcript_results_filtered.tsv",sep="\t")
write.table(results_genes,"UHR_vs_HBR_gene_results_filtered.tsv",sep="\t")


# Identify genes with p value < 0.05
sig_transcripts = subset(results_transcripts,results_transcripts$pval<0.05)
sig_genes = subset(results_genes,results_genes$pval<0.05)
write.table(sig_transcripts,"UHR_vs_HBR_transcript_results_sig.tsv",sep="\t")
write.table(sig_genes,"UHR_vs_HBR_gene_results_sig.tsv",sep="\t")

quit()

```


What does the raw output from Ballgown look like?

```bash

head UHR_vs_HBR_gene_results.tsv


```

Press 'q' to exit the 'less' display

How many genes are there on this chromosome?

```bash

grep -v feature UHR_vs_HBR_gene_results.tsv | wc -l

```

How many were detected above 0 in UHR or HBR?

```bash

grep -v feature UHR_vs_HBR_gene_results_filtered.tsv | wc -l

```

How many differentially expressed genes were found on this chromosome (p-value < 0.05)?

```bash

grep -v feature UHR_vs_HBR_gene_results_sig.tsv | wc -l

```

Display the top 20 DE genes. Look at some of those genes in IGV - do they make sense?

```bash

grep -v feature UHR_vs_HBR_gene_results_sig.tsv | sort -rnk 4 | head -n 20

```

Save all genes with P<0.05 to a new file.
TODO: Map ENSG ID back to gene name/symbol

```bash

 grep -v feature UHR_vs_HBR_gene_results_sig.tsv | cut -f 3 | sed 's/\"//g' > DE_genes.txt

```

| [[Previous Section|Expression]] | [[This Section|Differential-Expression]]            | [[Next Section|DE-Visualization]] |
|:-------------------------------:|:---------------------------------------------------:|:-----------------------------------------:|
| [[Expression|Expression]]       | [[Differential Expression|Differential-Expression]] | [[DE Visualization|DE-Visualization]] |

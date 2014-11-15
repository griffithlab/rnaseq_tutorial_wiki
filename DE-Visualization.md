#CUMMERBUND R ANALYSIS

A separate R tutorial file has been provided in the github repo for part 2 of the tutorial: [Tutorial_Module3_Part2_CummeRbund.R](https://github.com/griffithlab/rnaseq_tutorial/blob/master/Rscripts/Tutorial_Module3_Part2_cummeRbund.R). 

The output of cuffdiff can be directly loaded into the R/BioConductor package to produce a sophisticated set of analysis results and visualizations. 

Navigate to the correct directory and then launch R:

	cd $RNA_HOME/de/tophat_cufflinks/ref_only/
	R
	
Then, run the R commands detailed in the R script above. The output pdf files can be viewed in your browser at the following urls. Note, you must replace cshl## with your own amazon instance number (e.g., "cshl01")).

* http://cshl##.dyndns.org/rnaseq/de/tophat_cufflinks/ref_only/Tutorial_Part2_cummeRbund_output.pdf
* http://cshl##.dyndns.org/rnaseq/de/tophat_cufflinks/ref_only/Tutorial_Part2_cummeRbund_output_extras.pdf
	
##SUPPLEMENTARY R ANALYSIS 

Occasionally you may wish to reformat and work with cuffdiff output in R manually. Therefore we provide an optional/advanced tutorial on how to format your results for R and perform "old school" (non-cummeRbund analysis) on your data.

Expression and differential expression files will be read into R. The R analysis will make use of the transcript-level expression and differential expression files from cuffdiff

	cd $RNA_HOME/
	mkdir -p final_results/tophat_cufflinks/ref_only
	cd $RNA_HOME/final_results/tophat_cufflinks/ref_only
	cp $RNA_HOME/de/tophat_cufflinks/ref_only/isoform* .
	cp $RNA_HOME/de/tophat_cufflinks/ref_only/read_groups.info .
	
See the separate R file in the github repo for part 3 of the tutorial: [Tutorial_Module3_Part3_Supplementary_R.R](https://github.com/griffithlab/rnaseq_tutorial/blob/master/Rscripts/Tutorial_Module3_Part3_Supplementary_R.R)

In this tutorial you will:

* Learn basic R usage and commands (common plots, and data manipulation tasks)
* Examine the expression estimates
* Create an MDS plot to visualize the differences between/among replicates, library prep methods and UHR versus HBR
* Examine the differential expression estimates
* Visualize the expression estimates and highlight those genes that appear to be differentially expressed
* Generate a list of the top differentially expressed genes
* Ask how reproducible technical replicates are.

	cd $RNA_HOME/final_results/tophat_cufflinks/ref_only/
	R
	
The output file can be viewed in your browser at the following url. Note, you must replace cshl## with your own amazon instance number (e.g., "cshl01")).
* http://cshl##.dyndns.org/rnaseq/final_results/tophat_cufflinks/ref_only/Tutorial_Part3_Supplementary_R_output.pdf
		
###See separate R tutorial file for part 4 of the tutorial: 'Tutorial_Module3_Part4_edgeR.R'
In this tutorial you will:
Make use of the raw counts you generate above using htseq-count
edgeR is a bioconductor package designed specifically for differential expression of count-based RNA-seq data
This is an alternative to using cufflinks/cuffmerge/cuffdiff to find differentially expressed genes
Create directory for results
	cd $RNA_HOME/
	mkdir -p de/tophat_counts
	cd de/tophat_counts
	cp $RNA_HOME/de/tophat_cufflinks/ref_only/gene* .
	
Create a mapping file to go from ENSG IDs (which htseq-count output) to Symbols
	cd $RNA_HOME/refs/hg19/genes
	perl -ne 'if ($_=~/gene_id\s\"(ENSG\d+)\"\;\sgene_name\s\"(\S+)\"\;/){print "$1\t$2\n";}' genes_chr22.gtf | sort | uniq > ENSG_ID2Name.txt
	
	cd $RNA_HOME/de/tophat_counts
	R
	
###Once you have run the edgeR tutorial, compare the sigDE genes to those saved earlier from cuffdiff
	cat $RNA_HOME/de/tophat_cufflinks/ref_only/DE_genes.txt
	cat $RNA_HOME/de/tophat_counts/DE_genes.txt
	
Pull out the gene symbols and visualize overlap with a venn diagram
This can be done with simple web tools like:
http://www.cmbi.ru.nl/cdd/biovenn/
http://bioinfogp.cnb.csic.es/tools/venny/
	
	
	
	
######CUMMERBUND R ANALYSIS
######11.) See separate R tutorial file for part 2 of the tutorial: 'Tutorial_Module3_Part2_CummeRbund.R'
###### The output of cuffdiff can be directly loaded into the R/BioConductor package to produce a sophisticated set of analysis results and visualizations.
###### Occasionally you may wish to reformat and work with cuffdiff output in R manually.
###### The rest of this file outlines an optional/advanced tutorial on how to format your results for R and perform "old school" (non-cummeRbund analysis) on your data
	cd $RNA_HOME/de/tophat_cufflinks/ref_only/
	R
	
######The output file can be viewed in your browser at the following url:
######Note, you must replace cbw## with your own amazon instance number (e.g., "cbw01"))
######http://cbw##.ssh01.com/rnaseq/de/tophat_cufflinks/ref_only/Tutorial_Part2_cummeRbund_output.pdf
######http://cbw##.ssh01.com/rnaseq/de/tophat_cufflinks/ref_only/Tutorial_Part2_cummeRbund_output_extras.pdf
	
######SUPPLEMENTARY R ANALYSIS 
######12a.) Expression and differential expression files will be read into R.
######The R analysis will make use of the transcript-level expression and differential expression files from cuffdiff
	cd $RNA_HOME/
	mkdir -p final_results/tophat_cufflinks/ref_only
	cd $RNA_HOME/final_results/tophat_cufflinks/ref_only
	cp $RNA_HOME/de/tophat_cufflinks/ref_only/isoform* .
	cp $RNA_HOME/de/tophat_cufflinks/ref_only/read_groups.info .
	
	
######12b.) See separate R tutorial file for part 3 of the tutorial: 'Tutorial_Module3_Part3_Supplementary_R.R'
######In this tutorial you will:
######Learn basic R usage and commands (common plots, and data manipulation tasks)
######Examine the expression estimates
######Create an MDS plot to visualize the differences between/among replicates, library prep methods and tumor versus normal
######Examine the differential expression estimates
######Visualize the expression estimates and highlight those genes that appear to be differentially expressed
######Generate a list of the top differentially expressed genes
######How reproducible are the technical replicates?  How well do the different library construction methods correlate? 
	cd $RNA_HOME/final_results/tophat_cufflinks/ref_only/
	R
	
######The output file can be viewed in your browser at the following url:
######Note, you must replace cbw## with your own amazon instance number (e.g., "cbw01"))
######http://cbw##.ssh01.com/rnaseq/final_results/tophat_cufflinks/ref_only/Tutorial_Part3_Supplementary_R_output.pdf
	
	
######12c.) See separate R tutorial file for part 4 of the tutorial: 'Tutorial_Module3_Part4_edgeR.R'
######In this tutorial you will:
######Make use of the raw counts you generate above using htseq-count
######edgeR is a bioconductor package designed specifically for differential expression of count-based RNA-seq data
######This is an alternative to using cufflinks/cuffmerge/cuffdiff to find differentially expressed genes
######Create directory for results
	cd $RNA_HOME/
	mkdir -p de/tophat_counts
	cd de/tophat_counts
	cp $RNA_HOME/de/tophat_cufflinks/ref_only/gene* .
	
######Create a mapping file to go from ENSG IDs (which htseq-count output) to Symbols
	cd $RNA_HOME/refs/hg19/genes
	perl -ne 'if ($_=~/gene_id\s\"(ENSG\d+)\"\;\sgene_name\s\"(\S+)\"\;/){print "$1\t$2\n";}' genes_chr22.gtf | sort | uniq > ENSG_ID2Name.txt
	
	cd $RNA_HOME/de/tophat_counts
	R
	
######12d.) Once you have run the edgeR tutorial, compare the sigDE genes to those saved earlier from cuffdiff
	cat $RNA_HOME/de/tophat_cufflinks/ref_only/DE_genes.txt
	cat $RNA_HOME/de/tophat_counts/DE_genes.txt
	
######Pull out the gene symbols and visualize overlap with a venn diagram
######This can be done with simple web tools like:
######http://www.cmbi.ru.nl/cdd/biovenn/
######http://bioinfogp.cnb.csic.es/tools/venny/
	
	
	
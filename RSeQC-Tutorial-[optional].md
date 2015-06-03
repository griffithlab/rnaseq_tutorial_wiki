# RSeQC

**Background**: RSeQC is a tool that can be used to generate QC reports for RNA-seq. For more information, please check: [Tool Homepage](rseqc.sourceforge.net/)

Objectives: In this section, we will try to generate a QC report for a data set downloaded from RSeQC website. 

Files needed:

- Aligned bam file.
- Index file for the aligned bam.
- A RefSeq bed file.

#Copy RSeQC Data

set your working directory and copy the necessary files

      mkdir -p ~/workspace/rnaseq/
      cp -r ~/CourseData/RNA_data/RSeQC/RSeQC.zip ~/workspace/rnaseq/
      cd ~/workspace/rnaseq/

#Unzip the RSeQC file
      unzip RSeQC.zip
      cd RSeQC/
Note: You should now see the bam, index, and RefSeq bed files listed

#Run RSeQC commands:
     bam_stat.py -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam
     clipping_profile.py -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     geneBody_coverage.py -r hg19_RefSeq.bed -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     infer_experiment.py -r hg19_RefSeq.bed -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam
     inner_distance.py -r hg19_RefSeq.bed -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     junction_annotation.py -r hg19_RefSeq.bed -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     junction_saturation.py -r hg19_RefSeq.bed -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     read_distribution.py -r hg19_RefSeq.bed -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam
     read_duplication.py -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     read_GC.py -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     module load RSeQC; read_NVC.py -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial
     read_quality.py -i Pairend_nonStrandSpecific_36mer_Human_hg19.bam -o tutorial

#Go through the generated PDFs
     ls *.pdf









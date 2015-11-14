## Table of contents
1. Introduction
  1. Description of the lab
  2. Requirements
  3. Compatibility
  4. Data Set for IGV
2. Visualization Part 1: Getting familiar with IGV
  1. Get familiar with the interface
    1. Load a Genome and Data Tracks
    2. Navigation
  2. Region Lists
  3. Loading Read Alignments
  4. Visualizing read alignments
3. Visualization Part 2: Inspecting SNPs, SNVs, and SVs
  1. Neighbouring somatic SNV and germline SNP
  2. Homopolymer repeat with indel
  3. Coverage by GC
  4. Heterozygous SNPs on different alleles
  5. Low mapping quality
  6. Homozygous deletion
  7. Mis-alignment
  8. Translocation
4. Visualization Part 3: Automating Tasks in IGV


## Introduction 

### Description of the lab

Welcome to the lab for **Genome Visualization**! This lab will introduce you to the [Integrative Genomics Viewer](http://www.broadinstitute.org/igv/home), one of the most popular visualization tools for High Throughput Sequencing (HTS) data.

After this lab, you will be able to:
* Visualize a variety of genomic data
* Quickly navigate around the genome
* Visualize read alignments
* Validate SNP/SNV calls and structural re-arrangements by eye

Things to know before you start:
* The lab may take between **1-2 hours**, depending on your familiarity with genome browsing. Do not worry if you do not complete the lab. It will remain available to review later.
* There are a few thought-provoking **Questions** or **Notes** pertaining to sections of the lab. These are **optional**, and may take more time, but are meant to help you better understand the visualizations you are seeing. These questions will be denoted by boxes, as follows:
 **Question(s):**

```
Thought-provoking question goes here
```

### Requirements

* [Integrative Genomics Viewer](http://www.broadinstitute.org/igv/home)
* Ability to run Java
* Note that while most tutorials in this course are performed on the cloud, IGV will always be run on your **local** machine

### Compatibility

This tutorial was intended for **IGV v2.3**, which is available on the [IGV Download](http://www.broadinstitute.org/software/igv/download) page. It is *strongly* recommended that you use this version.

### Data Set for IGV

* Sequence read alignments generated from a cell line HCC1143 that have been filtered to this region:
* Chromosome 21: 19,000,000-20,000,000
* [HCC1143.normal.21.19M-20M.bam](https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/hcc1143/HCC1143.normal.21.19M-20M.bam)
* [HCC1143.normal.21.19M-20M.bam.bai](https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/hcc1143/HCC1143.normal.21.19M-20M.bam.bai)

# Visualization Part 1: Getting familiar with IGV

We will be visualizing read alignments using [IGV](http://www.broadinstitute.org/igv/home), a popular visualization tool for HTS data.

First, lets familiarize ourselves with it.

## Get familiar with the interface

### Load a Genome and some Data Tracks

By default, IGV loads Human hg19. If you work with another version of the human genome, or another organism altogether, you can change the genome by clicking the drop down menu in the upper-left. For this lab, we will be using Human hg19.  

We will also load additional tracks from **Server**:

* Ensembl genes (or your favourite source of gene annotations)
* GC Percentage
* dbSNP 1.3.1 or 1.3.7

**Load hg19 genome and additional data tracks**
![Load hg19 genome and additional data tracks](Images/IGV/load.data.tracks.png)

### Navigation

You should see listing of chromosomes in this reference genome. Choose ***1***, for chromosome 1.

**Chromosome chooser**
![Chromosome chooser](Images/IGV/chromosomes.png)


Navigate to **chr1:10,000-11,000** by entering this into the location field (in the top-left corner of the interface) and clicking **Go**. This shows a window of chromosome 1 that is 1,000 base pairs wide and beginning at position 10,000.

**Navigition using Location text field. Sequence displayed as sequence of colours**
![Navigition using Location text field. Sequence displayed as sequence of colours.](Images/IGV/1.png)


IGV displays the sequence of letters in a genome as a sequence of colours (e.g. A = green). This makes repetitive sequences, like the ones found at the start of this region, easy to identify.

You can navigate to a gene of interest by typing it in the same box the genomic coordinates are in and pressing Enter/Return. Try it for your favourite gene, or *BRCA1* if you can not decide. 

**Gene model**<br>
![Gene model](Images/IGV/gene_model.png)

Genes are represented as lines and boxes. Lines represent intronic regions, and boxes represent exonic regions. The arrows indicate the strand on which the gene lies.

When loaded, tracks are stacked on top of each other. You can identify which track is which by consulting the label to the left of each track.

## Region Lists

Sometimes, it is really useful to save where you are, or to load regions of interest. For this purpose, there is a **Region Navigator** in IGV. To access it, click `Regions` > `Region Navigator`. While you browse around the genome, you can save some bookmarks by pressing the `Add` button at any time.

**Bookmarks in IGV**<br>
![Bookmarks in IGV](Images/IGV/bookmarks.png)

## Loading Read Alignments
We will be using the breast cancer cell line HCC1143 to visualize alignments. For speed, only a small portion of chr21 will be loaded (19M:20M).

**HCC1143 Alignments to hg19:** 
* [HCC1143.normal.21.19M-20M.bam](https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/hcc1143/HCC1143.normal.21.19M-20M.bam)
* [HCC1143.normal.21.19M-20M.bam.bai](https://xfer.genome.wustl.edu/gxfer1/project/gms/testdata/bams/hcc1143/HCC1143.normal.21.19M-20M.bam.bai)

Copy the files to your local drive, and in IGV choose `File` > `Load from File...`, select the bam file, and click `OK`. Note that the bam and index files must be in the same directory for IGV to load these properly.

**Load BAM track from File**
![Load BAM track from File](Images/IGV/load_bam.png)

## Visualizing read alignments

Navigate to a narrow window on chromosome 21: `chr21:19,480,041-19,480,386`.

To start our exploration, right click on the track-name, and select the following options:
* Sort alignments by `start location`
* Group alignments by `pair orientation`

Experiment with the various settings by right clicking the read alignment track and toggling the options. Think about which would be best for specific tasks (e.g. quality control, SNP calling, CNV finding).

**Read information**<br>
![Read information](Images/IGV/sort_and_group.png)

You will see reads represented by grey or white bars stacked on top of each other, where they were aligned to the reference genome. The reads are pointed to indicate their orientation (i.e. the strand on which they are mapped). Mouse over any read and notice that a lot of information is available. To toggle read display from `hover` to `click`, select the yellow box and change the setting.

**More read information**
![More read information](Images/IGV/show_details_on_click.png)

Once you select a read, you will learn what many of these metrics mean, and how to use them to assess the quality of your datasets.  At each base that the read sequence **mismatches** the reference, the colour of the base represents the letter that exists in the read (using the same colour legend used for displaying the reference).

**More read information**
![More read information](Images/IGV/click_read.png)

# Visualization Part 2: Inspecting SNPs, SNVs, and SVs =

In this section we will be looking in detail at 8 positions in the genome, and determining whether they represent real events or artifacts.

## Neighbouring somatic SNV and germline SNP

* Navigate to position `chr21:19,479,237-19,479,814`
* Center on the SNV, sort by base (window `chr21:19,478,749-19,479,891` is centered on the SNV)
* Sort alignments by `base`
* Color alignments by `read strand`

**Example1. Good quality SNVs/SNPs**
![Example1. Good quality SNVs/SNPs](Images/IGV/example1_color.png)

**Notes:**
* High base qualities in all reads except one (where the alt allele is the last base of the read) 
* Good mapping quality of reads, no strand bias, allele frequency consistent with heterozygous mutation

**Question(s):**
```
* What does *Shade base by quality* do? How might this be helpful?
* How does Color by *read strand* help?
```

## Homopolymer repeat with indel

Navigate to position `chr21:19,518,412-19,518,497`
* Group alignments by `read strand`
* Center on the second `T`, and Sort alignments by `base` on the forward strand reads

**Example 2a**
![Example 2a](Images/IGV/example2a.png)

* center on the one base deletion, and Sort alignments by `base` on the reverse strand reads

**Example 2b**
![Example 2b](Images/IGV/example2b.png)

**Notes:**
* The alt allele is either a deletion or insertion of one or two `T`s
* The remaining bases are mismatched, because the alignment is now out of sync
* The dpSNP entry at this location (rs74604068) is an A->T, and in all likelyhood an artifact 
* i.e. the common variants included some cases that are actually common misalignments caused by repeats

**Coverage by GC**

Navigate to position `chr21:19,611,925-19,631,555`  
Note that the range contains areas where coverage drops to zero in a few places.

* Use Collapsed view
* Load GC track 
* See concordance of coverage with GC content

**Example 3**
![Example 3](Images/IGV/example3.png)

**Question:**
```
* Why are there blue and red reads throughout the alignments?
```

## Heterozygous SNPs on different alleles

Navigate to region `chr21:19,666,833-19,667,007`
* Sort by base

**Example 4**
![Example 4](Images/IGV/example4.png)

**Note:**
* Linkage between alleles is not the case for these two SNPs because reads covering the position of both SNPs only contain one or the other

## Low mapping quality 

Navigate to region `chr21:19,800,320-19,818,162`
* Load repeat track

**Load repeats**<br>
![Load repeats](Images/IGV/load_repeats.png)

**Example 5**
![Example 5](Images/IGV/example5.png)

**Notes:**
* Mapping quality plunges in all reads (white instead of grey).  Once we load repeat elements, we see that
* There are two LINE elements that cause this.

## Homozygous deletion

Navigate to region `chr21:19,324,469-19,331,468`

* Sort reads by insert size
* Turn on `View as Pairs` and `Expanded` view
* Click on a red read pair to pull up information on alignments

**Example 6**
![Example 6](Images/IGV/example6.png)

**Notes:**
* Typical insert size of read pair in the vicinity: 350bp
* New insert size of red read pairs: 2,875bp
* This corresponds to a homozygous deletion of 2.5kb

## Mis-alignment

Navigate to region `chr21:19,102,154-19,103,108`

**Example 7**
![Example 7](Images/IGV/example7.png)

**Notes:**
* This is a position where AluY element causes mis-alignment.  
* Misaligned reads have mismatches to the reference and 
* Well-aligned reads have partners on other chromosomes where additional ALuY elements are encoded.

## Translocation

Navigate to region `chr21:19,089,694-19,095,362`

* Expanded view
* Group by Pair Orientation
* Color by Pair Orientation

** Example 8 **
![Example 8](Images/IGV/example8.png)

**Notes:**
* Many reads with mismatches to reference
* Read pairs in RL pattern (instead of LR pattern)
* Region is flanked by reads with poor mapping quality (white instead of grey)
* Presence of reads with pairs on other chromosomes (coloured reads at the bottom when scrolling down)

# Visualization Part 3: Automating Tasks in IGV

We can use the Tools menu to invoke running a batch script. Batch scripts are described on the IGV website:
* Batch file requirements: https://www.broadinstitute.org/igv/batch
* Commands recognized in a batch script: https://www.broadinstitute.org/software/igv/PortCommands
* We also need to provide sample attribute file as described here: http://www.broadinstitute.org/software/igv/?q=SampleInformation

Download the batch script and the attribute file for our dataset:
* Batch script: [run_batch_IGV_snapshots.txt](https://github.com/griffithlab/rnaseq_tutorial/blob/master/scripts/Igv_HCC1143_attributes.txt)
* Attribute file: [igv_HCC1143_attributes.txt](https://github.com/griffithlab/rnaseq_tutorial/blob/master/scripts/Run_batch_IGV_snapshots.txt)

Now run the file from the `Tools` menu:

**Automation**
![Automation](Images/IGV/run_batch_script.png)

**Notes:**
* This script will navigate automatically to each location in the lab
* A screenshot will be taken and saved to the screenshots directory specified

#Contributors/acknowledgements
Malachi Griffith, Sorana Morrissy, Jim Robinson, Ben Ainscough, Jason Walker, Obi Griffith



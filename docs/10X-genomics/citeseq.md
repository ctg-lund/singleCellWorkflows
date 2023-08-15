# Introduction
This guide is to describe how to process data from the CiteSeq protocol. Using antibodies to tag your cells, which can help the researcher to detect things such as cell surface proteins, or pool multiple cell types together (Antibodybody Derived Tags (ADTs) or HashTag Oligonucleotides (HTOs) respectively).

At it's complicated it consists of 3 modalities(Gene Expression + ADTs + HTOs). This page aim to describe how we process it here at CTG.

## Feature reference (ADT)

The feature reference should be provided by the lab which did the experiments. How a feature reference is constructed is [described here.](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/feature-bc-analysis)

The feature reference is the file which describes these following things fo each ADT:
* id : Unique ID used to track feature counts. May only include ASCII characters and must not use whitespace, slash, quote, or comma characters. Each ID must be unique and must not collide with a gene identifier from the transcriptome
* name : Human-readable name for this feature. May only include ASCII characters and must not use whitespace, slash, quote, or comma characters. This name will be displayed in the Loupe Browser Active Feature list
* read : Specifies which RNA sequencing read contains the Feature Barcode sequence. Must be R1 or R2. Note: in most cases R2 is the correct read
* pattern : Specifies how to extract the Feature Barcode sequence from the read
* sequence : Nucleotide barcode sequence associated with this feature. E.g., antibody barcode or sgRNA protospacer sequence. 
* feature_type : Type of the feature. See the Library/Feature Types section for details on the allowed values for this field. FASTQ data specified in the Library CSV file with a library_type that matches the feature_type will be scanned for occurrences of this feature. Each feature type in the feature reference must match a library_type entry in the Libraries CSV file. This field is case-sensitive.

Example:

|id   |name |read|pattern|sequence       |feature_type        |
|-----|-----|----|-------|---------------|--------------------|
|A0001|Ms.CD4|R2  |5P(BC) |AACAAGACCCTTGAG|Antibody Capture    |
|A0002|Ms.CD8a|R2  |5P(BC) |TACCCGTAATAGCGT|Antibody Capture    |
|A0003|Ms.CD366|R2  |5P(BC) |ATTGGCACTCAGATG|Antibody Capture    |
|A0004|Ms.CD279|R2  |5P(BC) |GAAAGTCAAAGCACT|Antibody Capture    |
|A0013|Ms.Ly.6C|R2  |5P(BC) |AAGTCGTGAGGCATG|Antibody Capture    |
|A0014|HuMs.CD11b|R2  |5P(BC) |TGAAGGCTCATTTGT|Antibody Capture    |
|A0015|Ms.Ly.6G|R2  |5P(BC) |ACATTGACGCAACTA|Antibody Capture    |
|A0070|HuMs.CD49f|R2  |5P(BC) |TTCCGAGGATGATCT|Antibody Capture    |
|A0073|HuMs.CD44|R2  |5P(BC) |TGGCTTCAGGTCCTA|Antibody Capture    |

## CMO-Set (HTOs)
If you want to use cellranger multi to demultiplex the HTOs, write a cmo file like this. Otherwise they can be specified as ADT and demultiplexed with the Seurats HTO demux.
CMO_reference file:

|id   |name |read|pattern|sequence       |feature_type        |
|-----|-----|----|-------|---------------|--------------------|
|HTO1 |HTO1 |R2  |5P(BC) |ACCCACCAGTAAGAC|Multiplexing Capture|
|HTO2 |HTO2 |R2  |5P(BC) |GGTCGAGAGCATTCA|Multiplexing Capture|
|HTO3 |HTO3 |R2  |5P(BC) |CTTGCCGCATGTCAT|Multiplexing Capture|
|HTO6 |HTO6 |R2  |5P(BC) |TATGCTGCCACGGTA|Multiplexing Capture|
|HTO11|HTO11|R2  |5P(BC) |GCTTACCGAATTAAC|Multiplexing Capture|
|HTO12|HTO12|R2  |5P(BC) |CTGCAAATATAACGG|Multiplexing Capture|

## Config 
The csv file which cellranger multi takes as input
```yaml
[gene-expression]
reference,/path/to/refdata-gex-mm10-2020-A
cmo-set,/path/to/CMO_reference.csv

[feature]
reference,/path/to/HB_feature_ref.csv

[libraries]
fastq_id,fastqs,feature_types
230316_HB_1,/path/to/0_fastq,Gene Expression
230316_HB_1_ADT,/path/to/0_fastq,Antibody Capture
230316_HB_1_HTO,/path/to/0_fastq,Multiplexing Capture

[samples]
sample_id,cmo_ids
sample1,HTO1
sample2,HTO2
sample3,HTO3
sample4,HTO6
sample5,HTO11
sample6,HTO12
```
How to create a CMO-set is described more in [detail here.](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/multi)
## Cellranger multi for HTO + anything else
`singularity run --bind /root/ /path/to/cellranger.simg cellranger multi --id=230316_BM --csv=/path/to/BM_config.csv`
## ADT + GEX only
libraries.csv:
```
fastqs,sample,library_type
/path/to/fastq/GEX_Sample,GEX_Sample,Gene Expression
/path/to/fastq/ADT_Sample,GEX_Sample,Antibody Capture
```
command for running:
```
singularity run --bind /projects/ /path/to/cellranger.simg cellranger count \
	--id=Ram_014 \
	--libraries=/path/to/libraries.csv \
	--transcriptome=/path/to/refdata-gex-GRCh38-2020-A \
	--feature-ref=/path/to/TotalSeq_A_Human_Universal_Cocktail_V1_399907_Antibody_reference_UMI_counting_CellRanger.csv \
	--localmem=140 \
	--jobmode=local \
	--localcores=24
	```
	

# CTG singleCellWorkflows
## Introduction
![Logo](images/singleCellLogo.png "Logo")
This will act as the starting point for future singleCell nextflow pipelines. The thought is to develop each module to work independetly so that they will all be interchangeable in the end. 

## Status for workflows
[![10X scRNASEQ](https://img.shields.io/badge/10X-scRNAseq-brightgreen)](/subworkflows/scrnaseq.nf)
[![10X Feature Barcode](https://img.shields.io/badge/10X-Feature%20Barcode-yellow)](/subworkflows/scciteseq.nf) 
[![10X VDJ](https://img.shields.io/badge/10X-VDJ-red)](/) [![10X Flex](https://img.shields.io/badge/10X-Flex-red)](/subworkflows/flexscrnaseq.nf)


## Required inputs

* SampleSheet as formated in [the examples](/examples/CTG_SampleSheet.csv) with the following columns:
  * Sample_ID - Identifier of a project, must be the same as the file names of the fastq files.
  * Sample_Species - *human* or *mouse*
  * Sample_Project - What project a sample is associated with
  * force - If cellranger count should force the number of cells, 99% of the cases should be left as 'n', otherwise specify it as an integer.
  * agg - If all samples should be aggregated, `cellranger aggr` into the same space after. 'n' or 'y' and should be left as 'n' majority of the times.
  * pipeline - which analysis the pipeline should run
  * sample_pair - For citeseq, which fastq samples should be analysed together
  * hto - What HTO tags are used for the specific sample
  * libtype - For citeseq, what type of sample [rna/adt/hto/crispr]

## How to run
Normally:
```
nextflow run pipe-sc-rna-10x.nf --samplesheet </path/to/your/samplesheet.csv> \
    --fqdir </path/to/your/fastqs> \
```
With stub:
```bash
nextflow run main.nf --samplesheet examples/CTG_SampleSheet.csv  \
    --outdir /Users/jacobkarlstrom/Projects/singleCellWorkflows/examples/output \
    -profile local_dev \
    -stub-run \
   --analysis scflex-10x
```

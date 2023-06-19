# CTG singleCellWorkflows

<img src="images/singleCellLogo.png" alt="drawing" width="400"/>

## Introduction



Here are the single cell pipelines used by Center For Translational Genomics (CTG). They are built according to the official documentations provided by 10X genomics.

This pipeline does not do any parsing of input. We use our [samplesheet generator](https://github.com/ctg-lund/SampleSheetGenerator) to create and parse valid samplesheets.

## Status for workflows
[![10X scRNASEQ](https://img.shields.io/badge/10X-scRNAseq-brightgreen)](/subworkflows/scrnaseq.nf)
[![10X scCiteSeq](https://img.shields.io/badge/10X-scCiteSeq-brightgreen)](/subworkflows/scciteseq.nf) 
[![10X VDJ](https://img.shields.io/badge/10X-VDJ-brightgreen)](/subworkflows/scmulti.nf) [![10X Flex](https://img.shields.io/badge/10X-Flex-brightgreen)](/subworkflows/flexscrnaseq.nf)
[![10X ARC](https://img.shields.io/badge/10X-ARC-brightgreen)](/subworkflows/scarc.nf)[![10X ATAC](https://img.shields.io/badge/10X-ATAC-brightgreen)](/subworkflows/scatac.nf)
[![10X Visium](https://img.shields.io/badge/10X-Visium-brightgreen)](/subworkflows/visium.nf)

## Quick start
In production:
```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv>
```
If you are using custom references:
```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> --custom_genome </path/to/custome_genome>
```
Testing:
```bash
nextflow run main.nf --samplesheet examples/CTG_SampleSheet.csv  \
    --outdir <local/output/directory> \
    -profile local_dev -stub-run \
```
## Overview of processes
<img src="images/flowchart.pdf" alt="drawing" />

## More info
* [Project Setup](/docs/Setup.md)
* [10X RNA-seq pipeline](/docs/scrna-10x.md)
* [10X CiteSeq pipeline](/docs/scciteseq-10x.md)
* [10X Flex pipeline](/docs/scflex-10x.md)
* [10X VDJ pipeline](/docs/scmulti-10x.md)
* [10X ATAC pipeline](/docs/scatac-10x.md)
* [10X Multiome pipeline](/docs/scarc-10x.md)
* [10X Visium pipeline](/docs/scvisium-10x.md)

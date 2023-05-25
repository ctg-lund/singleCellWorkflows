# CTG singleCellWorkflows
## Introduction
![Logo](images/singleCellLogo.png "Logo")
Here are the single cell pipelines used by Center For Translational Genomics (CTG). They are built according to the official documentations provided by 10X genomics.

This pipeline does not parsing of input. We use our [samplesheet generator](https://github.com/ctg-lund/SampleSheetGenerator) to create and parse valid samplesheets.

## Status for workflows
[![10X scRNASEQ](https://img.shields.io/badge/10X-scRNAseq-brightgreen)](/subworkflows/scrnaseq.nf)
[![10X scCiteSeq](https://img.shields.io/badge/10X-scCiteSeq-brightgreen)](/subworkflows/scciteseq.nf) 
[![10X VDJ](https://img.shields.io/badge/10X-VDJ-brightgreen)](/subworkflows/scmulti.nf) [![10X Flex](https://img.shields.io/badge/10X-Flex-brightgreen)](/subworkflows/flexscrnaseq.nf)
[![10X ARC](https://img.shields.io/badge/10X-ARC-brightgreen)](/subworkflows/scarc.nf)[![10X ATAC](https://img.shields.io/badge/10X-ATAC-brightgreen)](/subworkflows/scatac.nf)

## Quick start
In production:
```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> --analysis <scrna-10x/scflex-10x/scciteseq-10x>
```
If you are using custom references:
```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> --analysis <scrna-10x/scflex-10x/scciteseq-10x> --custom_genome </path/to/custome_genome>
```
Testing:
```bash
nextflow run main.nf --samplesheet examples/CTG_SampleSheet.csv  \
    --outdir /Users/jacobkarlstrom/Projects/singleCellWorkflows/examples/output \
    -profile local_dev -stub-run \
```

## More info
* [Project Setup](/docs/Setup.md)
* [10X RNA-seq pipeline](/docs/scrna-10x.md)
* [10X CiteSeq pipeline](/docs/scciteseq-10x.md)
* [10X Flex pipeline](/docs/scflex-10x.md)

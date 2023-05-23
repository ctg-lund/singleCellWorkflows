# CTG singleCellWorkflows
## Introduction
![Logo](images/singleCellLogo.png "Logo")
Here are the single cell pipelines used by Center For Translational Genomics (CTG). They are built according to the official documentations provided by 10X genomics.

## Status for workflows
[![10X scRNASEQ](https://img.shields.io/badge/10X-scRNAseq-brightgreen)](/subworkflows/scrnaseq.nf)
[![10X scCiteSeq](https://img.shields.io/badge/10X-Feature%20Barcode-brightgreen)](/subworkflows/scciteseq.nf) 
[![10X VDJ](https://img.shields.io/badge/10X-VDJ-red)](/) [![10X Flex](https://img.shields.io/badge/10X-Flex-brightgreen)](/subworkflows/flexscrnaseq.nf)

## Quick start
In production:
```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> --analysis <scrna-10x/scflex-10x/scciteseq-10x>
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
